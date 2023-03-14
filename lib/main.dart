import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram/style.dart' as style;
import 'package:loading_indicator/loading_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  var dio = Dio();
  var isVisible = true;
  var userImage;

  saveData() async {
    var storage = await SharedPreferences.getInstance();
    var map = {'age': 20};
    storage.setString('map', jsonEncode(map));
    print(jsonDecode(storage.getString('map')!)['age']);
  }

  uploadPost(post) {
    setState(() {
      posts.insert(0, post);
    });
  }

  getData() async {
    try {
      var result =
          await dio.get('https://codingapple1.github.io/app/data.json');
      setState(() {
        posts = result.data;
      });
    } catch (e) {
      print("error: $e");
    }
  }

  getMoreData(index) async {
    try {
      var result =
          await dio.get('https://codingapple1.github.io/app/more$index.json');
      print(result.data);
      setState(() {
        posts.add(result.data);
      });
    } catch (e) {
      print("error: $e");
    }
  }

  hide() {
    setState(() {
      isVisible = false;
    });
  }

  show() {
    setState(() {
      isVisible = true;
    });
  }

  @override
  void initState() {
    super.initState();
    saveData();
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
            onPressed: () async {
              var picker = ImagePicker();
              var image = await picker.pickImage(
                  source: ImageSource.gallery, maxHeight: 500, maxWidth: 600);
              setState(() {
                userImage = File(image!.path);
              });
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      Upload(userImage: userImage, uploadPost: uploadPost),
                ),
              );
            },
          )
        ],
        title: Text(
          'Instagram',
          style: style.appBarTextStyle,
        ),
      ),
      body: [
        HomeTab(
          posts: posts,
          getMoreData: getMoreData,
          hide: hide,
          show: show,
        ),
        Text("샵탭")
      ][currentTab],
      bottomNavigationBar: isVisible
          ? BottomNavigationBar(
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
            )
          : null,
    );
  }
}

class HomeTab extends StatefulWidget {
  const HomeTab({Key? key, this.posts, this.getMoreData, this.hide, this.show})
      : super(key: key);
  final posts;
  final getMoreData;
  final hide;
  final show;

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  var scroll = ScrollController();
  var fetchIndex = 1;
  static const maxFetchIndex = 3;

  @override
  void initState() {
    super.initState();
    scroll.addListener(() {
      if (scroll.position.pixels == scroll.position.maxScrollExtent) {
        if (fetchIndex < maxFetchIndex) {
          print("맨밑도달 ====> 데이터 추가로 가져옴");
          widget.getMoreData(fetchIndex);
          fetchIndex++;
        } else {
          print('맨밑이지만 데이터 안가져옴');
        }
      }

      if (scroll.position.userScrollDirection == ScrollDirection.reverse) {
        widget.hide();
      } else {
        widget.show();
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
              widget.posts[index]['image'].runtimeType == String
                  ? Image.network(widget.posts[index]['image'])
                  : Image.file(widget.posts[index]['image']),
              Text('좋아요${widget.posts[index]['likes']}개'),
              GestureDetector(
                  child: Text(widget.posts[index]['user']),
                  onTap: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, ani, ani2) => Profile(),
                        transitionsBuilder: (c, a1, a2, child) =>
                            FadeTransition(opacity: a1, child: child),
                        transitionDuration: Duration(milliseconds: 500),
                      ),
                    );
                  }),
              Text(widget.posts[index]['content']),
            ],
          );
        },
      );
    } else {
      return LoadingIndicator(indicatorType: Indicator.ballPulse);
    }
  }
}

class Upload extends StatefulWidget {
  const Upload({Key? key, this.userImage, this.uploadPost}) : super(key: key);
  final userImage;
  final uploadPost;

  @override
  State<Upload> createState() => _UploadState();
}

class _UploadState extends State<Upload> {
  var post;
  var user;
  var content;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.file(widget.userImage),
            TextField(
              decoration: InputDecoration(
                hintText: '이름을 입력하세요.',
              ),
              onChanged: (text) {
                user = text;
              },
            ),
            TextField(
              decoration: InputDecoration(
                hintText: '내용을 입력하세요',
              ),
              onChanged: (text) {
                content = text;
              },
            ),
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.close)),
            TextButton(
                onPressed: () {
                  setState(() {
                    post = {
                      'image': widget.userImage,
                      'likes': 0,
                      'user': user,
                      'content': content,
                    };
                  });
                  widget.uploadPost(post);
                  Navigator.pop(context);
                },
                child: Text('업로드'))
          ],
        ));
  }
}

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(), body: Text("프로필페이지"));
  }
}
