import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class Add extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AddState();
}

class _AddState extends State<Add> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("增加", style: new TextStyle(color: Colors.white)),
          iconTheme: new IconThemeData(color: Colors.white),
        ),
        body:new Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
        )
    );

  }
}
