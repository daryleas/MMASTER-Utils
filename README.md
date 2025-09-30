# MMASTER Local Setup and Workflow

Este repositorio contiene códigos y archivos generados para facilitar el uso local de `mmaster` de Luc Girod.

## Configuración Inicial

1.  **Instalación de MicMac y MMASTER**:
      * MicMac fue instalado utilizando WSL (Windows Subsystem for Linux).
      * `mmaster` se instaló posteriormente utilizando `miniconda` y `mamba` con el archivo de entorno `mmaster_environment_fixed.yml`.

## Archivos y su Propósito

  * **`mmaster_environment_fixed.yml`**: Este archivo YAML se utilizó para crear el entorno de `mmaster` con `miniconda` y `mamba`. Asegura que todas las dependencias necesarias estén correctamente configuradas.
  * **`WorkFlowASTER_ed.sh`**: Una versión editada del ejecutable `WorkFlowASTER.sh` original. Esta modificación permite su ejecución, ya que la versión sin editar me presentaba problemas :c
  * **`MoveFilesToMMaster.ipynb`**: Un cuaderno Jupyter (IPython Notebook) diseñado para organizar archivos ASTER. Su función principal es mover los archivos de sus carpetas originales y estructurarlos de la manera requerida por `mmaster` para su procesamiento.
      * La primera parte del código permite un filtrado de imágenes (su utilidad puede variar según la necesidad).

      * La segunda parte se encarga de copiar los archivos. Busca archivos `.zip` en `zip_folder` y `.met.zip` en `met_folder` para copiarlos a una nueva carpeta con el siguiente formato:

        ```
        AST_L1A_00309252008151116
        ├── AST_L1A_00309252008151116_20250717092247_3856638.zip
        └── AST_L1A_00309252008151116_20250717092247_3856638.zip.met
        ```

  *  **`mmaster_bias_correction_ed.py`** : Archivo editado de `mmaster_bias_correction.py`
  ### Ejecutables en serie
  * **`run_mmast_DemGen_v1.sh`**: Ejecutable para generar DEM en secuencia de una lista de imágenes. Ejecuta:
    * `WorkFlowASTER_ed.sh`
    * `PostProcessMicMac.sh`
  * **`run_mmast_Coregis_v1.sh`**: Ejecutable para ejecutar el coregistro a todas las imágenes de una carpeta. Ejecuta:
    * `mmaster_bias_correction_ed.py`
## Ejecución de MMASTER

Sigue los siguientes pasos para ejecutar `mmaster`:

> Paso 0: Inicia WSL

1.  **Activar el Entorno Virtual**:
    Asegúrate de activar el entorno virtual correspondiente. En este caso, el entorno se llama `mmaster_new`:

    ```bash
    conda activate mmaster_new
    ```

2.  **Organizar tus Carpetas de Entrada (INPUT)**:
    Asegúrate de que tus archivos ASTER estén organizados en una estructura de carpeta como la siguiente:

    ```
    📁
    AST_L1A_00309252008151116
    ├── AST_L1A_00309252008151116_20250717092247_3856638.zip
    └── AST_L1A_00309252008151116_20250717092247_3856638.zip.met
    ```

3.  **Ejecutar los Comandos de MMASTER**:
    Ubícate en la dirección donde se encuentra la carpeta en la cual se ubican las carpetas a procesar 

    ```
    📁 folderToProcess (aquí te ubicarás)
    ├── run_mmast_v1.sh (opcional)
    ├── AST_L1A_00309252008151116
    |   ├── AST_L1A_00309252008151116_20250717092247_3856638.zip
    |   └── AST_L1A_00309252008151116_20250717092247_3856638.zip.met
    ```

     y ejecuta los siguientes comandos:
      * **Ejecutable secuencial**
        ```bash
        bash run_mmast_v1.sh
        ```
      
      * **Primer comando**:

        ```bash
        bash /mnt/c/P_CodeProjects/MMASTER-workflows/bin/WorkFlowASTER_ed.sh -s AST_L1A_00311012024141808 -z "18 +south" -a -i 2
        ```

      * **Segundo comando (Post-procesamiento)**:

        ```bash
        bash /mnt/c/P_CodeProjects/MMASTER-workflows/bin/PostProcessMicMac.sh -d AST_L1A_00309252008151116 -z "18 +south”
        ```

      * **Tercer comando (Co-Registro)**:

        ```bash
        python3 /mnt/c/P_CodeProjects/MMASTER-workflows/bin/mmaster_bias_correction_ed.py \
        /completePathTo/DEM_ref.tif \
        /completePathTo/AST_L1A_00311012024141808 \
        -s AST_L1A_00311012024141808_Z.tif \
        -a completePathTo/vector_UnstableTerrain.shp \
        -o BiasCorrection \
        -n 1
        ```
        Ejemplos:
        
        ```
        python3 /mnt/c/P_CodeProjects/MMASTER-workflows/bin/mmaster_bias_correction_ed.py \
        /mnt/e/Test_2_huayhuash/dem_copv1.tif \
        /mnt/e/Test_2_huayhuash/AST_L1A_00305252002152946 \
        -s AST_L1A_00305252002152946_Z.tif \
        -a /mnt/e/Test_2_huayhuash/GLIMSV6.shp \
        -o BiasCorrection \
        -n 1
        ```
        ```
        python3 /mnt/c/P_CodeProjects/MMASTER-workflows/bin/mmaster_bias_correction_ed.py \
          /mnt/c/P_MMaster/01Input/TandemX90/TanDEM90_P_rep32718.tif \
          /mnt/c/P_MMaster/Tst_corregistro02/AST_L1A_00304132010152811 \
          --slavedem AST_L1A_00304132010152811_Z.tif \
          --exc_mask /mnt/c/P_MMaster/01Input/RGIv6/glims_polygons_ed01_Dissolved_rep32718.shp \
          --nproc 4 \
          -o BiasCorrection 
        ```
