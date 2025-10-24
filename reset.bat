@echo off
REM Script para reiniciar completamente la aplicación CRUD con datos frescos
REM Uso: reset.bat

echo ========================================
echo  Reiniciando Aplicacion CRUD
echo ========================================
echo.

echo [1/4] Deteniendo contenedores...
docker-compose down

echo.
echo [2/4] Eliminando contenedores antiguos si existen...
docker rm -f postgres_db crud_app 2>nul

echo.
echo [3/4] Eliminando volumenes (esto borrara los datos)...
docker volume rm crud_docker_postgres_data 2>nul

echo.
echo [4/4] Levantando contenedores con datos frescos...
docker-compose up -d

echo.
echo ========================================
echo  Completado!
echo ========================================
echo.
echo La aplicacion esta disponible en:
echo   http://localhost:3000
echo.
echo Para ver los logs:
echo   docker-compose logs -f
echo.

pause
