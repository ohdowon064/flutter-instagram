import 'dart:html';
import 'dart:math';

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

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int currentTab = 0; // 홈, 샵

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
      body: [HomeTab(), Text("샵탭")][currentTab],
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: (tabNumber) {
          setState(() {
            currentTab = tabNumber;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag_outlined),
            label: 'shop',
          ),
        ],
      ),
    );
  }
}

class HomeTab extends StatelessWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 3,
      itemBuilder: (context, index) {
        return SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              Container(
                color: Colors.black,
                child: Image.asset(
                  "bb.jpg",
                  width: double.infinity,
                  height: min(MediaQuery.of(context).size.width, 500),
                ),
              ),
              Container(
                height: 100,
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("좋아요 100"),
                    Text("글쓴이"),
                    Text("글내용"),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
