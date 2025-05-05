import 'package:flutter/material.dart';
import 'package:dailyhabit/constants/font_family.dart';

final ThemeData lightThemeData = ThemeData(
  fontFamily: FontFamily.productSans,
  brightness: Brightness.light,
  primaryColor: Color(0xff2F80ED),
  colorScheme: ColorScheme.light(
    primary: Color(0xff2F80ED),
    secondary: Colors.blueAccent,
  ),
  scaffoldBackgroundColor: Colors.white,
  canvasColor: Colors.transparent,
  textTheme: TextTheme(
    bodyLarge: TextStyle(color: Colors.black87),
    bodyMedium: TextStyle(color: Colors.black87, fontSize: 17),
  ),
  iconTheme: IconThemeData(color: Colors.black87),
);

final ThemeData darkThemeData = ThemeData(
  fontFamily: FontFamily.productSans,
  brightness: Brightness.dark,
  primaryColor: Color(0xff2F80ED),
  colorScheme: ColorScheme.dark(
    primary: Color(0xff2F80ED),
    secondary: Colors.blueAccent,
  ),
  scaffoldBackgroundColor: Colors.blueAccent[700],
  canvasColor: Colors.transparent,
  textTheme: TextTheme(
    bodyLarge: TextStyle(color: Colors.white),
    bodyMedium: TextStyle(color: Colors.white, fontSize: 17),
  ),
  iconTheme: IconThemeData(color: Colors.white),
);

// For backward compatibility
final ThemeData themeData = darkThemeData;
