# Solución de Problemas Comunes

## Error: "The container name is already in use"

```
Error response from daemon: Conflict. The container name "/postgres_db" is already in use
```

### Causa
Ya existe un contenedor con ese nombre de una ejecución anterior.

### Solución Rápida

**Windows:**
```bash
reset.bat
```

**Linux/Mac:**
```bash
chmod +x reset.sh
./reset.sh
```

### Solución Manual

**Opción 1: Limpieza completa (RECOMENDADO)**
```bash
# Detener y eliminar todo
docker-compose down
docker rm -f postgres_db crud_app
docker volume rm crud_docker_postgres_data

# Levantar de nuevo
docker-compose up -d
```

**Opción 2: Solo eliminar contenedores**
```bash
docker stop postgres_db crud_app
docker rm postgres_db crud_app
docker-compose up -d
```

---

## La Base de Datos está Vacía (no hay productos)

### Causa
El volumen de PostgreSQL ya existía de una ejecución anterior. El script `init.sql` solo se ejecuta cuando el volumen se crea por primera vez.

### Solución

**Windows:**
```bash
reset.bat
```

**Linux/Mac:**
```bash
./reset.sh
```

**O manualmente:**
```bash
docker-compose down -v  # -v elimina los volúmenes
docker-compose up -d
```

Esto eliminará los volúmenes antiguos y creará nuevos con los 20 productos de ejemplo.

---

## Error: "port is already allocated"

```
Error: bind: address already in use
```

### Causa
El puerto 3000 o 5432 ya está siendo usado por otro proceso.

### Solución

**Ver qué está usando el puerto:**

Windows:
```bash
netstat -ano | findstr :3000
netstat -ano | findstr :5432
```

Linux/Mac:
```bash
lsof -i :3000
lsof -i :5432
```

**Opciones:**

1. **Detener el proceso que usa el puerto**
2. **Cambiar el puerto en docker-compose.yml:**

```yaml
services:
  app:
    ports:
      - "3001:3000"  # Cambiar 3000 a 3001
  db:
    ports:
      - "5433:5432"  # Cambiar 5432 a 5433
```

---

## Los Cambios en el Código No se Reflejan

### Causa
Docker está usando imágenes antiguas en caché.

### Solución

```bash
docker-compose down
docker-compose build --no-cache
docker-compose up -d
```

---

## Error: "docker-compose: command not found"

### Causa
Docker Compose no está instalado o no está en el PATH.

### Solución

**Si tienes Docker Desktop instalado:**

Usa `docker compose` (con espacio) en lugar de `docker-compose`:

```bash
docker compose up -d
docker compose down
```

**Si no tienes Docker Desktop:**

Instala Docker Compose:
```bash
# Linux
sudo apt-get install docker-compose

# Mac
brew install docker-compose

# Windows
# Descarga e instala Docker Desktop
```

---

## No Puedo Conectarme a la Base de Datos

### Verificar que el contenedor esté corriendo

```bash
docker ps
```

Deberías ver `postgres_db` y `crud_app` en la lista.

### Ver logs de la base de datos

```bash
docker logs postgres_db
```

### Verificar el healthcheck

```bash
docker inspect postgres_db | grep -A 10 Health
```

### Solución

Si el contenedor no está healthy después de 30 segundos:

```bash
docker-compose down -v
docker-compose up -d
docker-compose logs -f db
```

---

## La Aplicación Muestra "Cannot connect to database"

### Verificar que ambos contenedores estén corriendo

```bash
docker ps
```

### Verificar los logs de la aplicación

```bash
docker logs crud_app
```

### Solución

1. Espera unos segundos a que la BD termine de inicializar
2. Si después de 1 minuto sigue el error:

```bash
docker-compose restart app
```

---

## Comandos Útiles para Debugging

### Ver todos los contenedores (incluyendo detenidos)
```bash
docker ps -a
```

### Ver logs en tiempo real
```bash
docker-compose logs -f
docker-compose logs -f app
docker-compose logs -f db
```

### Entrar a la base de datos
```bash
docker exec -it postgres_db psql -U postgres -d cruddb
```

Comandos SQL útiles:
```sql
-- Ver productos
SELECT * FROM productos;

-- Contar productos
SELECT COUNT(*) FROM productos;

-- Salir
\q
```

### Limpiar todo Docker (⚠ CUIDADO: elimina TODO)
```bash
docker system prune -a --volumes
```

### Ver uso de espacio en Docker
```bash
docker system df
```

---

## Reinstalación Completa

Si nada funciona, reinstala desde cero:

**Windows:**
```bash
# Eliminar todo
docker-compose down -v
docker rm -f postgres_db crud_app
docker rmi crud_docker-app crud_docker-db
docker volume prune -f

# Volver a construir
docker-compose build --no-cache
docker-compose up -d
```

**O usa el script reset:**
```bash
reset.bat  # Windows
./reset.sh # Linux/Mac
```

---

## Obtener Ayuda

Si sigues teniendo problemas:

1. Revisa los logs: `docker-compose logs -f`
2. Verifica que Docker Desktop esté corriendo
3. Verifica que tengas permisos de administrador
4. Crea un issue en GitHub con:
   - El error completo
   - Los logs: `docker-compose logs`
   - Tu sistema operativo
   - Versión de Docker: `docker --version`

---

## Scripts Útiles Incluidos

- `reset.bat` / `reset.sh` - Reinicia todo con datos frescos
- `push-to-dockerhub.bat` / `push-to-dockerhub.sh` - Sube imágenes a DockerHub

---

## Verificación Rápida

Todo está funcionando si:

1. `docker ps` muestra 2 contenedores corriendo
2. http://localhost:3000 carga la interfaz web
3. http://localhost:3000/api/productos devuelve JSON con 20 productos
4. Puedes crear, editar y eliminar productos desde la interfaz

Si alguno falla, revisa esta guía.
