# Usa la imagen oficial de PostgreSQL
FROM postgres:15-alpine

# Variables de entorno para la configuración de PostgreSQL
ENV POSTGRES_DB=cruddb
ENV POSTGRES_USER=postgres
ENV POSTGRES_PASSWORD=postgres

# Copiar el script de inicialización
COPY init.sql /docker-entrypoint-initdb.d/

# Exponer el puerto de PostgreSQL
EXPOSE 5432
