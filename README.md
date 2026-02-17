# Warhammer 40,000: Rogue Trader - Korean Translation

한국어 번역 프로젝트

## 프로젝트 개요

이 프로젝트는 **Warhammer 40,000: Rogue Trader** 게임의 영어 원본을 한국어로 번역하는 작업입니다.

## 설치 방법

### 방법 1: 자동 업데이트 스크립트 (권장)

이 프로젝트에는 자동 업데이트 스크립트가 포함되어 있습니다.

#### PowerShell 스크립트 사용 (권장)
```powershell
# 방법 A: 파일 탐색기에서
# update_translation.ps1 파일을 우클릭 > "PowerShell로 실행"

# 방법 B: 터미널에서
powershell -ExecutionPolicy Bypass -File update_translation.ps1
```

#### 배치 파일 사용
```cmd
# update_translation.bat 더블클릭
```

**스크립트 기능:**
- ✅ 자동으로 게임 설치 경로 탐색 (일반적인 경로 4개)
- ✅ 경로를 찾지 못하면 수동 선택 또는 직접 입력
- ✅ GitHub에서 최신 `enGB.json` 자동 다운로드
- ✅ 기존 파일 자동 백업 (날짜 포함)
- ✅ 게임 폼더에 자동 적용
- ✅ 임시 파일 자동 정리

### 방법 2: 수동 설치

1. [Releases 페이지](https://github.com/ozt88/rogue-trader-korean-translation/releases/latest)에서 최신 `enGB.json` 다운로드

2. 게임 설치 폼더로 이동:
   ```
   steamapps\common\Warhammer 40,000 Rogue Trader\WH40KRT_Data\StreamingAssets\Localization
   ```
   (Steam이 설치된 드라이브에 위치. 대부분 `C:\Program Files (x86)\Steam`)

3. 기존 `enGB.json` 백업 (예: `enGB_backup.json`으로 이름 변경)

4. 다운로드한 `enGB.json`을 붙여넣기

5. 게임 실행

## 파일 설명

| 파일 | 설명 |
|------|------|
| `enGB_original.json` | 영어 원본 텍스트 |
| `enGB_new.json` | 한국어 번역본 (작업용) |
| `enGB.json` | 게임 적용 파일 (릴리즈용) |
| `update_translation.ps1` | 자동 업데이트 스크립트 (PowerShell) |
| `update_translation.bat` | 자동 업데이트 스크립트 (CMD) |

---

## GitHub Actions 자동 릴리즈

`enGB_new.json` 파일을 수정하고 태그를 푸시하면 자동으로 Release가 생성됩니다:

```bash
# 번역 수정 후
git add enGB_new.json
git commit -m "번역 수정 내용"
git push origin master

# 태그 생성 및 푸시 (Release 자동 생성)
git tag v1.0.4
git push origin v1.0.4
```

---

## 주요 변경 사항

### v1.0.3
- 3,801개 항목에 문단 분리 적용
- 긴 텍스트 자동 개행으로 가독성 향상
- 자동 업데이트 스크립트 추가

### v1.0.2
- 태그 오류 수정 (서보 스컬 스웜 능력)

---

## 번역 상태

| 항목 | 수량 |
|------|------|
| 총 항목 | 69,795개 |
| 번역 완료 | 69,102개 |
| 미번역 | 693개 (대부분 고유명사) |


## 라이선스

이 번역은 개인적인 학습 목적으로 사용됩니다.
Warhammer 40,000은 Games Workshop의 등록 상표입니다.
