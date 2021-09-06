# Copia Local de Repositorios de un grupo de GitLab
## Objetivo
Tener una copia actualizada de los repositorios de un grupo de GitLab, en el cual el usuario es miembro.

## Pre-Requisitos
Para que los scripts funcionen debe tenerse:
- Token con acceso de lectura al grupo para obtener los detalles de los repositorios
- Tener registrada una clave SSH para descargar los repositorios sin tener que ingresar credenciales (forma automatizada)

## Scripts
### backup.sh
Se encarga de actualizar los repositorios existenes (o descargar los nuevos que no se tienen en local) de los servidores de GitLab. Para ello genera la estructura de directorios necesaria y consulta al API de GitLab para realizar la tarea. Los repositorios se descargarán de forma ordenada alfabéticamente. En este archivo hay que modificar las variables groupid y token, colocándoles los valores correctos.

### generar_listado.py
Lee el archivo de información descargado de GitLab (proyectos.json) y generará el listado de repositorios (junto con sus propiedades a descargar)

