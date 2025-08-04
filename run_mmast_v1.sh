#!/bin/bash

# Ruta base de los scripts
SCRIPT_DIR="/mnt/c/P_CodeProjects/MMASTER-workflows/bin"
# C:\P_ASP\03Aster_Avance\01Process\DataInput
# Lista de escenas (puedes modificarla directamente aquí o leerla desde un archivo)
SCENES=(
  "AST_L1A_00311212016154017"
)

# Zona UTM con hemisferio
ZONE="18 +south"

# Loop a través de cada escena
for SCENE in "${SCENES[@]}"; do
  echo "Procesando escena: $SCENE"
  
  echo "  --> Ejecutando WorkFlowASTER_ed.sh"
  bash "$SCRIPT_DIR/WorkFlowASTER_ed.sh" -s "$SCENE" -z "$ZONE" -a -i 2
  
  echo "  --> Ejecutando PostProcessMicMac.sh"
  bash "$SCRIPT_DIR/PostProcessMicMac.sh" -d "$SCENE" -z "$ZONE"
  
  echo "  --> Escena $SCENE procesada completamente"
  echo "---------------------------------------------"
done

echo "✅ Procesamiento completo de todas las escenas."
