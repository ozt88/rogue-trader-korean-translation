# Warhammer 40K Rogue Trader Translation Update Script
$PossiblePaths = @(
    "E:\SteamLibrary\steamapps\common\Warhammer 40,000 Rogue Trader\WH40KRT_Data\StreamingAssets\Localization",
    "C:\Program Files (x86)\Steam\steamapps\common\Warhammer 40,000 Rogue Trader\WH40KRT_Data\StreamingAssets\Localization",
    "D:\SteamLibrary\steamapps\common\Warhammer 40,000 Rogue Trader\WH40KRT_Data\StreamingAssets\Localization",
    "C:\Steam\steamapps\common\Warhammer 40,000 Rogue Trader\WH40KRT_Data\StreamingAssets\Localization"
)

$GamePath = $null
foreach ($path in $PossiblePaths) {
    if (Test-Path $path) {
        $GamePath = $path
        break
    }
}

Write-Host "========================================"
Write-Host "Warhammer 40K Rogue Trader Update"
Write-Host "========================================"

if (-not $GamePath) {
    Write-Host "Could not find game path automatically."
    Write-Host "Select from list or enter path manually:"
    for ($i = 0; $i -lt $PossiblePaths.Count; $i++) {
        Write-Host "  $($i+1). $($PossiblePaths[$i])"
    }
    Write-Host "  0. Enter manually"
    
    $choice = Read-Host "Selection"
    
    if ($choice -eq "0") {
        $GamePath = Read-Host "Enter full path"
    } elseif ($choice -match "^[1-4]$") {
        $GamePath = $PossiblePaths[[int]$choice - 1]
    } else {
        Write-Host "Invalid selection."
        exit 1
    }
}

Write-Host "`nChecking game path..."
if (-not (Test-Path $GamePath)) {
    Write-Host "Path not found!"
    exit 1
}
Write-Host "OK: $GamePath"

$BackupFile = Join-Path $GamePath ("enGB_backup_{0:yyyyMMdd}.json" -f (Get-Date))
$ReleaseUrl = "https://github.com/ozt88/rogue-trader-korean-translation/releases/latest/download/enGB.json"
$TempFile = Join-Path $env:TEMP "enGB_new.json"

Write-Host "`nDownloading latest translation..."
Invoke-WebRequest -Uri $ReleaseUrl -OutFile $TempFile -UseBasicParsing

Write-Host "Backing up existing file..."
$OriginalFile = Join-Path $GamePath "enGB.json"
if (Test-Path $OriginalFile) {
    Copy-Item $OriginalFile $BackupFile -Force
    Write-Host "Backup created"
}

Write-Host "Applying new translation..."
Copy-Item $TempFile $OriginalFile -Force

Write-Host "Cleaning up..."
Remove-Item $TempFile -Force -ErrorAction SilentlyContinue

Write-Host "`n========================================"
Write-Host "Update complete! Launch the game."
Write-Host "========================================"
Read-Host "Press Enter to exit"
