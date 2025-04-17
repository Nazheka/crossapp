// lib/pages/splash/splash_screen.dart

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dailyhabit/pages/home/index.dart';
import 'package:dailyhabit/pages/get_started/index.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    )..repeat(); // бесконечное вращение

    // Через 3 секунды переходим на следующий экран
    Future.delayed(Duration(seconds: 3), () async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      bool isStarted = prefs.getBool('isStarted') ?? false;
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => isStarted ? Home() : GetStarted(),
        ),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: RotationTransition(
          turns: _controller,
          child: Image.asset('assets/images/round_logo.png', width: 100),
        ),
      ),
    );
  }
}
