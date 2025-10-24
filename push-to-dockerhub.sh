#!/bin/bash

# Script para subir imágenes a DockerHub
# Uso: ./push-to-dockerhub.sh <tu-usuario-dockerhub>

if [ -z "$1" ]; then
    echo "Error: Debes proporcionar tu usuario de DockerHub"
    echo "Uso: ./push-to-dockerhub.sh <tu-usuario-dockerhub>"
    exit 1
fi

DOCKERHUB_USER=$1

echo "========================================"
echo "  Subiendo imágenes a DockerHub"
echo "  Usuario: $DOCKERHUB_USER"
echo "========================================"
echo ""

# Login a DockerHub
echo "1. Iniciando sesión en DockerHub..."
docker login
if [ $? -ne 0 ]; then
    echo "Error: Fallo el login a DockerHub"
    exit 1
fi

echo ""
echo "2. Etiquetando imagen de la aplicación..."
docker tag crud_docker-app:latest $DOCKERHUB_USER/crud-app:latest
docker tag crud_docker-app:latest $DOCKERHUB_USER/crud-app:1.0

echo ""
echo "3. Etiquetando imagen de la base de datos..."
docker tag crud_docker-db:latest $DOCKERHUB_USER/postgres-crud:latest
docker tag crud_docker-db:latest $DOCKERHUB_USER/postgres-crud:1.0

echo ""
echo "4. Subiendo imagen de la aplicación..."
docker push $DOCKERHUB_USER/crud-app:latest
docker push $DOCKERHUB_USER/crud-app:1.0

echo ""
echo "5. Subiendo imagen de la base de datos..."
docker push $DOCKERHUB_USER/postgres-crud:latest
docker push $DOCKERHUB_USER/postgres-crud:1.0

echo ""
echo "========================================"
echo "  Imágenes subidas exitosamente!"
echo "========================================"
echo ""
echo "Tus imágenes están disponibles en:"
echo "  - https://hub.docker.com/r/$DOCKERHUB_USER/crud-app"
echo "  - https://hub.docker.com/r/$DOCKERHUB_USER/postgres-crud"
echo ""
echo "Para usar estas imágenes en otro lugar:"
echo "  docker pull $DOCKERHUB_USER/crud-app:latest"
echo "  docker pull $DOCKERHUB_USER/postgres-crud:latest"
echo ""
