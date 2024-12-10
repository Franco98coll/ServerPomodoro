# Espera hasta que el servidor SQL esté listo
timeout=300 # Cambia a 60 segundos (o más si es necesario)
count=0

while ! nc -z sqlserver 1433; do
  echo "Esperando a que SQL Server esté listo..."
  sleep 2
  count=$((count + 1))
  if [ $count -ge $timeout ]; then
    echo "El tiempo de espera para SQL Server ha expirado."
    exit 1
  fi
done

echo "SQL Server está listo. Iniciando la aplicación..."
npx prisma migrate deploy
echo "Migraciones aplicadas. Iniciando la aplicación..."
exec npm run dev
