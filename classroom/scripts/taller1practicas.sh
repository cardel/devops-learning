#!/bin/bash

# Ruta base donde deseas buscar
ruta_base="./"

# Archivo donde guardarás el reporte
archivo_reporte="reportefuncional.txt"
echo "" > $archivo_reporte

# Buscar archivos que contengan las palabras no permitidas
echo "palabras no permitidas" >> "$archivo_reporte"
find "$ruta_base" -type f -exec grep -liE '\.size|\.length|\.sort|\.indexof|\.for' {} + 2>/dev/null >> "$archivo_reporte"

# Buscar archivos que contengan la palabra "ordenar" dentro del bloque def k_elemento y guardar resultados en el archivo de reporte
echo "ordenar" >> "$archivo_reporte"
find "$ruta_base" -type f -name "*.scala" -exec awk '/def k_elemento\(.*\)/,/\}/{ if (/ordenar/) {print FILENAME; exit} }' {} + 2>/dev/null >> "$archivo_reporte"

# Buscar archivos que contengan indexación en listas o arreglos en Scala
echo "uso de indices" >> "$archivo_reporte"
find "$ruta_base" -type f -name "*.scala" -exec awk '/\([^)]+\)/ || /val\s+[[:alnum:]_]+\s*=\s*[0-9]+/ {print FILENAME; exit}' {} + 2>/dev/null >> "$archivo_reporte"

echo "Reporte generado en $archivo_reporte"
