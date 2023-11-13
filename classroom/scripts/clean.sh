#!/bin/bash

# Ruta base donde deseas conservar los archivos y eliminar los directorios
ruta_base="./"

# Utiliza el comando find para buscar todos los directorios en la ruta_base
# y excluye el directorio base para evitar eliminar sus archivos.
# Luego, utiliza el comando rm para eliminar esos directorios encontrados.
find "$ruta_base" -type d ! -path "$ruta_base" -exec rm -rf {} +
rm *.txt
echo "Directorios eliminados, archivos conservados en $ruta_base"
