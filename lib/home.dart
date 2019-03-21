import 'package:dou_ban/me/me.dart';
import 'package:dou_ban/movie/movie_list_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_bottom_tab_bar/tabbar.dart';
import 'package:flutter_custom_bottom_tab_bar/eachtab.dart';


class Home extends StatefulWidget {
  final String title;

  Home({Key key, this.title}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return HomeState();
  }
}

class HomeState extends State<Home> with SingleTickerProviderStateMixin {
  TabController _tabController;
  int _selectedIndex = 0;
  var titles = ['首页', '我的'];
  var icons = [
    Icons.home,
    Icons.people
  ];
  @override
  void initState() {
    super.initState();
    _tabController =
    new TabController(vsync: this, initialIndex: 0, length: titles.length);
    _tabController.addListener(() {
      setState(() => _selectedIndex = _tabController.index);
      print("liucheng-> ${_tabController.indexIsChanging}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        height: 46,
        child: Column(
          children: <Widget>[
            Divider(
              height: 2,
            ),
            new TabBar(
              isScrollable: false,
              controller: _tabController,
              indicatorColor: Colors.transparent,
              labelColor: Colors.red,
              labelPadding: EdgeInsets.all(0),
              unselectedLabelColor: Colors.black,
              tabs: <Widget>[
                EachTab(
                    width: 70,
                    badgeNo: '12',
                    badgeColor: Colors.red,
                    height: 40,
                    padding: EdgeInsets.all(0),
                    icon: _selectedIndex == 0
                        ? Image.asset(
                      'image/tab_home_selected.png',
                      width: 20,
                      height: 20,
                    )
                        : Image.asset(
                      'image/tab_home.png',
                      width: 20,
                      height: 20,
                    ),
                    text: titles[0],
                    iconPadding: EdgeInsets.fromLTRB(0, 0, 0, 2),
                    textStyle: TextStyle(fontSize: 10)),
                EachTab(
                    height: 40,
                    padding: EdgeInsets.all(0),
                    icon: _selectedIndex == 1
                        ? Image.asset(
                      'image/tab_me_selected.png',
                      width: 20,
                      height: 20,
                    )
                        : Image.asset(
                      'image/tab_me.png',
                      width: 20,
                      height: 20,
                    ),
                    text: titles[1],
                    iconPadding: EdgeInsets.fromLTRB(0, 0, 0, 2),
                    textStyle: TextStyle(fontSize: 10)),
              ],
            ),
          ],
        ),
      ),

      body: TabBarView(
        physics: NeverScrollableScrollPhysics(), //设置滑动的效果，这个禁用滑动
        controller: _tabController,
        children: <Widget>[
          MovieListPage(),
          Me()
        ],
      ),
    );
  }
}