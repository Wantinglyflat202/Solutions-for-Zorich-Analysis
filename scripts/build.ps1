[CmdletBinding()]
param(
    [switch]$Clean,
    [switch]$Rebuild
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'
$projectRoot = Split-Path -Parent $PSScriptRoot
$locationPushed = $false

try {
    if ($Clean -and $Rebuild) {
        throw 'Choose either -Clean or -Rebuild.'
    }
    if (-not (Get-Command latexmk -ErrorAction SilentlyContinue)) {
        throw 'latexmk was not found on PATH. Install TeX Live or MiKTeX with latexmk and Perl, then restart your terminal.'
    }
    if (-not $Clean -and -not (Get-Command xelatex -ErrorAction SilentlyContinue)) {
        throw 'xelatex was not found on PATH. Enable XeLaTeX in your TeX distribution, then restart your terminal.'
    }
    if (-not (Test-Path -LiteralPath (Join-Path $projectRoot 'main.tex'))) {
        throw "Project entry main.tex was not found in: $projectRoot"
    }

    Push-Location -LiteralPath $projectRoot
    $locationPushed = $true
    $latexmkArgs = @('-norc', '-r', 'latexmkrc')
    if ($Clean) { $latexmkArgs += '-c' }
    if ($Rebuild) { $latexmkArgs += '-g' }
    $latexmkArgs += 'main.tex'

    & latexmk @latexmkArgs
    if ($LASTEXITCODE -ne 0) {
        throw "latexmk failed (exit code $LASTEXITCODE). See build/Zorich_Analysis_Book1.log when available."
    }

    if ($Clean) {
        Write-Host 'Auxiliary files cleaned; the PDF is retained.'
    } else {
        $pdfPath = Join-Path $projectRoot 'build\Zorich_Analysis_Book1.pdf'
        if (-not (Test-Path -LiteralPath $pdfPath)) {
            throw "latexmk returned success but the expected PDF is missing: $pdfPath"
        }
        Write-Host "PDF ready: $pdfPath"
    }
} catch {
    Write-Error -Message $_.Exception.Message -ErrorAction Continue
    exit 1
} finally {
    if ($locationPushed) { Pop-Location }
}
