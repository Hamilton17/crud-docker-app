# Inicio Rápido

## 3 Pasos para Ejecutar la Aplicación

### 1. Clonar el Repositorio

```bash
git clone https://github.com/TU_USUARIO/TU_REPOSITORIO.git
cd TU_REPOSITORIO
```

### 2. Levantar los Contenedores

```bash
docker-compose up -d
```

### 3. Abrir en el Navegador

Abre tu navegador en: **http://localhost:3000**

---

## Eso es Todo!

La aplicación incluye:
- **20 productos pre-cargados** en la base de datos
- Interfaz web moderna para gestionar productos
- API REST completa
- Base de datos PostgreSQL con persistencia

---

## ¿La Base de Datos está Vacía?

Si no ves productos en la aplicación, es porque el volumen de Docker ya existía de una ejecución anterior. El script `init.sql` solo se ejecuta cuando el volumen se crea por primera vez.

**Solución rápida:**

```bash
# Detener y eliminar contenedores y volúmenes
docker-compose down -v

# Volver a levantar (esto creará volúmenes nuevos con datos)
docker-compose up -d
```

Ahora deberías ver los 20 productos en http://localhost:3000

---

## Ver Logs (Opcional)

```bash
docker-compose logs -f
```

Presiona `Ctrl+C` para salir de los logs.

---

## Detener la Aplicación

```bash
docker-compose down
```

Para eliminar también los datos de la base de datos:

```bash
docker-compose down -v
```

---

## Requisitos

- Docker Desktop instalado
- Puerto 3000 disponible (aplicación)
- Puerto 5432 disponible (PostgreSQL)

---

## Probar la API

```bash
# Obtener todos los productos
curl http://localhost:3000/api/productos

# Crear un producto nuevo
curl -X POST http://localhost:3000/api/productos \
  -H "Content-Type: application/json" \
  -d '{"nombre":"Nuevo Producto","precio":99.99,"cantidad":10}'
```

---

## Acceder a la Base de Datos

```bash
docker exec -it postgres_db psql -U postgres -d cruddb
```

Comandos SQL útiles:
```sql
-- Ver todos los productos
SELECT * FROM productos;

-- Ver estructura de la tabla
\d productos

-- Salir
\q
```

---

¿Problemas? Revisa el [README.md](README.md) para más información.
