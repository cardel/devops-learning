#!/bin/bash

# Ruta base donde deseas buscar
ruta_base="./"

# Archivo donde guardarás el reporte
archivo_reporte="reportefuncional.txt"
echo "" > $archivo_reporte
# Buscar archivos que contengan las palabras "sort," "length," y "size," de forma recursiva y guardar resultados en el archivo de reporte
echo "Archivos que contienen sort, length, o size:" > "$archivo_reporte"
find "$ruta_base" -type f -exec grep -lE '\.size|\.length|\.sort' {} + 2>/dev/null >> "$archivo_reporte"

# Buscar archivos que contengan la palabra "ordenar" dentro del bloque def k_elemento y guardar resultados en el archivo de reporte
echo "Archivos que contienen 'ordenar' en el bloque def k_elemento:" >> "$archivo_reporte"
find "$ruta_base" -type f -name "*.scala" -exec grep -l 'def k_elemento(l: List[Int], k: Int): Int = {.*ordenar.*}' {} + 2>/dev/null >> "$archivo_reporte"

echo "Reporte generado en $archivo_reporte"
