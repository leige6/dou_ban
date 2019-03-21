import 'package:dou_ban/add/add.dart';
import 'package:dou_ban/me/me.dart';
import 'package:dou_ban/movie/movie_list_page.dart';
import 'package:flutter/material.dart';

class AppThree extends StatelessWidget {

  final String title;

  AppThree({Key key, this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) => MaterialApp(home: Home1());
}

class Home1 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _Home1State();
}

class _Home1State extends State<Home1> {
  int _index = 0;
  List<Widget> _tabPages;
  Color _tabColor = Colors.white;

  @override
  void initState() {
    super.initState();
    // 初始化页面列表
    _tabPages = <Widget>[
      // 首页
      MovieListPage(),
      // 我的
      Me(),
      Add()
    ];
  }

  ///BottomAppBar: 完全可以自定义
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (BuildContext context) {
              return Add();
            }));
          },
          child: Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        body: _tabPages[_index],
        bottomNavigationBar: BottomAppBar(
          color: Colors.lightBlue,
          shape: CircularNotchedRectangle(),
          child: tabs(),
        ),
      ),
    );
  }

  Row tabs() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        new Container(
          child: IconButton(
            icon: Icon(Icons.near_me),
            color: _tabColor,
            onPressed: () {
              setState(() {
                _tabColor = Colors.orangeAccent;
                _index = 0;
              });
            },
          ),
        ),
        IconButton(
          icon: Icon(Icons.edit_location),
          color: Colors.white,
          onPressed: () {
            setState(() {
              _tabColor = Colors.white;
              _index = 1;
            });
          },
        ),
      ],
    );
  }
}