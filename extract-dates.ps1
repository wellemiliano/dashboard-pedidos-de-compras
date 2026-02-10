# Script para extrair a data mais recente dos dados

$file = "c:\Users\we061201\OneDrive - COMERC ENERGIA\Backup\Site\dados_dashboard.js"

Write-Host "Analisando arquivo de dados..." -ForegroundColor Yellow

$content = [System.IO.File]::ReadAllText($file, [System.Text.Encoding]::UTF8)

# Procurar por padrões de data: "emissão": "dd/MM/yyyy"
$pattern = '"emiss[ãa]o"\s*:\s*"(\d{2}/\d{2}/\d{4})"'
$matches = [regex]::Matches($content, $pattern)

if ($matches.Count -gt 0) {
    Write-Host "[OK] Encontradas $($matches.Count) datas de emissão" -ForegroundColor Green
    
    # Extrair todas as datas e converter para DateTime
    $datas = @()
    foreach ($match in $matches) {
        $dataStr = $match.Groups[1].Value
        try {
            $data = [datetime]::ParseExact($dataStr, 'dd/MM/yyyy', $null)
            $datas += $data
        } catch {
            Write-Host "Erro ao processar data: $dataStr" -ForegroundColor Red
        }
    }
    
    if ($datas.Count -gt 0) {
        $dataMaisRecente = $datas | Sort-Object -Descending | Select-Object -First 1
        $dataMaisAntiga = $datas | Sort-Object | Select-Object -First 1
        
        Write-Host ""
        Write-Host "=== ANALISE DE DATAS ===" -ForegroundColor Cyan
        Write-Host "Data mais recente: $($dataMaisRecente.ToString('dd/MM/yyyy'))" -ForegroundColor Green
        Write-Host "Data mais antiga:  $($dataMaisAntiga.ToString('dd/MM/yyyy'))" -ForegroundColor Yellow
        Write-Host "Total de registros: $($datas.Count)"
        Write-Host ""
        
        if ($dataMaisRecente.ToString('dd/MM/yyyy') -eq (Get-Date).ToString('dd/MM/yyyy')) {
            Write-Host "✓ Dados contem registros de HOJE!" -ForegroundColor Green
        } else {
            Write-Host "✗ Dados NAO contem registros de HOJE" -ForegroundColor Red
            Write-Host "   Data de hoje:     $(Get-Date -Format 'dd/MM/yyyy')" -ForegroundColor Cyan
        }
    }
} else {
    Write-Host "[ERRO] Nenhuma data encontrada no formato esperado" -ForegroundColor Red
    Write-Host "Procurando por outros padrões..." -ForegroundColor Yellow
    
    # Tentar outros padrões
    if ($content -match '\d{2}/\d{2}/\d{4}') {
        Write-Host "Encontrado padrão dd/MM/yyyy no arquivo" -ForegroundColor Yellow
    }
}
