echo "Build keycloak distribution"
../../mvnw -f ../../pom.xml clean install -DskipTestsuite -DskipExamples -DskipTests

echo "Copy latest keycloak distribution to container folder"
cp -f ../dist/target/keycloak-999.0.0-SNAPSHOT.tar.gz .

echo "Login to local registry"
docker login cr-app.loctroi.vn -u developer -p Harbor12345

echo "Build and push baget to local registry"
docker buildx build --platform "linux/amd64" \
   -f ./Dockerfile \
   --build-arg KEYCLOAK_DIST=keycloak-999.0.0-SNAPSHOT.tar.gz \
   -t cr-app.loctroi.vn/loctroi/keycloak:latest \
   . --push


