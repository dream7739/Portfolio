# Portfolio
> 자산 포트폴리오 앱: 사용자의 증권, 원화잔고 구성 현황을 확인할 수 있습니다.

|회원가입(초기화면)|회원가입(유효성 검사)|자산배분|보유주식 목록|
|--------|-----|-----|------|
|<img width = "200" src = "https://github.com/user-attachments/assets/113a2b09-2c5c-419d-ae88-b0219acb2ac1">|<img width = "200" src = "https://github.com/user-attachments/assets/9bd5d9ab-fea1-4cf6-a7cb-bea10a818cc2">|<img width = "200" src = "https://github.com/user-attachments/assets/ec1dc464-5352-4c70-92aa-6e472d4aa468">|<img width = "200" src = "https://github.com/user-attachments/assets/e5c2e0d3-e443-4d30-8a6f-5cac7fd3b981">|


## 프로젝트 환경
- 인원: 1명
- 기간: 2025.03.16 - 2024.03.16
- 버전: iOS 16+ 

## 기술 스택
- iOS: UIKit
- Architecture: MVVM, Singleton
- UI: CodebaseUI, UIBezierPath, SnapKit
- ETC: Toast, Keychain

## 핵심 기능
- 회원가입: 이메일, 아이디, 패스워드, 휴대폰 정보를 통해 서비스를 가입합니다.
- 자산배분: 유저의 주식, 채권, 기타 자산 정보를 확인합니다.
- 보유주식 목록: 유저의 보유주식 목록을 확인할 수 있습니다.

## 주요기술
- DI를 통한 ViewController와 ViewModel간의 의존성 주입
- UIBezierPath를 사용한 원형 그래프 구성
- Keychain을 사용한 유저 이메일, 패스워드 저장  
- Extension과 Computed Property를 사용한 데이터 가공

## 자산 포트폴리오 표시 기준
### 자산배분 화면에서의 비율 산출
- 제공 데이터는 주식, 채권, 현금 세 파트로 구분 되어있습니다.
- 임의로 `신흥시장 주식`과 `신흥시장 채권`, `현금` 세 가지 카테고리로 분류하여 합계를 산출하였습니다.
  
### 보유주식 목록 화면 구성 요소
- 제공 데이터 전체를 화면에 출력합니다.
- 전일대비 수익률과 심볼 이미지는 임의로 구성합니다. (전일대비 수익률: -1부터 +1 사이 랜덤값)