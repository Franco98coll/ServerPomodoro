
# Espera hasta que el servidor MySQL esté listo
timeout=300 # Aumenta el tiempo de espera a 600 segundos (10 minutos)
count=0

while ! nc -z mysql 3306; do
  echo "Esperando a que MySQL esté listo..."
  sleep 2
  count=$((count + 2))
  if [ $count -ge $timeout ]; then
    echo "El tiempo de espera para MySQL ha expirado."
    exit 1
  fi
done

echo "MySQL está listo. Aplicando migraciones de Prisma..."
npx prisma migrate deploy

echo "Migraciones aplicadas. Iniciando la aplicación..."
exec npm run dev