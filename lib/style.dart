import 'package:flutter/material.dart';

var themeData = ThemeData(
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Colors.white,
    selectedItemColor: Colors.black,
    unselectedItemColor: Colors.grey,
  ),
  appBarTheme: AppBarTheme(
    actionsIconTheme: IconThemeData(
      color: Colors.black,
      size: 40,
    ),
    color: Colors.white,
  ),
  iconTheme: IconThemeData(color: Colors.black),
);

const appBarTextStyle = TextStyle(
  color: Colors.black,
  fontSize: 20,
  fontWeight: FontWeight.w500,
);

var _privateVariable; // 언더바를 붙이면 다른 파일에서 못 쓰는 private 변수(함수, 클래스)가 된다.