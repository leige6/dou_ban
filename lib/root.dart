import 'package:dou_ban/me/me.dart';
import 'package:dou_ban/movie/movie_list_page.dart';
import 'package:flutter/material.dart';


/// 应用入口页
class Root extends StatefulWidget {

  final String title;

  Root({Key key, this.title}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _RootState();
  }
}

/// 入口页状态
class _RootState extends State<Root>  {
  int _tabIndex = 0;
  /// 当前被激活的 Tab Index
  /// 所有 Tab 列表页
  List<Widget> _tabPages;
  var tabImages;
  var appBarTitles = ['首页', '我的'];

  final pageController = PageController();
  void onPageChanged(int index) {
    setState(() {
      _tabIndex = index;
    });
  }

  /*
   * 根据选择获得对应的normal或是press的icon
   */
  Image getTabIcon(int curIndex) {
    if (curIndex == _tabIndex) {
      return tabImages[curIndex][1];
    }
    return tabImages[curIndex][0];
  }
  /*
   * 获取bottomTab的颜色和文字
   */
  Text getTabTitle(int curIndex) {
    if (curIndex == _tabIndex) {
      return new Text(appBarTitles[curIndex],
          style: new TextStyle(fontSize: 12.0, color: Colors.red));
    } else {
      return new Text(appBarTitles[curIndex],
          style: new TextStyle(fontSize: 12.0, color: Colors.black));
    }
  }

  /*
   * 根据image路径获取图片
   */
  Image getTabImage(path) {
    return new Image.asset(path, width: 16.0, height: 16.0);
  }


  @override
  void initState() {
    super.initState();
    tabImages = [
      [getTabImage('image/tab_home.png'), getTabImage('image/tab_home_selected.png')],
      [getTabImage('image/tab_me.png'), getTabImage('image/tab_me_selected.png')]
    ];

    // 初始化页面列表
    _tabPages = <Widget>[
      // 首页
      MovieListPage(),
      // 我的
      Me()
    ];
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: PageView(
          children:  _tabPages,
          controller: pageController,
          onPageChanged: onPageChanged,
          physics: new NeverScrollableScrollPhysics(),//禁止滑动
        ),
        // 底部Tab航
      bottomNavigationBar: BottomNavigationBar(
        onTap: (int index) {
          pageController.jumpToPage(index);
        },
        // 与 body 取值方式类似
        type: BottomNavigationBarType.fixed,
        currentIndex: _tabIndex,
        //iconSize: 16,
        items: [
          new BottomNavigationBarItem(
          icon: getTabIcon(0), title: getTabTitle(0)),
          new BottomNavigationBarItem(
          icon: getTabIcon(1), title: getTabTitle(1)),
        ],
      )
    );
  }
}