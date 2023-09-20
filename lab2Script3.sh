#!/bin/bash
#Verifica que se proporciona un argumento
if [ $# -ne 1 ]; then
    echo "Uso: $0 <ejecutable>"
    exit 1
fi

# Se especifica el ejecutable
ejecutable=$1

# Se establece un archivo para registrar el comsumo de CPU y memoria
archivoRegistro="registro.txt"

# Inicia el archivo de registro
echo "Tiempo CPU Memoria"

# Se establece una funcion para obtener el uso de CPU y memoria
estadoProceso() {
    datoID=$(pgrep $ejecutable)
    if [ -n $datoID ]; then
        timestamp=$(date +%s)
        usoCPU=$(ps -p $datoID -o %cpu)
        usoMemoria=$(ps -p $datoID -o %mem)
        echo "$timestamp $usoCPU $usoMemoria" >> "$archivoRegistro"
    fi
}

# Hacemos una funcion para graficar con Gnuplot
crearGrafico() {
    gnuplot <<EOF
    set xlabel "Tiempo en segundos"
    set ylabel "Uso en porcentaje"
    set title  "Consumo de CPU y Memoria de $ejecutable con respecto al tiempo "
    plot "$archivoRegistro" using 1:2 with lines title "CPU", "$archivoRegistro" using 1:3 with lines title "Memoria"
    pause -1
EOF
}

# Dejamos el ejecutable en segundo plano
$ejecutable &

# Monitorear el proceso y registrar los valores de forma periodica
while true; do
    estadoProceso
    sleep 30 # Coloco un intervalo de 30 segundos
done &
chequeo=$!

# Espero a que finalice el proceso
wait $chequeo

# Genero el grafico
crearGrafico