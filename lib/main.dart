import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          iconTheme: IconThemeData(
            color: Colors.black,
            size: 40,
          ),
          color: Colors.white,
        ),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      home: MyApp(),
    ),
  );
}

const appBarTextStyle = TextStyle(
  color: Colors.black,
  fontSize: 20,
  fontWeight: FontWeight.w500,
);

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        actions: [Icon(Icons.add_box_outlined)],
        title: Text(
          'Instagram',
          style: appBarTextStyle,
        ),
      ),
    );
  }
}
