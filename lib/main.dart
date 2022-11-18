import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:instagram/style.dart' as style;
import 'package:loading_indicator/loading_indicator.dart';

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
  var posts = [];

  getData() async {
    var result = await http.get(Uri.parse('https://codingapple1.github.io/app/data.json'));
    if (result.statusCode == 200) {
      setState(() {
        posts = jsonDecode(result.body);
      });
    } else {
      print("error");
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

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
      body: [HomeTab(posts: posts), Text("샵탭")][currentTab],
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

class HomeTab extends StatefulWidget {
  const HomeTab({Key? key, this.posts}) : super(key: key);
  final posts;

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  var scroll = ScrollController();

  @override
  void initState() {
    super.initState();
    scroll.addListener(() {
      if (scroll.position.pixels == scroll.position.maxScrollExtent) {
        print("맨 밑");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.posts.isNotEmpty) {
      return ListView.builder(
        itemCount: widget.posts.length,
        controller: scroll,
        itemBuilder: (context, index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(widget.posts[index]['image']),
              Text('좋아요${widget.posts[index]['likes']}개'),
              Text(widget.posts[index]['user']),
              Text(widget.posts[index]['content']),
            ],
          );
        },
      );
    }else {
      return LoadingIndicator(indicatorType: Indicator.ballPulse);
    }
  }
}
