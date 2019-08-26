# Laboratorio de Programación y Lenguajes
# FI-UNPSJB-PM
#
# Imagen para el desarrollo del server side (glassfish)
# Destinada para utilizar en el desarrollo del trabajo de laboratorio.
FROM openjdk:8-jdk-alpine

# Establece el directorio de trabajo
WORKDIR /usr/local

# Instala paquetes
RUN apk update && apk add --no-cache apache-ant bash git

## Configura variables de entorno para java y ant
ENV ANT_HOME /usr/share/java/apache-ant 
ENV PATH $ANT_HOME/bin:$PATH

# Agrega Glassfish a la imagen
RUN wget http://ftp.osuosl.org/pub/eclipse/glassfish/web-5.1.0.zip && \
    jar xvf web-5.1.0.zip && \
    chmod +x glassfish5/glassfish/bin/* && \
    rm -f web-5.1.0.zip

# Configura variables de entorno de glassfish
ENV PATH /usr/local/glassfish5/glassfish/bin:$PATH

# Realiza la configuración inicial de glassfish
RUN echo $'AS_ADMIN_PASSWORD=\nAS_ADMIN_NEWPASSWORD=admin\n' > pw && \
    asadmin --user admin --passwordfile pw change-admin-password --domain_name domain1 && \
    asadmin start-domain domain1 && \
    echo $'AS_ADMIN_PASSWORD=admin\n' > pw && \
    asadmin --user admin --passwordfile pw enable-secure-admin && \
    rm -f pw

# Monta el directorio de las bases de datos para persistirlas
VOLUME /usr/local/glassfish5/glassfish

# Crea el directorio app para montar el código a desarrollar
RUN mkdir -p /root/app

# Establece el directorio de trabajo
WORKDIR /root/app

# Expone los puertos
EXPOSE 8080 4848

# Establece la variable de entorno para definir el prompt de la terminal
ENV PS1="[LabProg-Server:\W]\$ "

# Comando por defecto al ejecutar el contenedor con 'run'
CMD [ "bash" ]
