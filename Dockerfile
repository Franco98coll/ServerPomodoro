# Usa una imagen base de Node.js. Puedes elegir la versión específica que necesites; 'alpine' es una versión ligera.
FROM node:alpine

# Instalar OpenSSL 3 y otras dependencias necesarias
RUN apk update && apk add --no-cache \
    openssl \
    && rm -rf /var/cache/apk/*

# Crea el directorio de la aplicación dentro del contenedor
WORKDIR /usr/src/app

# Copia los archivos de definición de paquetes NPM. Esto incluye tanto 'package.json' como 'package-lock.json' (si está presente).
COPY package*.json ./ 

# Instala las dependencias del proyecto, incluidas las de 'devDependencies' para asegurar que Prisma CLI esté disponible.
RUN npm install

# Copia el resto de los archivos de tu proyecto al contenedor
COPY . .

# Genera el cliente Prisma. Esto asume que 'prisma' es una devDependency en tu 'package.json',
# lo que permite su uso con npx sin necesidad de instalarlo globalmente.
RUN npx prisma generate

# Expone el puerto en el que tu aplicación estará escuchando
EXPOSE 3000

# Ejecuta el script de espera
RUN chmod +x wait-for-sql.sh
CMD ["sh", "./wait-for-sql.sh"]