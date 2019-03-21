import 'package:dou_ban/welcome/page_constance.dart';
import 'package:dou_ban/welcome/skip_down_time_progress.dart';
import 'package:flutter/material.dart';


class WelcomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new WelcomePageState();
  }
}

class WelcomePageState extends State<WelcomePage> implements OnSkipClickListener{

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _delayedGoHomePage();
  }

  _delayedGoHomePage() {
    Future.delayed(new Duration(seconds: 5), () {
      _goHomePage();
    });
  }

  _goHomePage() {
    Navigator.of(context).pushNamedAndRemoveUntil(
        PageConstance.HOME_PAGE, (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return  new Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        new Container(
          color: Colors.white,
          child:  new Image.asset(
            'image/splash_bg.png',
            fit: BoxFit.cover,
          ),
          constraints: new BoxConstraints.expand(),
        ),
        new Container(
          child: Align(
            alignment: Alignment.topRight,
            child: new Container(
              padding: const EdgeInsets.only(top: 30.0, right: 20.0),
              child: new SkipDownTimeProgress(
                Colors.red,
                22.0,
                new Duration(seconds: 5),
                new Size(25.0, 25.0),
                skipText: "跳过",
                clickListener: this,
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  void onSkipClick() {
    _goHomePage();
  }
}