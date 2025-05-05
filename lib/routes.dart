import 'package:flutter/material.dart';
import 'package:dailyhabit/pages/detail/index.dart';
import 'package:dailyhabit/pages/get_started/index.dart';
import 'package:dailyhabit/pages/home/index.dart';
import 'package:dailyhabit/pages/chat/index.dart';
import 'package:dailyhabit/pages/about/index.dart';
import 'package:dailyhabit/pages/settings/index.dart';
import 'package:dailyhabit/pages/auth/index.dart';
import 'package:dailyhabit/pages/account/index.dart';

class Routes {
  Routes._();

  //static variables
  static const String getStarted = '/getStarted';
  static const String home = '/home';
  static const String detail = '/detail';
  static const String chat = '/chat';
  static const String about = '/about';
  static const String settings = '/settings';
  static const String auth = '/auth';
  static const String account = '/account';

  static final routes = <String, WidgetBuilder>{
    getStarted: (BuildContext context) => GetStarted(),
    home: (BuildContext context) => Home(),
    detail: (BuildContext context) => Detail(),
    chat: (BuildContext context) => ChatPage(),
    about: (BuildContext context) => AboutPage(),
    settings: (BuildContext context) => SettingsPage(),
    auth: (BuildContext context) => AuthPage(),
    account: (BuildContext context) => AccountPage(),
  };
}
