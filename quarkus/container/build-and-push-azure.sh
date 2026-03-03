#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DIST_FILE="${DIST_FILE:-$SCRIPT_DIR/../dist/target/keycloak-26.5.4.tar.gz}"
PLATFORM="${PLATFORM:-linux/amd64}"
REGISTRY="${REGISTRY:-loctroicr.azurecr.io}"
IMAGE_REPO="${IMAGE_REPO:-loctroi/keycloak}"
UEF_REV="${UEF_REV:-1}"
IMAGE_TAG="${IMAGE_TAG:-}"
TAG_WITH_SHA="${TAG_WITH_SHA:-false}"
ADD_CHANNEL_TAGS="${ADD_CHANNEL_TAGS:-true}"
INCLUDE_PLAIN_LATEST="${INCLUDE_PLAIN_LATEST:-false}"

if [[ ! -f "$DIST_FILE" ]]; then
   echo "Distribution file not found: $DIST_FILE"
   echo "Build it first: ./mvnw -f quarkus/dist/pom.xml clean install -DskipTests"
   exit 1
fi

DIST_NAME="$(basename "$DIST_FILE")"
cp -f "$DIST_FILE" "$SCRIPT_DIR/$DIST_NAME"

BASE_VERSION="${DIST_NAME#keycloak-}"
BASE_VERSION="${BASE_VERSION%.tar.gz}"
MAJOR_MINOR="${BASE_VERSION%.*}"

if [[ -z "$IMAGE_TAG" ]]; then
   IMAGE_TAG="${BASE_VERSION}-uef.${UEF_REV}"
fi

if [[ "$TAG_WITH_SHA" == "true" ]] && git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
   GIT_SHA="$(git rev-parse --short HEAD)"
   IMAGE_TAG="${IMAGE_TAG}-g${GIT_SHA}"
fi

if [[ -n "${DOCKER_USERNAME:-}" && -n "${DOCKER_PASSWORD:-}" ]]; then
   echo "$DOCKER_PASSWORD" | docker login "$REGISTRY" -u "$DOCKER_USERNAME" --password-stdin
else
   echo "Skipping docker login (set DOCKER_USERNAME and DOCKER_PASSWORD to login automatically)."
fi

TAG_ARGS=(
   -t "$REGISTRY/$IMAGE_REPO:$IMAGE_TAG"
)

if [[ "$ADD_CHANNEL_TAGS" == "true" ]]; then
   TAG_ARGS+=(
      -t "$REGISTRY/$IMAGE_REPO:${BASE_VERSION}-uef"
      -t "$REGISTRY/$IMAGE_REPO:${MAJOR_MINOR}-uef"
      -t "$REGISTRY/$IMAGE_REPO:latest-uef"
   )
fi

if [[ "$INCLUDE_PLAIN_LATEST" == "true" ]]; then
   TAG_ARGS+=(-t "$REGISTRY/$IMAGE_REPO:latest")
fi

docker buildx build --platform "$PLATFORM" \
   -f "$SCRIPT_DIR/Dockerfile" \
   --build-arg "KEYCLOAK_DIST=$DIST_NAME" \
   "${TAG_ARGS[@]}" \
   "$SCRIPT_DIR" --push

echo "Done: $REGISTRY/$IMAGE_REPO:$IMAGE_TAG"


