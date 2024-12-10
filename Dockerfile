# Usa una imagen base de Node.js
FROM node:16

# Establece el directorio de trabajo
WORKDIR /usr/src/app

# Copia el archivo package.json y package-lock.json
COPY package*.json ./

# Instala las dependencias
RUN npm install

# Copia el resto de los archivos de tu proyecto al contenedor
COPY . .

# Asegúrate de que el archivo wait-for-mysql.sh tenga permisos de ejecución
RUN chmod +x wait-for-sql.sh

# Genera el cliente Prisma
RUN npx prisma generate

# Expone el puerto en el que tu aplicación estará escuchando
EXPOSE 3000

# Ejecuta el script de espera
CMD ["sh", "./wait-for-sql.sh"]