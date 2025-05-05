import 'package:flutter/material.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const _localizedValues = {
    'en': {
      'appTitle': 'Daily Habit',
      'settings': 'Settings',
      'theme': 'Theme',
      'language': 'Language',
      'system': 'System',
      'light': 'Light',
      'dark': 'Dark',
      'english': 'English',
      'russian': 'Russian',
      'start': 'Start',
      'dailyhabit': 'DAILYHABIT',
      'getStartedTitle1': 'Helping you achieve life resolution',
      'getStartedTitle2': 'Set the type of activity, with the reminder feature',
      'getStartedTitle3': 'Get a summary of the data during your DailyHabit journey',
      'chatWithAI': 'Chat with AI',
      'comingSoon': 'Coming soon...',
      'home': 'Home',
      'profile': 'Profile',
      'about': 'About',
    },
    'ru': {
      'appTitle': 'Ежедневные Привычки',
      'settings': 'Настройки',
      'theme': 'Тема',
      'language': 'Язык',
      'system': 'Системная',
      'light': 'Светлая',
      'dark': 'Тёмная',
      'english': 'Английский',
      'russian': 'Русский',
      'start': 'Начать',
      'dailyhabit': 'ЕЖЕДНЕВНЫЕ ПРИВЫЧКИ',
      'getStartedTitle1': 'Помогаем достичь жизненных целей',
      'getStartedTitle2': 'Настройте тип активности с функцией напоминания',
      'getStartedTitle3': 'Получите сводку данных о вашем пути с DailyHabit',
      'chatWithAI': 'Чат с ИИ',
      'comingSoon': 'Скоро...',
      'home': 'Главная',
      'profile': 'Профиль',
      'about': 'О приложении',
    },
  };

  String get appTitle => _localizedValues[locale.languageCode]!['appTitle']!;
  String get settings => _localizedValues[locale.languageCode]!['settings']!;
  String get theme => _localizedValues[locale.languageCode]!['theme']!;
  String get language => _localizedValues[locale.languageCode]!['language']!;
  String get system => _localizedValues[locale.languageCode]!['system']!;
  String get light => _localizedValues[locale.languageCode]!['light']!;
  String get dark => _localizedValues[locale.languageCode]!['dark']!;
  String get english => _localizedValues[locale.languageCode]!['english']!;
  String get russian => _localizedValues[locale.languageCode]!['russian']!;
  String get start => _localizedValues[locale.languageCode]!['start']!;
  String get dailyhabit => _localizedValues[locale.languageCode]!['dailyhabit']!;
  String get getStartedTitle1 => _localizedValues[locale.languageCode]!['getStartedTitle1']!;
  String get getStartedTitle2 => _localizedValues[locale.languageCode]!['getStartedTitle2']!;
  String get getStartedTitle3 => _localizedValues[locale.languageCode]!['getStartedTitle3']!;
  String get chatWithAI => _localizedValues[locale.languageCode]!['chatWithAI']!;
  String get comingSoon => _localizedValues[locale.languageCode]!['comingSoon']!;
  String get home => _localizedValues[locale.languageCode]!['home']!;
  String get profile => _localizedValues[locale.languageCode]!['profile']!;
  String get about => _localizedValues[locale.languageCode]!['about']!;
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'ru'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
} 