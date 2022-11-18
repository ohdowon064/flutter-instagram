# instagram

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## 페이지 나누기
- Navigator, Router, Tab 존재
- 동적 UI 만드는 3단계
    1. state에 UI 현재상태(몇번째 페이지가 보이는가) 저장
    2. state에 따라 UI가 어떻게 보일지 작성
    3. 유저가 쉽게 state 조작할 수 있게 구현
- 옆으로 슬라이드 페이지 -> PageView 사용

- BottomNavigationBar에서 onTab의 파라미터는 현재 누른 탭의 번호이다.
  - 0부터 시작

## 서버요청
- 로드 시 바로 GET 요청한다. -> initState 구현
- 안드로이드는 인터넷 사용권한 받아야한다. ios는 안해도됨.
- 요청 부분은 async-await 으로 만드는게 낫다.
- json 데이터는 list, map으로 변환필요
  - jsonDecode() 함수 사용
- print로 체크할 때는 함수 안에서 출력하자.
- http request는 시간이 걸린다.
  - 데이터가 채워지기 전에 접근하면 warning이 발생한다.
  - 실제 데이터가 있으면 사용하도록 한다. -> 조건부로 사용 data.isNotEmpty
  - 없으면 로딩중 표시
  - FutureBuilder도 있는데 이것은 한번 데이터 추가 후 변경안되는 경우에 유용하다.
  - 다른 경우에는 그냥 if-else 분기처리하는 것이 낫다.
- 서버 다운, 요청경로 이상 -> 예외처리 필요
  - statusCode 확인
- http 보다는 Dio 패키지를 추천 -> 좀 더 편하다.