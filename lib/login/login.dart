import 'package:dou_ban/res/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  var textStr='登陆你的本地通,精彩永不丢失';
  var _userNameController = new TextEditingController();
  var _userPassController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return  new Scaffold(

        body:ListView(
            children: <Widget>[
              new Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    new Container(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        icon: Icon(Icons.clear),
                        color: Colours.app_clear,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    loginTopInfo(),
                    userNameInput(),
                    passWordInput(),
                    loginButton(),
                    findPassAndRegister()
                  ])
            ])
    );

  }

  Widget loginTopInfo()  {
    return new Padding(
      padding:EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
      child: new Text(
          textStr,
          textAlign:TextAlign.center,
          maxLines:1,
          style: new TextStyle(
            color: Colours.app_login_top_info,
            fontSize: 20.0,
          )
      ),
    );
  }
/*
  用户名输入框
 */
  Widget userNameInput(){
    return new Container(
        //padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
        margin: EdgeInsets.fromLTRB(30.0, 60.0, 30.0, 20.0),
        padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey, width: 1.0),
            borderRadius: BorderRadius.circular(50.0)),
            child: new TextField(
              controller: _userNameController,
              decoration: new InputDecoration(
                  hintText: "请输入用户名",
                  hintStyle:TextStyle(
                    color: Colours.app_gray,
                    fontSize: 16,
                  ),
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.account_box,
                    color:Colours.app_login_top_info ,
                  ),
                  suffixIcon: new IconButton(
                    color:Colours.app_login_top_info ,
                   // padding: EdgeInsets.all(1.0),
                    icon: new Icon(Icons.clear),
                    iconSize:20,
                    onPressed: (){
                      _userNameController.clear();
                    } ,
                  )
              ),
              maxLines:1,
              textAlign: TextAlign.left,//设置内容显示位置是否居中等
              style: new TextStyle(
                fontSize: 16.0,
                color: Colors.black,
              ),
              //autofocus: true,//自动获取焦点
            )
    );
  }

  /*
  密码输入框
 */
  Widget passWordInput(){
    return new Container(
      //padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
        margin: EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 20.0),
        padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey, width: 1.0),
            borderRadius: BorderRadius.circular(50.0)),
            child: new TextField(
              controller: _userPassController,
              decoration: new InputDecoration(
                  hintText: "请输入密码",
                  hintStyle:TextStyle(
                    color: Colours.app_gray,
                    fontSize: 16,
                  ),
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.lock,
                    color:Colours.app_login_top_info ,
                  ),
                  suffixIcon: new IconButton(
                    color:Colours.app_login_top_info ,
                    // padding: EdgeInsets.all(1.0),
                    icon: new Icon(Icons.clear),
                    iconSize:20,
                    onPressed: (){
                      _userPassController.clear();
                    } ,
                  )
              ),
              maxLines:1,
              textAlign: TextAlign.left,//设置内容显示位置是否居中等
              style: new TextStyle(
                fontSize: 16.0,
                color: Colors.black,
              ),
              //autofocus: true,//自动获取焦点
              obscureText: true,
            )
    );
  }

  /*
  登陆按钮
 */
  Widget loginButton(){
    return new Container(
        width: 360.0,
        margin: EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 20.0),
        //padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
        child:  new FlatButton(
                color: Colors.red,
                shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: Colors.red,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(50)),
                onPressed: () {
                  print("the pass is" + _userNameController.text);
                },
                child: new Padding(
                  padding: new EdgeInsets.all(10.0),
                  child: new Text(
                    '马上登录',
                    style:
                    new TextStyle(color: Colors.white, fontSize: 16.0),
                  ),
                )
            )

    );
  }


  /*
  注册和找回密码
 */
  Widget findPassAndRegister(){
    return new Container(
        width: 200.0,
        margin: EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 20.0),
        //padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
        child: new Row(
        children: <Widget>[
            new Expanded(
              child: new Text('账号注册',
                  textAlign: TextAlign.center,
                  style: new TextStyle(
                    fontSize: 16.0,
                    color: Colours.app_register_info,
                  ),
              ),
            ),
            new Text('|',
                textAlign: TextAlign.center,
                style: new TextStyle(
                fontSize: 16.0,
                color: Colours.app_gray,
                ),
            ),
            new Expanded(
              child: new Text('密码登陆',
                    textAlign: TextAlign.center,
                    style: new TextStyle(
                      fontSize: 16.0,
                      color: Colours.app_register_info,
                    ),
              ),
            ),
        ])

    );
  }
}