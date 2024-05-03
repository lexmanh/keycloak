echo "Copy latest keycloak distribution to container folder"
cp -f ../dist/target/keycloak-999.0.0-SNAPSHOT.tar.gz .

echo "Login to Azure registry"
docker login loctroicr.azurecr.io -u loctroicr -p tnTG=63QuvioLq=PrUveQSWiwQ4ed6qM

echo "Build and push baget to local registry"
docker buildx build --platform "linux/amd64" \
   -f ./Dockerfile \
   --build-arg KEYCLOAK_DIST=keycloak-999.0.0-SNAPSHOT.tar.gz \
   -t loctroicr.azurecr.io/loctroi/keycloak:latest \
   . --push


