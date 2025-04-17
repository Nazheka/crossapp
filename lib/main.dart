import 'package:flutter/material.dart';
import 'package:dailyhabit/constants/app_theme.dart';
import 'package:dailyhabit/models/habit.dart';
import 'package:dailyhabit/pages/home/index.dart';
import 'package:dailyhabit/routes.dart';
import 'package:dailyhabit/pages/get_started/index.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  runApp(
    ChangeNotifierProvider(
      create: (context) => habitAdapter,
      child: DailyHabitApp(),
    ),
  );
}

class DailyHabitApp extends StatefulWidget {
  @override
  DailyHabitAppState createState() => DailyHabitAppState();
}

class DailyHabitAppState extends State<DailyHabitApp> {
  Widget? _body;

  @override
  void initState() {
    super.initState();
    _loadStarted();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DAILYHABIT',
      routes: Routes.routes,
      theme: themeData,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.blue,
        body: _body,
      ),
    );
  }

  void _loadStarted() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isStarted = prefs.getBool('isStarted') == null;
    setState(() {
      _body = isStarted ? GetStarted() : Home();
    });
  }
}
