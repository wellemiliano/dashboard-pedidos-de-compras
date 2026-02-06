@echo off
REM Script para atualizar o Dashboard - copia arquivo JS e faz push para GitHub

echo.
echo ==============================================
echo     Atualizando Dashboard
echo ==============================================
echo.

REM 1. Copiar arquivo dados_dashboard.js
echo Copiando dados_dashboard.js...
set origem=c:\Users\we061201\OneDrive - COMERC ENERGIA\Mori Energia - BIs\dados_dashboard.js
set destino=c:\Users\we061201\OneDrive - COMERC ENERGIA\Backup\Site\dados_dashboard.js

if exist "%origem%" (
    copy /Y "%origem%" "%destino%"
    echo [OK] Arquivo copiado com sucesso!
) else (
    echo [ERRO] Arquivo nao encontrado em: %origem%
    pause
    exit /b 1
)

echo.
echo Atualizando repositorio Git...

REM 2. Navegar para a pasta do site e fazer git push
cd /d "c:\Users\we061201\OneDrive - COMERC ENERGIA\Backup\Site"

REM 3. Git add, commit e push
git add .
git commit -m "Atualizacao automatica do dashboard"
git push

if %errorlevel% equ 0 (
    echo.
    echo [OK] Site atualizado com sucesso!
    echo Acesse: https://wellemiliano.github.io/dashboard-pedidos-de-compras
) else (
    echo.
    echo [ERRO] Erro ao fazer push. Verifique sua conexao com a internet.
)

echo.
pause
