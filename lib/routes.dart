import 'package:flutter/material.dart';
import 'package:dailyhabit/pages/detail/index.dart';
import 'package:dailyhabit/pages/get_started/index.dart';
import 'package:dailyhabit/pages/home/index.dart';
import 'package:dailyhabit/pages/chat/index.dart';

class Routes {
  Routes._();

  //static variables
  static const String getStarted = '/getStarted';
  static const String home = '/home';
  static const String detail = '/detail';
  static const String chat = '/chat';

  static final routes = <String, WidgetBuilder>{
    getStarted: (BuildContext context) => GetStarted(),
    home: (BuildContext context) => Home(),
    detail: (BuildContext context) => Detail(),
    chat: (BuildContext context) => ChatPage(),
  };
}
