import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:dailyhabit/constants/app_theme.dart';
import 'package:dailyhabit/models/habit.dart';
import 'package:dailyhabit/pages/home/index.dart';
import 'package:dailyhabit/routes.dart';
import 'package:dailyhabit/pages/get_started/index.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dailyhabit/pages/splash/splash_screen.dart';
import 'package:dailyhabit/providers/settings_provider.dart';
import 'package:dailyhabit/providers/auth_provider.dart';
import 'package:dailyhabit/l10n/app_localizations.dart';
import 'package:dailyhabit/pages/auth/index.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SettingsProvider()),
        ChangeNotifierProvider(create: (_) => HabitModel()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isLoading = true;
  bool _isStarted = false;

  @override
  void initState() {
    super.initState();
    _loadInitialData();
  }

  Future<void> _loadInitialData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isStarted = prefs.getBool('isStarted') ?? false;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<SettingsProvider, AuthProvider>(
      builder: (context, settings, auth, child) {
        return MaterialApp(
          title: 'Daily Habit',
          themeMode: settings.themeMode,
          theme: lightThemeData,
          darkTheme: darkThemeData,
          locale: settings.locale,
          supportedLocales: const [
            Locale('en'),
            Locale('ru'),
          ],
          localizationsDelegates: const [
            AppLocalizationsDelegate(),
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          home: _isLoading
              ? SplashScreen()
              : !auth.isAuthenticated
                  ? AuthPage()
                  : _isStarted
                      ? Home()
                      : GetStarted(),
          routes: Routes.routes,
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
