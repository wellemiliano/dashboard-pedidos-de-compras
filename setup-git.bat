@echo off
cd /d "c:\Users\we061201\OneDrive - COMERC ENERGIA\Backup\Site"

echo Inicializando repositório Git...
git init

echo Configurando git user...
git config user.email "seu-email@example.com"
git config user.name "Seu Nome"

echo Adicionando arquivos...
git add .

echo Fazendo commit inicial...
git commit -m "Initial commit - Dashboard Gestao de Pedidos de Compras"

echo Renomeando branch para main...
git branch -M main

echo Adicionando remote origin...
git remote add origin https://github.com/wellemiliano/dashboard-pedidos-de-compras.git

echo Enviando para GitHub...
git push -u origin main

echo.
echo Concluído! Seu repositório foi enviado para GitHub.
pause
