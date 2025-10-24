# CRUD Application con Docker + PostgreSQL

Aplicación web CRUD (Create, Read, Update, Delete) para gestión de productos, containerizada con Docker y Docker Compose.

![Docker](https://img.shields.io/badge/Docker-2496ED?style=for-the-badge&logo=docker&logoColor=white)
![PostgreSQL](https://img.shields.io/badge/PostgreSQL-316192?style=for-the-badge&logo=postgresql&logoColor=white)
![Node.js](https://img.shields.io/badge/Node.js-43853D?style=for-the-badge&logo=node.js&logoColor=white)
![Express.js](https://img.shields.io/badge/Express.js-404D59?style=for-the-badge)

## Inicio Rápido

```bash
# 1. Clonar el repositorio
git clone https://github.com/TU_USUARIO/TU_REPOSITORIO.git
cd TU_REPOSITORIO

# 2. Levantar los contenedores
docker-compose up -d

# 3. Abrir en el navegador
# http://localhost:3000
```

Eso es todo! La aplicación estará corriendo con **20 productos pre-cargados** en la base de datos.

### ⚠ Nota Importante: Si la Base de Datos está Vacía

El script `init.sql` solo se ejecuta cuando el volumen de PostgreSQL se crea por primera vez. Si ya ejecutaste `docker-compose up` antes, el volumen ya existe y los datos no se insertarán.

**Solución:**
```bash
docker-compose down -v  # Eliminar volúmenes
docker-compose up -d    # Crear volúmenes nuevos con datos
```

## Tecnologías Utilizadas

- **Frontend**: HTML5, CSS3, JavaScript (Vanilla)
- **Backend**: Node.js + Express.js
- **Base de Datos**: PostgreSQL 15
- **Containerización**: Docker + Docker Compose

## Estructura del Proyecto

```
crud_docker/
├── app/
│   ├── public/
│   │   ├── index.html      # Interfaz de usuario
│   │   ├── styles.css      # Estilos CSS
│   │   └── app.js          # Lógica del frontend
│   ├── server.js           # Servidor Express + API REST
│   ├── package.json        # Dependencias de Node.js
│   ├── Dockerfile          # Imagen Docker para la app
│   └── .dockerignore       # Archivos excluidos del build
├── database/
│   ├── init.sql            # Script de inicialización de BD
│   └── Dockerfile          # Imagen Docker para PostgreSQL
├── docker-compose.yml      # Orquestación de servicios
└── README.md              # Este archivo
```

## Características

- CRUD completo de productos (Crear, Leer, Actualizar, Eliminar)
- Interfaz moderna y responsive
- API RESTful
- Base de datos PostgreSQL con **20 productos de ejemplo pre-cargados**
- Contenedores Docker independientes para app y BD
- Persistencia de datos con volúmenes Docker
- Validaciones de datos en la base de datos
- Índices para optimizar búsquedas

## Requisitos Previos

- Docker instalado ([Descargar Docker](https://www.docker.com/products/docker-desktop))
- Docker Compose instalado (incluido con Docker Desktop)

## Instalación y Uso

### Opción 1: Inicio Rápido (Recomendado)

```bash
# Clonar el repositorio
git clone https://github.com/TU_USUARIO/TU_REPOSITORIO.git
cd TU_REPOSITORIO

# Levantar contenedores en segundo plano
docker-compose up -d

# Ver logs (opcional)
docker-compose logs -f
```

Accede a la aplicación en: http://localhost:3000

### Opción 2: Modo desarrollo (con logs visibles)

```bash
# Clonar y entrar al directorio
git clone https://github.com/TU_USUARIO/TU_REPOSITORIO.git
cd TU_REPOSITORIO

# Levantar con logs en consola
docker-compose up --build
```

Presiona `Ctrl+C` para detener los contenedores.

### Detener los contenedores

```bash
docker-compose down
```

### 5. Detener y eliminar volúmenes (elimina datos)

```bash
docker-compose down -v
```

## Comandos Útiles

### Ver logs de los contenedores
```bash
docker-compose logs -f
```

### Ver logs de un servicio específico
```bash
docker-compose logs -f app
docker-compose logs -f db
```

### Reconstruir las imágenes
```bash
docker-compose build --no-cache
```

### Listar contenedores activos
```bash
docker ps
```

### Acceder a la base de datos
```bash
docker exec -it postgres_db psql -U postgres -d cruddb
```

## API Endpoints

| Método | Endpoint | Descripción |
|--------|----------|-------------|
| GET | `/api/productos` | Obtener todos los productos |
| GET | `/api/productos/:id` | Obtener un producto por ID |
| POST | `/api/productos` | Crear un nuevo producto |
| PUT | `/api/productos/:id` | Actualizar un producto |
| DELETE | `/api/productos/:id` | Eliminar un producto |

### Ejemplo de Body para POST/PUT

```json
{
  "nombre": "Producto Ejemplo",
  "precio": 99.99,
  "cantidad": 10
}
```

## Subir Imagen a DockerHub

### 1. Login en DockerHub
```bash
docker login
```

### 2. Etiquetar la imagen de la aplicación
```bash
docker tag crud_app:latest tu-usuario/crud-app:latest
```

### 3. Subir la imagen
```bash
docker push tu-usuario/crud-app:latest
```

### 4. Etiquetar y subir la imagen de la base de datos
```bash
docker tag postgres_db:latest tu-usuario/postgres-crud:latest
docker push tu-usuario/postgres-crud:latest
```

## Variables de Entorno

Las variables de entorno están configuradas en `docker-compose.yml`:

- `POSTGRES_DB`: Nombre de la base de datos
- `POSTGRES_USER`: Usuario de PostgreSQL
- `POSTGRES_PASSWORD`: Contraseña de PostgreSQL
- `DB_HOST`: Host de la base de datos
- `DB_PORT`: Puerto de PostgreSQL

## Solución de Problemas

### La aplicación no se conecta a la base de datos
- Verificar que el contenedor de la BD esté corriendo: `docker ps`
- Revisar los logs: `docker-compose logs db`
- Esperar a que el healthcheck de la BD esté OK

### Los cambios no se reflejan
- Reconstruir las imágenes: `docker-compose up --build`

### Puerto ya en uso
- Cambiar los puertos en `docker-compose.yml`
- O detener el servicio que esté usando el puerto 3000 o 5432

## Licencia

Este proyecto es de código abierto y está disponible bajo la licencia MIT.
