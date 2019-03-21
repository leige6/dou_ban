import 'package:dou_ban/login/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class Me extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MeState();
}

class _MeState extends State<Me> with AutomaticKeepAliveClientMixin{

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    print('me initState');
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);//AutomaticKeepAliveClientMixin起作用必须添加
    return Scaffold(
          body: Center(
              child:FlatButton(
                child: Text('去登录'),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Login(),
                          fullscreenDialog: true
                      )
                  );
                },
              ),
          ),
        );

  }
}