#!/bin/bash

# Nombre del archivo CSV
archivo_csv="estudiantes.csv"
url="git@github.com:Programacion-funcional-2023-I/taller-1-martes-"
base="git@github.com:Programacion-funcional-2023-I/taller1.git"
base_local="taller-1-martes-"

# Verificar si el archivo existe
if [ ! -f "$archivo_csv" ]; then
    echo "El archivo $archivo_csv no existe."
    exit 1
fi

# Leer el archivo CSV y almacenar las columnas en un arreglo
mapfile -t columnas < <(tail -n +2 "$archivo_csv" | awk -F ',' '{print $1, $2, $3, $4, $5, $6}')

# Recorrer el arreglo por la cuarta columna y pegarlo a la url
for col in "${columnas[@]}"; do
	repo=$(echo "$col" | awk '{print $3}')
	git clone "$url$repo.git"
done

# Nombre del archivo que contiene la lista de archivos
archivo_lista="archivos.csv"

# Verificar si el archivo existe
if [ ! -f "$archivo_lista" ]; then
    echo "El archivo $archivo_lista no existe."
    exit 1
fi

#Descargar el repositorio
git clone "$base"

# Leer la lista de archivos y calcular el MD5sum para cada uno
while IFS= read -r archivo; do
    # Verificar si el archivo existe
    if [ ! -f "taller1/$archivo" ]; then
        echo "El archivo $archivo no existe."
    else
        # Calcular el MD5sum del archivo y almacenarlo en una variable
        md5sum=$(md5sum "taller1/$archivo" | awk '{print $1}')
        # Almacenar el resultado en un arreglo o en una variable, según tus necesidades
        md5sums+=("$archivo $md5sum")
        #echo "MD5sum de $archivo: $md5sum"
    fi
done < "$archivo_lista"

#Validar los m5sums
echo "" > noexiste.txt
echo "" > reportemodificacion.txt
for col in "${columnas[@]}"; do
        repo=$(echo "$col" | awk '{print $3}')
	for item in "${md5sums[@]}"; do
		md5origin=$(echo "$item" | awk '{print $2}')
		archivo="$base_local$repo/$(echo $item | awk '{print $1}')"
		if [ -f "$archivo" ]; then
			md5repo=$(md5sum "$archivo" | awk '{print $1}')
			if [ "$md5origin" != "$md5repo" ]; then
				echo "$archivo" >> reportemodificacion.txt
			fi
		else
			echo "$archivo" >> noexiste.txt
		fi
	done
done



