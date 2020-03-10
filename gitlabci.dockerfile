# Laboratorio de Programación y Lenguajes
# FI-UNPSJB-PM
#
# Imagen para la ejecución en Gitlab-CI
FROM docker:dind

# Instala paquetes
RUN apk add --no-cache docker-compose

# Comando por defecto al ejecutar el contenedor con 'run'
# CMD [ "bash" ]
