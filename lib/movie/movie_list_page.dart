import 'dart:convert';
import 'dart:io';
import 'package:dou_ban/model/movie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class MovieListPage extends StatefulWidget {
  @override
  MovieListPageState createState() => new MovieListPageState();
}

class MovieListPageState extends State<MovieListPage> with AutomaticKeepAliveClientMixin{

  GlobalKey<EasyRefreshState> _easyRefreshKey = new GlobalKey<EasyRefreshState>();
  GlobalKey<RefreshHeaderState> _headerKey = new GlobalKey<RefreshHeaderState>();
  GlobalKey<RefreshFooterState> _footerKey = new GlobalKey<RefreshFooterState>();
  var start=0;
  List<Movie> movies = [];

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    //一进页面就请求接口，一开始不知道这个 initState 方法 ，折腾了很久
    getMovieListData();
  }



  @override
  Widget build(BuildContext context) {
    super.build(context);//AutomaticKeepAliveClientMixin起作用必须添加
    return Scaffold(
      body: Center(
          child: new EasyRefresh(
            key: _easyRefreshKey,
            autoLoad: false,
            behavior: ScrollOverBehavior(),
            refreshHeader: ClassicsHeader(
              key: _headerKey,
              refreshText: '下拉刷新',
              refreshReadyText:'松开刷新',
              refreshingText: '加载中' + "...",
              refreshedText: '更新中',
              moreInfo:'更新中',
              bgColor: Colors.transparent,
              textColor: Colors.black87,
              moreInfoColor: Colors.black54,
              showMore: true,
            ),
            refreshFooter: ClassicsFooter(
              key: _footerKey,
              loadText: '下拉加载',
              loadReadyText: '松开刷新',
              loadingText: '加载中',
              loadedText:'加载完成',
              noMoreText: '加载完成',
              moreInfo: '下拉加载更多',
              bgColor: Colors.transparent,
              textColor: Colors.black87,
              moreInfoColor: Colors.black54,
              showMore: true,
            ),
            child: new ListView.builder(
              //ListView的Item
                itemCount: movies.length,
                itemBuilder: (BuildContext context,int index){
                  return buildMovieItems(index);
                }
            ),
            onRefresh: () async{
              await new Future.delayed(const Duration(seconds: 0), () {
                setState(() {
                  start=0;
                  getMovieListData();
                });
              });
            },
            loadMore: () async {
              await new Future.delayed(const Duration(seconds: 0), () {
                  setState(() {
                    start+=10;
                    getMovieListData();
                  });
              });
            },
          )
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  //展示数据内容
  buildMovieItems(var index) {
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

  //获取数据内容
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

