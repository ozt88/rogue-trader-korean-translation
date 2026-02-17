# Warhammer 40,000: Rogue Trader - Korean Translation

한국어 번역 프로젝트

## 프로젝트 개요

이 프로젝트는 **Warhammer 40,000: Rogue Trader** 게임의 영어 원본을 한국어로 번역하는 작업입니다.

## 설치 방법

### 1. 번역 파일 준비

게임 설치 폴더의 Localization 폴더로 이동합니다:

```
steamapps\common\Warhammer 40,000 Rogue Trader\WH40KRT_Data\StreamingAssets\Localization
```

(steamapps 폴더는 Steam이 설치된 드라이브에 위치합니다. 대부분 `C:\Program Files (x86)\Steam`)

### 2. 파일 교체

1. 위 폴더에 있는 기존 `enGB.json` 파일의 이름을 `enGB_backup.json` 등으로 변경하여 백업
2. 프로젝트 폴더의 `enGB_new.json` 파일을 `enGB.json`으로 복사

### 3. 게임 실행

게임을 실행하면 한국어로 표시됩니다.

## 파일 설명

| 파일 | 설명 |
|------|------|
| `enGB_original.json` | 영어 원본 텍스트 |
| `enGB_new.json` | 한국어 번역본 |

## 번역 상태

| 항목 | 수량 |
|------|------|
| 총 항목 | 69,795개 |
| 번역 완료 | 69,102개 |
| 미번역 | 693개 (대부분 고유명사) |

### 수정 완료된 항목

- **태그 오류**: 9개 수정
- **조사 중복**: 545개 수정

## 남은 작업 (자동화 어려움 - 수동 검토 필요)

1. **문체 불일치**: 987개
2. **경어 불일치**: 153개
3. **직역 패턴**: 1,953개 (대부분 양호)

## AI 작업자 참고사항

### 작업 방법

1. **배치별 검토**: 10,000개씩分区画하여 검토
2. **태그 검증**: `{g|...}` 태그 쌍이 일치하는지 확인
3. **직역 확인**: "그들은", "그것은" 등으로 시작하는 번역이 자연스러운지 확인

### 유용한 명령어

```python
# 태그 오류 확인
import json
with open('enGB_original.json') as f: orig = json.load(f)
with open('enGB_new.json') as f: trans = json.load(f)

for uuid in orig['strings']:
    o = orig['strings'][uuid]['Text']
    t = trans['strings'][uuid]['Text']
    if o.count('{g|') != t.count('{/g}'):
        print(f"Tag mismatch: {uuid}")
```

### 참고 파일

- `translation_issues.json` - 분석된 문제점 (삭제됨)
- 이전 작업 로그 참조

## 라이선스

이 번역은 개인적인 학습 목적으로 사용됩니다.
Warhammer 40,000은 Games Workshop의 등록 상표입니다.
