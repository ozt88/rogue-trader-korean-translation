# Warhammer 40K Rogue Trader 번역 업데이트 스크립트
# 관리자 권한으로 실행 필요할 수 있음

# 가능한 게임 설치 경로 목록
$PossiblePaths = @(
    "E:\SteamLibrary\steamapps\common\Warhammer 40,000 Rogue Trader\WH40KRT_Data\StreamingAssets\Localization",
    "C:\Program Files (x86)\Steam\steamapps\common\Warhammer 40,000 Rogue Trader\WH40KRT_Data\StreamingAssets\Localization",
    "D:\SteamLibrary\steamapps\common\Warhammer 40,000 Rogue Trader\WH40KRT_Data\StreamingAssets\Localization",
    "C:\Steam\steamapps\common\Warhammer 40,000 Rogue Trader\WH40KRT_Data\StreamingAssets\Localization"
)

# 자동으로 경로 찾기
$GamePath = $null
foreach ($path in $PossiblePaths) {
    if (Test-Path $path) {
        $GamePath = $path
        break
    }
}

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Warhammer 40K Rogue Trader 번역 업데이트" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# 경로를 찾지 못한 경우 사용자 입력 요청
if (-not $GamePath) {
    Write-Host "`n게임 설치 경로를 자동으로 찾을 수 없습니다." -ForegroundColor Yellow
    Write-Host "다음 중 해당하는 경로를 선택하세요 (또는 직접 입력):" -ForegroundColor Yellow
    for ($i = 0; $i -lt $PossiblePaths.Count; $i++) {
        Write-Host "  $($i+1). $($PossiblePaths[$i])"
    }
    Write-Host "  0. 직접 입력"
    Write-Host ""
    
    $choice = Read-Host "선택 (번호 입력)"
    
    if ($choice -eq "0") {
        Write-Host "`n전체 경로를 입력하세요" -ForegroundColor Yellow
        Write-Host "예: D:\Games\Steam\steamapps\common\Warhammer 40,000 Rogue Trader\WH40KRT_Data\StreamingAssets\Localization"
        $GamePath = Read-Host "경로"
    } elseif ($choice -match "^[1-4]$") {
        $GamePath = $PossiblePaths[[int]$choice - 1]
    } else {
        Write-Host "`n잘못된 선택입니다." -ForegroundColor Red
        Read-Host "엔터키를 눌러 종료"
        exit 1
    }
}

# 경로 최종 확인
Write-Host "`n[1/5] 게임 경로 확인 중..." -NoNewline
if (-not (Test-Path $GamePath)) {
    Write-Host " [실패]" -ForegroundColor Red
    Write-Host "경로를 찾을 수 없습니다: $GamePath" -ForegroundColor Red
    Read-Host "엔터키를 눌러 종료"
    exit 1
}
Write-Host " [OK]" -ForegroundColor Green
Write-Host "      $GamePath" -ForegroundColor Gray

$BackupFile = Join-Path $GamePath ("enGB_backup_{0:yyyyMMdd}.json" -f (Get-Date))
$ReleaseUrl = "https://github.com/ozt88/rogue-trader-korean-translation/releases/latest/download/enGB.json"
$TempFile = Join-Path $env:TEMP "enGB_new.json"

# 2. 다운로드
Write-Host "`n[2/5] 최신 번역 파일 다운로드 중..." -NoNewline
try {
    Invoke-WebRequest -Uri $ReleaseUrl -OutFile $TempFile -UseBasicParsing -ErrorAction Stop
    Write-Host " [OK]" -ForegroundColor Green
} catch {
    Write-Host " [실패]" -ForegroundColor Red
    Write-Host "다운로드 실패: $_" -ForegroundColor Red
    Read-Host "엔터키를 눌러 종료"
    exit 1
}

# 3. 백업
Write-Host "`n[3/5] 기존 파일 백업 중..." -NoNewline
$OriginalFile = Join-Path $GamePath "enGB.json"
if (Test-Path $OriginalFile) {
    Copy-Item $OriginalFile $BackupFile -Force
    Write-Host " [OK]" -ForegroundColor Green
    Write-Host "      백업: enGB_backup_$(Get-Date -Format 'yyyyMMdd').json" -ForegroundColor Gray
} else {
    Write-Host " [걍단]" -ForegroundColor Yellow
    Write-Host "      기존 파일이 없습니다." -ForegroundColor Gray
}

# 4. 적용
Write-Host "`n[4/5] 새 번역 파일 적용 중..." -NoNewline
try {
    Copy-Item $TempFile $OriginalFile -Force -ErrorAction Stop
    Write-Host " [OK]" -ForegroundColor Green
} catch {
    Write-Host " [실패]" -ForegroundColor Red
    Write-Host "파일 복사 실패: $_" -ForegroundColor Red
    Write-Host "관리자 권한으로 다시 실행해 주세요." -ForegroundColor Yellow
    Read-Host "엔터키를 눌러 종료"
    exit 1
}

# 5. 정리
Write-Host "`n[5/5] 임시 파일 정리 중..." -NoNewline
Remove-Item $TempFile -Force -ErrorAction SilentlyContinue
Write-Host " [OK]" -ForegroundColor Green

# 완료
Write-Host "`n========================================" -ForegroundColor Green
Write-Host "업데이트 완료! 게임을 실행해 보세요." -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
Write-Host ""
Write-Host "백업 파일: $BackupFile" -ForegroundColor Gray
Write-Host ""
Read-Host "엔터키를 눌러 종료"
