# Instrucciones para Subir Imágenes a DockerHub

## Opción 1: Usando el Script Automatizado

### En Windows:
```bash
push-to-dockerhub.bat TU_USUARIO_DOCKERHUB
```

### En Linux/Mac:
```bash
chmod +x push-to-dockerhub.sh
./push-to-dockerhub.sh TU_USUARIO_DOCKERHUB
```

---

## Opción 2: Paso a Paso Manual

### 1. Iniciar sesión en DockerHub

```bash
docker login
```

Te pedirá tu usuario y contraseña de DockerHub.

### 2. Etiquetar las imágenes

Reemplaza `TU_USUARIO` con tu nombre de usuario de DockerHub:

```bash
# Etiquetar imagen de la aplicación
docker tag crud_docker-app:latest TU_USUARIO/crud-app:latest
docker tag crud_docker-app:latest TU_USUARIO/crud-app:1.0

# Etiquetar imagen de la base de datos
docker tag crud_docker-db:latest TU_USUARIO/postgres-crud:latest
docker tag crud_docker-db:latest TU_USUARIO/postgres-crud:1.0
```

### 3. Subir las imágenes a DockerHub

```bash
# Subir imagen de la aplicación
docker push TU_USUARIO/crud-app:latest
docker push TU_USUARIO/crud-app:1.0

# Subir imagen de la base de datos
docker push TU_USUARIO/postgres-crud:latest
docker push TU_USUARIO/postgres-crud:1.0
```

### 4. Verificar en DockerHub

Visita https://hub.docker.com/ y verifica que tus imágenes estén publicadas.

---

## Opción 3: Crear un docker-compose.yml para DockerHub

Si quieres que otros usuarios puedan usar tus imágenes desde DockerHub, crea un archivo `docker-compose-hub.yml`:

```yaml
version: '3.8'

services:
  db:
    image: TU_USUARIO/postgres-crud:latest
    container_name: postgres_db
    environment:
      POSTGRES_DB: cruddb
      POSTGRES_USER: postgres
      POSTGRES_PASSWORD: postgres
    ports:
      - "5432:5432"
    volumes:
      - postgres_data:/var/lib/postgresql/data
    networks:
      - crud_network
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U postgres"]
      interval: 10s
      timeout: 5s
      retries: 5

  app:
    image: TU_USUARIO/crud-app:latest
    container_name: crud_app
    environment:
      DB_HOST: db
      DB_PORT: 5432
      DB_NAME: cruddb
      DB_USER: postgres
      DB_PASSWORD: postgres
    ports:
      - "3000:3000"
    depends_on:
      db:
        condition: service_healthy
    networks:
      - crud_network
    restart: unless-stopped

volumes:
  postgres_data:
    driver: local

networks:
  crud_network:
    driver: bridge
```

Luego los usuarios pueden ejecutar:

```bash
docker-compose -f docker-compose-hub.yml up -d
```

---

## Comandos Útiles

### Ver imágenes locales
```bash
docker images
```

### Eliminar una imagen local
```bash
docker rmi NOMBRE_IMAGEN:TAG
```

### Descargar imagen desde DockerHub
```bash
docker pull TU_USUARIO/crud-app:latest
docker pull TU_USUARIO/postgres-crud:latest
```

### Ver imágenes en DockerHub (desde línea de comandos)
Necesitas instalar `docker-hub-utils`:
```bash
npm install -g docker-hub-utils
docker-hub search TU_USUARIO
```

---

## Notas Importantes

1. **Seguridad**: No subas imágenes con información sensible (contraseñas, API keys, etc.)
2. **Tamaño**: Las imágenes grandes tardan más en subir. Optimiza tus Dockerfiles.
3. **Versionado**: Usa tags descriptivos (1.0, 1.1, latest, etc.)
4. **Documentación**: Añade un README.md en tu repositorio de DockerHub
5. **Privacidad**: Por defecto las imágenes son públicas. Puedes hacer repositorios privados en DockerHub (limitado en cuenta gratuita)

---

## Ejemplo de Comandos Completos

```bash
# 1. Login
docker login

# 2. Etiquetar
docker tag crud_docker-app:latest miusuario/crud-app:latest
docker tag crud_docker-db:latest miusuario/postgres-crud:latest

# 3. Push
docker push miusuario/crud-app:latest
docker push miusuario/postgres-crud:latest

# 4. Verificar (en otra máquina)
docker pull miusuario/crud-app:latest
docker pull miusuario/postgres-crud:latest
```

---

## Recursos Adicionales

- [Documentación oficial de DockerHub](https://docs.docker.com/docker-hub/)
- [Guía de buenas prácticas para imágenes Docker](https://docs.docker.com/develop/dev-best-practices/)
- [Docker Hub](https://hub.docker.com/)
