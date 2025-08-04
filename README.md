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

## Ejecución de MMASTER

Sigue los siguientes pasos para ejecutar `mmaster`:

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
    Ubícate en la dirección donde se encuentra la carpeta principal de tu conjunto de datos (ej. `AST_L1A_00309252008151116`) y ejecuta los siguientes comandos:

      * **Primer comando**:

        ```bash
        bash /mnt/c/P_CodeProjects/MMASTER-workflows/bin/WorkFlowASTER_ed.sh -s AST_L1A_00311012024141808 -z "18 +south" -a -i 2
        ```

      * **Segundo comando (Post-procesamiento)**:

        ```bash
        bash /mnt/c/P_CodeProjects/MMASTER-workflows/bin/PostProcessMicMac.sh -d AST_L1A_00309252008151116 -z "18 +south”
        ```