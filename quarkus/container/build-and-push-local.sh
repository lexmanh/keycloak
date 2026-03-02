#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DIST_FILE="${DIST_FILE:-$SCRIPT_DIR/../dist/target/keycloak-26.5.4.tar.gz}"
PLATFORM="${PLATFORM:-linux/amd64}"
REGISTRY="${REGISTRY:-cr.uef.edu.vn}"
IMAGE_REPO="${IMAGE_REPO:-uef/keycloak}"
IMAGE_TAG="${IMAGE_TAG:-1.0.15}"
PUSH_IMAGE="${PUSH_IMAGE:-true}"

if [[ ! -f "$DIST_FILE" ]]; then
   echo "Distribution file not found: $DIST_FILE"
   echo "Build it first: ./mvnw -f quarkus/dist/pom.xml clean install -DskipTests"
   exit 1
fi

DIST_NAME="$(basename "$DIST_FILE")"
cp -f "$DIST_FILE" "$SCRIPT_DIR/$DIST_NAME"

if [[ -n "${DOCKER_USERNAME:-}" && -n "${DOCKER_PASSWORD:-}" ]]; then
   echo "$DOCKER_PASSWORD" | docker login "$REGISTRY" -u "$DOCKER_USERNAME" --password-stdin
else
   echo "Skipping docker login (set DOCKER_USERNAME and DOCKER_PASSWORD to login automatically)."
fi

PUSH_FLAG="--load"
if [[ "$PUSH_IMAGE" == "true" ]]; then
   PUSH_FLAG="--push"
fi

docker buildx build --platform "$PLATFORM" \
   -f "$SCRIPT_DIR/Dockerfile" \
   --build-arg "KEYCLOAK_DIST=$DIST_NAME" \
   -t "$REGISTRY/$IMAGE_REPO:$IMAGE_TAG" \
   -t "$REGISTRY/$IMAGE_REPO:latest" \
   "$SCRIPT_DIR" $PUSH_FLAG

echo "Done: $REGISTRY/$IMAGE_REPO:$IMAGE_TAG"


