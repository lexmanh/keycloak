echo "Build keycloak distribution"
#../../mvnw -f ../../pom.xml clean install -DskipTestsuite -DskipExamples -DskipTests

echo "Copy latest keycloak distribution to container folder"
cp -f ../dist/target/keycloak-999.0.0-SNAPSHOT.tar.gz .

echo "Login to local registry"
docker login cr.uef.edu.vn

echo "Build and push baget to local registry"
docker buildx build --platform "linux/amd64" \
   -f ./Dockerfile \
   --build-arg KEYCLOAK_DIST=keycloak-999.0.0-SNAPSHOT.tar.gz \
   -t cr.uef.edu.vn/uef/keycloak:1.0.11\
   -t cr.uef.edu.vn/uef/keycloak:latest \
   . --push


