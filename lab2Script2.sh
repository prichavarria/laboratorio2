#!/bin/bash


#Verifica que se proporciona dos argumentos
if [ $# -ne 2 ]; then
    echo "Uso: $0 <nombreProceso> <comando>"
    exit 1
fi

nombreProceso=$1
comando=$2

while true; do
    #Se revisa si el proceso se ejecuta
    if ! pgrep -x $nombreProceso >/dev/null; then
        echo "El proceso $nombreProceso> no se ejecuta. Se procede a iniciarlo."
        #Ejecuta el comando para el proceso
        eval $comando &
        echo "El proceso $nombreProceso> se ha iniciado."
    fi

    #Se establece un periodo de 10 segundos entre las comprobaciones
    sleep 10
done
