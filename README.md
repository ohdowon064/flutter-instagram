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