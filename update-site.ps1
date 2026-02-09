# Script para atualizar o Dashboard - copia arquivo JS e faz push para GitHub

Write-Host "=== Atualizando Dashboard ===" -ForegroundColor Cyan

# 1. Copiar arquivo dados_dashboard.js
Write-Host "Copiando dados_dashboard.js..." -ForegroundColor Yellow
$origem = "c:\Users\we061201\OneDrive - COMERC ENERGIA\Mori Energia - BIs\dados_dashboard.js"
$destino = "c:\Users\we061201\OneDrive - COMERC ENERGIA\Backup\Site\dados_dashboard.js"

if (Test-Path $origem) {
    Copy-Item -Path $origem -Destination $destino -Force
    Write-Host "[OK] Arquivo copiado com sucesso!" -ForegroundColor Green
} else {
    Write-Host "[ERRO] Arquivo nao encontrado em: $origem" -ForegroundColor Red
    exit 1
}

# 2. Navegar para a pasta do site
Write-Host "Atualizando repositorio Git..." -ForegroundColor Yellow
Set-Location "c:\Users\we061201\OneDrive - COMERC ENERGIA\Backup\Site"

# 3. Git add, commit e push
git add .
git commit -m "Atualizacao automatica do dashboard"
git push

Write-Host "[OK] Site atualizado com sucesso!" -ForegroundColor Green
Write-Host "Acesse: https://wellemiliano.github.io/dashboard-pedidos-de-compras" -ForegroundColor Cyan
