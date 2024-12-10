
echo "MySQL está listo. Aplicando migraciones de Prisma..."
npx prisma migrate deploy

echo "Migraciones aplicadas. Iniciando la aplicación..."
exec npm run dev