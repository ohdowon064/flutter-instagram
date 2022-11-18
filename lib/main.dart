import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          color: Colors.grey,
          actionsIconTheme: IconThemeData(color: Colors.red),
        ),
        iconTheme: IconThemeData(color: Colors.blue),
        textTheme: TextTheme( // TextTheme은 TextStyle을 변수로 만들어서 해당 위치에서 사용하는게 낫다.
          bodyText2: TextStyle(color: Colors.green),
        ),
      ),
      home: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [Icon(Icons.star)]),
      body: Text("안녕"),
    );
  }
}
