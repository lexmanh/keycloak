#!/usr/bin/env bash

set -euo pipefail

IMAGE="${IMAGE:-cr.uef.edu.vn/uef/keycloak:26.5.4-uef.1}"
CONTAINER_NAME="${CONTAINER_NAME:-kc-dev-webauthn-smoke}"
HOST_PORT="${HOST_PORT:-19080}"
ADMIN_USER="${ADMIN_USER:-admin}"
ADMIN_PASS="${ADMIN_PASS:-admin123}"
REALM="${REALM:-master}"
CLIENT_ID="${CLIENT_ID:-security-admin-console}"
REDIRECT_URI="${REDIRECT_URI:-https://localhost/admin/master/console/}"
THEME_DIR="${THEME_DIR:-themes/src/main/resources/theme/university}"
TEST_PASSWORD="${TEST_PASSWORD:-Passw0rd123}"
KEEP_CONTAINER="${KEEP_CONTAINER:-0}"

BASE_URL="http://localhost:${HOST_PORT}"
COOKIE_FILE="/tmp/kc-webauthn-cookie-${HOST_PORT}.txt"
AUTH_BODY_FILE="/tmp/kc-webauthn-auth-body-${HOST_PORT}.html"
SUBMIT_HEADERS_FILE="/tmp/kc-webauthn-submit-headers-${HOST_PORT}.txt"
REQUIRED_ACTION_BODY_FILE="/tmp/kc-webauthn-required-action-${HOST_PORT}.html"

cleanup() {
  if [[ "$KEEP_CONTAINER" != "1" ]]; then
    docker rm -f "$CONTAINER_NAME" >/dev/null 2>&1 || true
  fi
}

if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  echo "Run this script inside the keycloak git repository"
  exit 1
fi

if [[ ! -d "$THEME_DIR" ]]; then
  echo "Theme directory not found: $THEME_DIR"
  exit 1
fi

trap cleanup EXIT

echo "[1/7] Starting container $CONTAINER_NAME on port $HOST_PORT"
docker rm -f "$CONTAINER_NAME" >/dev/null 2>&1 || true
docker run -d \
  --name "$CONTAINER_NAME" \
  -p "${HOST_PORT}:8080" \
  -e KC_BOOTSTRAP_ADMIN_USERNAME="$ADMIN_USER" \
  -e KC_BOOTSTRAP_ADMIN_PASSWORD="$ADMIN_PASS" \
  -v "$PWD/$THEME_DIR:/opt/keycloak/themes/university" \
  "$IMAGE" \
  start-dev --http-enabled=true --proxy-headers=xforwarded --hostname-strict=false >/dev/null

echo "[2/7] Waiting for server readiness"
curl -fsS --retry 60 --retry-delay 2 --retry-connrefused --max-time 5 \
  "$BASE_URL/realms/${REALM}/.well-known/openid-configuration" \
  -H 'X-Forwarded-Proto: https' >/dev/null

echo "[3/7] Getting admin token"
ADMIN_TOKEN="$(
  curl -sS --max-time 10 -X POST "$BASE_URL/realms/${REALM}/protocol/openid-connect/token" \
    -H 'Content-Type: application/x-www-form-urlencoded' \
    -H 'X-Forwarded-Proto: https' \
    -d "client_id=admin-cli" \
    -d "grant_type=password" \
    -d "username=${ADMIN_USER}" \
    -d "password=${ADMIN_PASS}" | \
  python3 -c 'import json,sys; print(json.load(sys.stdin)["access_token"])'
)"

TEST_USER="webauthn_smoke_$(date +%s)"
echo "[4/7] Creating test user $TEST_USER with required action webauthn-register"
CREATE_HTTP="$(
  curl -sS --max-time 10 -X POST "$BASE_URL/admin/realms/${REALM}/users" \
    -H "Authorization: Bearer $ADMIN_TOKEN" \
    -H 'X-Forwarded-Proto: https' \
    -H 'Content-Type: application/json' \
    --data "{\"username\":\"$TEST_USER\",\"enabled\":true,\"requiredActions\":[\"webauthn-register\"],\"credentials\":[{\"type\":\"password\",\"value\":\"$TEST_PASSWORD\",\"temporary\":false}]}" \
    -o /dev/null -w '%{http_code}'
)"

if [[ "$CREATE_HTTP" != "201" ]]; then
  echo "Failed to create test user (HTTP $CREATE_HTTP)"
  exit 1
fi

echo "[5/7] Opening auth page and extracting login action"
rm -f "$COOKIE_FILE" "$AUTH_BODY_FILE" "$SUBMIT_HEADERS_FILE" "$REQUIRED_ACTION_BODY_FILE"

CODE_VERIFIER='smokeverifier123'
CODE_CHALLENGE="$(python3 - <<'PY'
import hashlib,base64
value='smokeverifier123'.encode()
digest=hashlib.sha256(value).digest()
print(base64.urlsafe_b64encode(digest).rstrip(b'=').decode())
PY
)"

REDIRECT_URI_ENCODED="$(python3 - <<PY
import urllib.parse
print(urllib.parse.quote('${REDIRECT_URI}', safe=''))
PY
)"

AUTH_URL="${BASE_URL}/realms/${REALM}/protocol/openid-connect/auth?client_id=${CLIENT_ID}&redirect_uri=${REDIRECT_URI_ENCODED}&response_type=code&scope=openid&code_challenge_method=S256&code_challenge=${CODE_CHALLENGE}"

curl -sS --max-time 10 \
  -c "$COOKIE_FILE" -b "$COOKIE_FILE" \
  -H 'X-Forwarded-Proto: https' \
  "$AUTH_URL" > "$AUTH_BODY_FILE"

LOGIN_ACTION="$(grep -o '/realms/.*/login-actions/authenticate[^" ]*' "$AUTH_BODY_FILE" | head -n 1 | sed 's/&amp;/\&/g')"

if [[ -z "$LOGIN_ACTION" ]]; then
  echo "Could not find login action in auth page"
  exit 1
fi

echo "[6/7] Submitting login and following required-action redirect"
curl -sS --max-time 10 \
  -D "$SUBMIT_HEADERS_FILE" \
  -c "$COOKIE_FILE" -b "$COOKIE_FILE" \
  -H 'Content-Type: application/x-www-form-urlencoded' \
  -H 'X-Forwarded-Proto: https' \
  --data-urlencode "username=$TEST_USER" \
  --data-urlencode "password=$TEST_PASSWORD" \
  --data-urlencode 'credentialId=' \
  "${BASE_URL}${LOGIN_ACTION}" >/dev/null

NEXT_LOCATION="$(sed -n 's/^Location: //p' "$SUBMIT_HEADERS_FILE" | tr -d '\r' | head -n 1)"
NEXT_PATH="${NEXT_LOCATION#https://localhost}"

if [[ -z "$NEXT_PATH" ]]; then
  echo "Missing required-action redirect location"
  exit 1
fi

curl -sS --max-time 10 \
  -c "$COOKIE_FILE" -b "$COOKIE_FILE" \
  -H 'X-Forwarded-Proto: https' \
  "${BASE_URL}${NEXT_PATH}" > "$REQUIRED_ACTION_BODY_FILE"

echo "[7/7] Validating rendered page and logs"
if ! grep -q 'data-page-id="login-webauthn-register"' "$REQUIRED_ACTION_BODY_FILE"; then
  echo "WebAuthn register page marker not found"
  exit 1
fi

if docker logs --since 10m "$CONTAINER_NAME" 2>&1 | grep -qE 'Failed to process template webauthn-register.ftl|NonStringOrTemplateOutputException|HTTP 500 Internal Server Error'; then
  echo "Detected template/500 errors in logs"
  exit 1
fi

echo "PASS: WebAuthn required-action page renders without template 500"
echo "Test user: $TEST_USER"
