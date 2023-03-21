#!/bin/bash

# Función que muestra el menú
mostrar_menu() {
    echo "Seleccione una opción:"
    echo "1. Elija la ruta en la que va a trabajar."
    echo "2. Creación de una copia de seguridad (debe ser de una ruta introducida por el usuario)."
    echo "3. Creación de un fichero (extensión .sh, .py y .php)."
    echo "4. Listado de los documentos (ruta a elegir)."
    echo "5. Borrado de los documentos (ruta a elegir)."
    echo "6. Salir."
    echo    
    echo
}

# Función que muestra un mensaje de error
mostrar_error() {
    echo "Error: seleccione una opción válida."
    echo
}

# Función que lee la ruta introducida por el usuario
leer_ruta() {
    echo $PWD
    echo "Introduzca la ruta:"
    read ruta
    if [ -d $ruta ]; then
    	echo "Ruta existente, moviendo"
    	cd $ruta
    else
    	echo "La ruta no existe, por lo que será creada"
    	mkdir $ruta
    	cd $ruta
    fi
    echo
}

# Función que crea una copia de seguridad de una ruta
crear_copia_seguridad() {
    leer_ruta
    fecha=$(date +"%Y-%m-%d_%H-%M-%S")
    tar -czvf "copia_seguridad_$fecha.tar.gz" "$ruta"
    echo "Copia de seguridad creada con éxito."
    echo
}

# Función que crea un fichero con extensión .sh, .py o .php
crear_fichero() {
    leer_ruta
    echo "Introduzca el nombre del fichero:"
    read nombre
    echo "Seleccione la extensión del fichero:"
    select extension in "sh" "py" "php"
    do
        case $extension in
            sh|py|php)
                echo "#!/usr/bin/env $extension" > "$ruta/$nombre.$extension"
                echo "Fichero creado con éxito."
                echo
                break
                ;;
            *)
                mostrar_error
                ;;
        esac
    done
}

# Función que lista los documentos de una ruta
listar_documentos() {
    leer_ruta
    ls -la "$ruta"
    echo
}

# Función que borra los documentos de una ruta
borrar_documentos() {
    leer_ruta
    echo "¿Está seguro de que desea borrar los documentos de la ruta '$ruta'? (s/n)"
    read confirmacion
    if [ "$confirmacion" = "s" ]; then
        rm -rf "$ruta/*"
        echo "Documentos borrados con éxito."
        echo
    else
        echo "Operación cancelada."
        echo
    fi
}

# Bucle principal del script
while true
do
    mostrar_menu
    read opcion
    case $opcion in
        1)
            leer_ruta
            ;;
        2)
            crear_copia_seguridad
            ;;
        3)
            crear_fichero
            ;;
        4)
            listar_documentos
            ;;
        5)
            borrar_documentos
            ;;
        6)
            echo "Saliendo..."
            exit 0
            ;;
        *)
            mostrar_error
            ;;
    esac
done

