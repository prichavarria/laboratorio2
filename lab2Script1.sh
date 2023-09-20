#!/bin/bash


#Verifica que se proporciona un argumento
if [ $# -ne 1 ]; then
    echo "Uso: $0 <pideID>"
    exit 1
fi

# Pide el ID del proceso a identificar con el argumento
pideID=$1

# Obtiene el nombre del proceso
procesoNombre=$(ps -p $pideID -o comm=)

# Obtiene el ID del proceso
procesoID=$pideID

# Obtiene el Parent Process ID
parentProcessID=$(ps -p $pideID -o parentProcessID=)

# Obtiene el Usuario propietario
usuarioPropietario=$(ps -p $pideID -o user=)

# Obtiene el porcentaje de uso de CPU
usoCPU=$(ps -p $pideID -o %cpu=)

# Obtiene el porcentaje de memoria
consumoMemoria=$(ps -p $pideID -o %mem=)

# Obtiene el estado/status
status=$(ps -p $pideID -o stat=)

# Obtiene el path del ejecutable
pathEjecutable=$(readlink -f /proc/$pideID/exe)

# Hacer un print de todo lo obtenido
echo "Nombre del proceso: $procesoNombre"
echo "ID del proceso: $procesoID"
echo "Parent process ID: $parentProcessID"
echo "Usuario propietario: $usuarioPropietario"
echo "Porcentaje de uso de CPU: $usoCPU%"
echo "Consumo de memoria: $consumoMemoria%"
echo "Estado/Status: $status"
echo "Path del ejecutable: $pathEjecutable"