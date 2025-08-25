#!/bin/bash

# Ruta al DEM de referencia
DEM_REF="/mnt/c/P_MMaster/01Input/TandemX90/TanDEM90_P.tif"

# Vector de áreas inestables
VECTOR="/mnt/c/P_MMaster/01Input/RGIv6/glims_polygons.shp"

# Carpeta donde están los ASTER (cada uno en una carpeta separada)
INPUT_DIR="/mnt/c/P_MMaster/Huayhuash_DEM_CT90"

# Salida base
OUTPUT_DIR="BiCorr"

# Recorremos todas las carpetas que empiezan con AST_L1A_
for folder in "$INPUT_DIR"/AST_L1A_*; do
    if [ -d "$folder" ]; then
        # Nombre de la carpeta (ej. AST_L1A_00307022016152908)
        base=$(basename "$folder")

        # Nombre del archivo .tif asociado (ej. AST_L1A_00307022016152908_Z.tif)
        S_TIF="${base}_Z.tif"
        echo "======================"
        echo "Ejecutando para $base"

        python3 /mnt/c/P_CodeProjects/MMASTER-workflows/bin/mmaster_bias_correction_ed.py \
            "$DEM_REF" \
            "$folder" \
            -s "$S_TIF" \
            -a "$VECTOR" \
            -o "$OUTPUT_DIR/$base" \
            -n 1
    fi
done
