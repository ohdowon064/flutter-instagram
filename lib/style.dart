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
