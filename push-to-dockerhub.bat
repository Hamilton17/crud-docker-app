@echo off
REM Script para subir imágenes a DockerHub (Windows)
REM Uso: push-to-dockerhub.bat <tu-usuario-dockerhub>

if "%1"=="" (
    echo Error: Debes proporcionar tu usuario de DockerHub
    echo Uso: push-to-dockerhub.bat ^<tu-usuario-dockerhub^>
    exit /b 1
)

set DOCKERHUB_USER=%1

echo ========================================
echo   Subiendo imagenes a DockerHub
echo   Usuario: %DOCKERHUB_USER%
echo ========================================
echo.

REM Login a DockerHub
echo 1. Iniciando sesion en DockerHub...
docker login
if %errorlevel% neq 0 (
    echo Error: Fallo el login a DockerHub
    exit /b 1
)

echo.
echo 2. Etiquetando imagen de la aplicacion...
docker tag crud_docker-app:latest %DOCKERHUB_USER%/crud-app:latest
docker tag crud_docker-app:latest %DOCKERHUB_USER%/crud-app:1.0

echo.
echo 3. Etiquetando imagen de la base de datos...
docker tag crud_docker-db:latest %DOCKERHUB_USER%/postgres-crud:latest
docker tag crud_docker-db:latest %DOCKERHUB_USER%/postgres-crud:1.0

echo.
echo 4. Subiendo imagen de la aplicacion...
docker push %DOCKERHUB_USER%/crud-app:latest
docker push %DOCKERHUB_USER%/crud-app:1.0

echo.
echo 5. Subiendo imagen de la base de datos...
docker push %DOCKERHUB_USER%/postgres-crud:latest
docker push %DOCKERHUB_USER%/postgres-crud:1.0

echo.
echo ========================================
echo   Imagenes subidas exitosamente!
echo ========================================
echo.
echo Tus imagenes estan disponibles en:
echo   - https://hub.docker.com/r/%DOCKERHUB_USER%/crud-app
echo   - https://hub.docker.com/r/%DOCKERHUB_USER%/postgres-crud
echo.
echo Para usar estas imagenes en otro lugar:
echo   docker pull %DOCKERHUB_USER%/crud-app:latest
echo   docker pull %DOCKERHUB_USER%/postgres-crud:latest
echo.

pause
