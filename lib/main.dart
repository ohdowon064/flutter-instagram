import 'package:flutter/material.dart';
import 'package:instagram/style.dart' as style;

void main() {
  runApp(
    MaterialApp(
      theme: style.themeData,
      home: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        actions: [
          IconButton(
            icon: Icon(Icons.add_box_outlined),
            onPressed: () {},
          )
        ],
        title: Text(
          'Instagram',
          style: style.appBarTextStyle,
        ),
      ),
      body: Theme(
        data: ThemeData(
          textTheme: TextTheme(
            bodyText2: TextStyle(
              color: Colors.blue,
            ),
          ),
        ),
        child: TextButton(
          onPressed: () {},
          child: Text('Hello', style: Theme.of(context).textTheme.bodyText2),
        ),
      ),
    );
  }
}
