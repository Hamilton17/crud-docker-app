# Guía para Subir el Proyecto a GitHub

## Pasos para Subir tu Proyecto a GitHub

### Paso 1: Configurar Git (Solo la primera vez)

Si es la primera vez que usas Git, necesitas configurar tu nombre y email:

```bash
git config --global user.name "Tu Nombre"
git config --global user.email "tu-email@ejemplo.com"
```

**Ejemplo:**
```bash
git config --global user.name "Juan Perez"
git config --global user.email "juan.perez@gmail.com"
```

### Paso 2: Crear el Commit Inicial

El repositorio ya está inicializado y los archivos están en staging. Solo necesitas crear el commit:

```bash
git commit -m "Initial commit: CRUD Application with Docker + PostgreSQL"
```

### Paso 3: Crear un Repositorio en GitHub

1. Ve a https://github.com
2. Inicia sesión en tu cuenta (o crea una si no tienes)
3. Haz clic en el botón verde **"New"** o **"+"** en la esquina superior derecha
4. Selecciona **"New repository"**
5. Configura tu repositorio:
   - **Repository name**: `crud-docker-app` (o el nombre que prefieras)
   - **Description**: "CRUD Application with Docker + PostgreSQL"
   - **Visibilidad**: Public (para que cualquiera pueda clonarlo)
   - **NO** marques "Initialize this repository with a README" (ya tienes uno)
6. Haz clic en **"Create repository"**

### Paso 4: Conectar tu Repositorio Local con GitHub

Después de crear el repositorio en GitHub, verás las instrucciones. Usa estos comandos:

```bash
# Agregar el repositorio remoto
git remote add origin https://github.com/TU_USUARIO/TU_REPOSITORIO.git

# Cambiar el nombre de la rama a main (opcional, pero recomendado)
git branch -M main

# Subir los archivos a GitHub
git push -u origin main
```

**Ejemplo completo:**
```bash
git remote add origin https://github.com/juanperez/crud-docker-app.git
git branch -M main
git push -u origin main
```

Si te pide autenticación, necesitarás usar un **Personal Access Token** (PAT) en lugar de tu contraseña.

### Paso 5: Crear un Personal Access Token (Si es necesario)

Si GitHub te pide autenticación:

1. Ve a GitHub → Settings (Configuración de tu perfil)
2. Developer settings → Personal access tokens → Tokens (classic)
3. Generate new token (classic)
4. Dale un nombre: "CRUD Docker App"
5. Selecciona los permisos: marca **"repo"** (acceso completo a repositorios)
6. Haz clic en **"Generate token"**
7. **IMPORTANTE**: Copia el token inmediatamente (no podrás verlo de nuevo)
8. Usa este token como contraseña cuando Git te lo pida

### Paso 6: Verificar que el Proyecto Está en GitHub

1. Ve a `https://github.com/TU_USUARIO/TU_REPOSITORIO`
2. Deberías ver todos tus archivos
3. El README.md se mostrará automáticamente en la página principal

### Paso 7: Actualizar el README con la URL Correcta

Ahora que tu repositorio está en GitHub, actualiza el README.md con la URL correcta:

```bash
# Edita el README.md y reemplaza:
# https://github.com/TU_USUARIO/TU_REPOSITORIO.git
# Con la URL real de tu repositorio

# Luego haz commit de los cambios
git add README.md
git commit -m "Update repository URL in README"
git push
```

## Comandos Resumidos (Copia y Pega)

```bash
# 1. Configurar Git (solo la primera vez)
git config --global user.name "Tu Nombre"
git config --global user.email "tu-email@ejemplo.com"

# 2. Crear commit
git commit -m "Initial commit: CRUD Application with Docker + PostgreSQL"

# 3. Conectar con GitHub (reemplaza con tu URL)
git remote add origin https://github.com/TU_USUARIO/TU_REPOSITORIO.git
git branch -M main
git push -u origin main
```

## Probar el Proyecto desde GitHub

Una vez subido, cualquier persona (incluyéndote a ti desde otra computadora) puede usar el proyecto así:

```bash
# Clonar el repositorio
git clone https://github.com/TU_USUARIO/TU_REPOSITORIO.git
cd TU_REPOSITORIO

# Levantar la aplicación
docker-compose up -d

# Abrir en el navegador
# http://localhost:3000
```

## Agregar un Badge de GitHub al README

Puedes agregar badges bonitos a tu README.md para mostrar el estado del proyecto:

```markdown
![GitHub repo size](https://img.shields.io/github/repo-size/TU_USUARIO/TU_REPOSITORIO)
![GitHub stars](https://img.shields.io/github/stars/TU_USUARIO/TU_REPOSITORIO?style=social)
![GitHub forks](https://img.shields.io/github/forks/TU_USUARIO/TU_REPOSITORIO?style=social)
```

## Hacer Cambios Futuros

Cuando hagas cambios en el proyecto:

```bash
# Ver qué archivos cambiaron
git status

# Agregar archivos modificados
git add .

# Crear un commit
git commit -m "Descripción de los cambios"

# Subir a GitHub
git push
```

## Solución de Problemas

### Error: "remote origin already exists"
```bash
git remote remove origin
git remote add origin https://github.com/TU_USUARIO/TU_REPOSITORIO.git
```

### Error: "failed to push some refs"
```bash
git pull origin main --rebase
git push -u origin main
```

### Error: Autenticación fallida
- Usa un Personal Access Token en lugar de tu contraseña
- O configura SSH keys (más avanzado)

## Recursos Adicionales

- [Guía de Git](https://git-scm.com/doc)
- [Documentación de GitHub](https://docs.github.com)
- [Markdown Cheatsheet](https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet)
- [Shields.io](https://shields.io) - Para crear badges personalizados

## Próximos Pasos

1. Sube el proyecto a GitHub siguiendo esta guía
2. Comparte el link con otros desarrolladores
3. Agrega una captura de pantalla de la aplicación al README
4. Considera agregar un archivo LICENSE
5. Opcionalmente, configura GitHub Actions para CI/CD

¡Tu proyecto estará disponible para que cualquiera lo clone y lo use con un simple `docker-compose up -d`!
