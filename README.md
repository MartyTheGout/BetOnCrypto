# TrendChecker

## 소개
NFT와 암호화폐의 정보를 제공하는 앱, Trend Checker입니다. 현재 주목을 받고 있는 NFT와 암호화폐의 정보를 제공하며, 암호화폐의 경우 종목에 따른 실시간 가격, 거래 대금, 전일 대비 상승률 등의 정보 또한 제공합니다.

- 핵심 개발 기간: 2025.03.06 - 2025.03.11 
- 인원 : 1명

<img width="712" alt="image" src="https://github.com/user-attachments/assets/9be8cdc2-ecc5-448e-b042-d6462e59682a" />


## 주요 기능
- 주목받고 있는 NFT, 암호화폐에 대한 실시간 정보 제공
- 선택한 암호화폐의 상세정보를 제공 (그래프, 기본가격정보, 재무정보 등) 
- 암호화폐의 현재가, 전일대비변동 등의 정보 제공 

## 기술 스택

| 범주             | 기술                                                  |
|------------------|-----------------------------------------------------|
| 언어             | Swift 5                                              |
| UI 프레임워크     | UIKit                                                 |
| 데이터베이스      | Realm                                                  |
| 반응형 프로그래밍  | RxSwift                                                |
| 기타             | DGCharts, Toast, Kingfisher,Alamofire, SnapKit        |

## 주요 개발 전략

### RxSwift 기반 반응형 스트림 구현
- RxSwift 기반 입력/출력 스트림 분리 아키텍처로 UI 이벤트와 비즈니스 로직 간 결합도 최소화, 단방향 데이터 흐름을 통한 예측 가능한 상태 관리.
- 네트워크 요청, 데이터베이스 변경사항, UI 이벤트를 모두 Observable 스트림으로 통합하여 일관된 비동기 처리 방식 제공, RxSwift Driver 타입으로 UI 스레드 보장 및 에러 안전성 확보, debounce와 flatMap 조합으로 네트워크 요청 최적화

### 실시간 데이터 동기화를 위한 데이터베이스-반응형 브리징
- 로컬 데이터베이스의 변경 알림 시스템을 반응형 스트림으로 브리징하여 즐겨찾기 상태 변경을 실시간으로 UI에 반영. 다른 화면에서의 데이터 변경이 현재 화면에 즉시 반영되는 일관된 UX 구현.
- ViewModel 생명주기에 맞춘 관찰자 해제와 약한 참조를 활용한 순환 참조 방지로 안정적인 메모리 관리.

### 전역 네트워크 상태 관리 및 사용자 경험 최적화
- Apple의 Network 프레임워크를 활용해 Wi-Fi, 셀룰러 등 모든 네트워크 인터페이스의 상태를 실시간으로 모니터링하고, 연결 품질까지 고려한 정확한 네트워크 상태 판단.
- 윈도우 계층을 활용한 별도 UI를 통해 앱 전체에 일관된 네트워크 에러 처리를 제공하고, 상태 관리 스트림으로 재시도 로직을 구현하여 네트워크 복구 시 자동으로 정상 상태로 복원되는 seamless한 UX 구현.

### Repository 패턴을 통한 데이터 계층 추상화
- 로컬 데이터베이스, 원격 API, 모킹 데이터를 단일 Repository 인터페이스로 추상화하여 ViewModel이 데이터 출처에 의존하지 않도록 설계. 
- 오프라인 모드나 테스트 환경에서의 유연한 대응 가능.

### DTO 패턴으로 외부 의존성 격리 및 도메인 로직 보호
- 외부 API 응답 모델을 UI에 최적화된 표현 모델로 변환하는 DTO 패턴을 적용하여 API 응답 구조 변경이 내부 비즈니스 로직에 미치는 영향 최소화.
