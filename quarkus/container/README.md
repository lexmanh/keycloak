# Keycloak Image
For more information, see the [Running Keycloak in a container guide](https://www.keycloak.org/server/containers).

## Build the image

It is possible to download the Keycloak distribution from GitHub:

    docker build --build-arg KEYCLOAK_VERSION=<VERSION> -t <YOUR_TAG> .

It is possible to download the Keycloak distribution from a URL:

    docker build --build-arg KEYCLOAK_DIST=http://<HOST>:<PORT>/keycloak-<VERSION>.tar.gz -t <YOUR_TAG> .

Alternatively, you need to build the local distribution first, then copy the distributions tar package in the `container` folder and point the build command to use the image:

    cp $KEYCLOAK_SOURCE/quarkus/dist/target/keycloak-<VERSION>.tar.gz .
    docker build --build-arg KEYCLOAK_DIST=keycloak-<VERSION>.tar.gz -t <YOUR_TAG> .

## UEF tag convention for build-and-push scripts

The helper scripts in this folder (`build-and-push-local.sh`, `build-and-push-azure.sh`, `build-and-push-dockerhub.sh`) now generate tags based on the Keycloak upstream distribution version.

Default immutable release tag format:

- `<upstream-version>-uef.<revision>`
- Example: `26.5.4-uef.1`

Default channel tags (mutable):

- `<upstream-version>-uef` (example: `26.5.4-uef`)
- `<major.minor>-uef` (example: `26.5-uef`)
- `latest-uef`

Optional settings:

- `UEF_REV=2` to publish `26.5.4-uef.2`
- `TAG_WITH_SHA=true` to append `-g<shortsha>`
- `INCLUDE_PLAIN_LATEST=true` to also publish `latest` (not recommended for production)

Example:

    UEF_REV=2 TAG_WITH_SHA=true bash quarkus/container/build-and-push-local.sh
