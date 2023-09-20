#!/bin/bash
directorioMonitorear="/Documents/laboratorio2"
archivoMonitoreo="/Documents/log/monitoreoDirectorio.log"

#Utilizo el comando para monitorear el directorio 
inotifywait --monitor $directorioMonitorear
while read -r archivoEvento timestamp; do
archivoMonitoreo="/Documents/log/monitoreoDirectorio.log"
    #Registro el evento en el archivo
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] Evento en $archivoEvento: timestamp" >> $archivoMonitoreo
done