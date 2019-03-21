import 'package:dou_ban/home.dart';
import 'package:dou_ban/home1.dart';
import 'package:dou_ban/root.dart';
import 'package:flutter/material.dart';

class PageConstance {
  static String WELCOME_PAGE = '/';
  static String HOME_PAGE = '/home';

  static Map<String, WidgetBuilder> getRoutes() {
    var route = {
      HOME_PAGE: (BuildContext context) {
        return Home(title: 'leige app');
      }
    };

    return route;
  }
}