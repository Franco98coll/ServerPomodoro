
echo "MySQL está listo. Aplicando migraciones de Prisma..."
# Verifica si ya existen migraciones aplicadas
if npx prisma migrate status | grep -q "No pending migrations"; then
  echo "Las migraciones ya están aplicadas. No se aplicarán nuevas migraciones."
else
  echo "Aplicando migraciones de Prisma..."
  npx prisma migrate dev --name init
  npx prisma migrate deploy
  echo "Migraciones aplicadas."
fi


exec npm run dev