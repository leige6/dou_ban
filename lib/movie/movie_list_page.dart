import 'dart:convert';
import 'dart:io';
import 'package:dou_ban/model/movie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_refresh/flutter_refresh.dart';

class MovieListPage extends StatefulWidget {
  @override
  MovieListPageState createState() => new MovieListPageState();
}

class MovieListPageState extends State<MovieListPage> with AutomaticKeepAliveClientMixin{

  int start=0;
  List<dynamic> movies = [];
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    getMovieListData();
  }


  Future<Null> onFooterRefresh() {
    return new Future.delayed(new Duration(seconds: 1), () {
      setState(() {
        start += 10;
        getMovieListData();
      });
    });
  }


  Future<Null> onHeaderRefresh() {
    return new Future.delayed(new Duration(seconds: 1), () {
      setState(() {
        start = 0;
        getMovieListData();
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    super.build(context);//AutomaticKeepAliveClientMixin起作用必须添加
    return Scaffold(
        body: Center(
          child: new Refresh(
            onFooterRefresh: onFooterRefresh,
            onHeaderRefresh: onHeaderRefresh,
            childBuilder: (BuildContext context,
                {ScrollController controller, ScrollPhysics physics}) {
              return new Container(
                  child: new ListView.builder(
                    physics: physics,
                    controller: controller,
                    itemCount: movies.length,
                    itemBuilder: (context, item) {
                      return buildMovieItems(item);
                    },
                  ));
            },
          ),
        ),

    );
  }




  //展示数据内容
  Widget  buildMovieItems(var index) {
      Movie movie = movies[index];
      var movieImage = new Padding(
        padding: const EdgeInsets.only(
          top: 10.0,
          left: 10.0,
          right: 10.0,
          bottom: 10.0,
        ),
        child: new Image.network(
          movie.smallImage,
          width: 100.0,
          height: 120.0,
        ),
      );

      var movieMsg = new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            new Text(
              movie.title,
              textAlign: TextAlign.left,
              style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0),
            ),
            new Text('导演：' + movie.director),
            new Text('主演：' + movie.cast),
            new Text('评分：' + movie.average),
            new Text(
              movie.collectCount.toString() + '人看过',
              style: new TextStyle(
                fontSize: 12.0,
                color: Colors.redAccent,
              ),
            ),
          ]
      );
      var movieItem = new GestureDetector(
          onTap: () => navigateToMovieDetailPage(movie),
          child: new Column(
              children: <Widget>[
                new Row(
                    children: <Widget>[
                      movieImage,
                      //Expanded 均分
                      new Expanded(
                        child: movieMsg,
                      ),
                      const Icon(Icons.keyboard_arrow_right),
                    ]
                ),
                new Divider(height: 1),
              ]
          ),
      );
    return movieItem;
  }

  //点击事件
  // 跳转页面
  navigateToMovieDetailPage(Movie movie) {
    print('点击电影：'+movie.title);
  }


  getMovieListData() async {
    print("当前页数："+start.toString());
    var httpClient = new HttpClient();
    var url = 'https://api.douban.com/v2/movie/in_theaters?apikey=0b2bdeda43b5688921839c8ecb20399b&city=%E5%8C%97%E4%BA%AC&start=$start&count=10&client=&udid=';
    var request = await httpClient.getUrl(Uri.parse(url));
    var response = await request.close();
    if (response.statusCode == HttpStatus.OK) {
      var jsonData = await response.transform(utf8.decoder).join();
      // setState 相当于 runOnUiThread
      setState(() {
        if(start==0){
          movies.clear();
        }
        List <Movie> movieNew = Movie.decodeData(jsonData.toString());
        print(movieNew);
        print('加载到电影数据条数:'+movieNew.length.toString());
        movies.addAll(movieNew);
        print('加载后电影数据总条数:'+movies.length.toString());
        print(movies);
      });
    }
  }

}

