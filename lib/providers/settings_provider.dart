import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dailyhabit/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class SettingsProvider with ChangeNotifier {
  static const String _themeKey = 'theme_mode';
  static const String _languageKey = 'language_code';
  
  ThemeMode _themeMode = ThemeMode.system;
  Locale _locale = Locale('en');
  bool _isLoading = true;
  
  ThemeMode get themeMode => _themeMode;
  Locale get locale => _locale;
  bool get isLoading => _isLoading;
  
  SettingsProvider() {
    _loadSettings();
  }
  
  Future<void> _loadSettings() async {
    _isLoading = true;
    notifyListeners();
    
    try {
      final prefs = await SharedPreferences.getInstance();
      
      // Load theme mode
      final themeModeString = prefs.getString(_themeKey);
      if (themeModeString != null) {
        _themeMode = ThemeMode.values.firstWhere(
          (mode) => mode.toString() == themeModeString,
          orElse: () => ThemeMode.system,
        );
      }
      
      // Load language
      final languageCode = prefs.getString(_languageKey);
      if (languageCode != null) {
        _locale = Locale(languageCode);
      }
    } catch (e) {
      print('Error loading settings: $e');
      // Keep default values if there's an error
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
  
  // Method to get user-specific settings key
  String _getUserSpecificKey(String baseKey, BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final userId = authProvider.userId ?? 'default';
    return '${baseKey}_$userId';
  }
  
  // Method to load user-specific settings
  Future<void> loadUserSpecificSettings(BuildContext context) async {
    if (!Provider.of<AuthProvider>(context, listen: false).isAuthenticated) {
      return; // Don't load user-specific settings if not authenticated
    }
    
    _isLoading = true;
    notifyListeners();
    
    try {
      final prefs = await SharedPreferences.getInstance();
      final themeKey = _getUserSpecificKey(_themeKey, context);
      final languageKey = _getUserSpecificKey(_languageKey, context);
      
      // Load user-specific theme mode
      final themeModeString = prefs.getString(themeKey);
      if (themeModeString != null) {
        _themeMode = ThemeMode.values.firstWhere(
          (mode) => mode.toString() == themeModeString,
          orElse: () => ThemeMode.system,
        );
      }
      
      // Load user-specific language
      final languageCode = prefs.getString(languageKey);
      if (languageCode != null) {
        _locale = Locale(languageCode);
      }
    } catch (e) {
      print('Error loading user-specific settings: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
  
  // Method to save user-specific settings
  Future<void> saveUserSpecificSettings(BuildContext context) async {
    if (!Provider.of<AuthProvider>(context, listen: false).isAuthenticated) {
      return; // Don't save user-specific settings if not authenticated
    }
    
    try {
      final prefs = await SharedPreferences.getInstance();
      final themeKey = _getUserSpecificKey(_themeKey, context);
      final languageKey = _getUserSpecificKey(_languageKey, context);
      
      await prefs.setString(themeKey, _themeMode.toString());
      await prefs.setString(languageKey, _locale.languageCode);
    } catch (e) {
      print('Error saving user-specific settings: $e');
    }
  }
  
  // Set theme mode - only saves to user-specific settings if authenticated
  Future<void> setThemeMode(ThemeMode mode, BuildContext context) async {
    if (_themeMode == mode) return;
    
    _themeMode = mode;
    notifyListeners();
    
    try {
      final prefs = await SharedPreferences.getInstance();
      
      // Only save to user-specific settings if authenticated
      if (Provider.of<AuthProvider>(context, listen: false).isAuthenticated) {
        final themeKey = _getUserSpecificKey(_themeKey, context);
        await prefs.setString(themeKey, mode.toString());
      } else {
        // For non-authenticated users, save to global settings
        await prefs.setString(_themeKey, mode.toString());
      }
    } catch (e) {
      print('Error saving theme mode: $e');
    }
  }
  
  // Set locale - only saves to user-specific settings if authenticated
  Future<void> setLocale(String languageCode, BuildContext context) async {
    if (_locale.languageCode == languageCode) return;
    
    _locale = Locale(languageCode);
    notifyListeners();
    
    try {
      final prefs = await SharedPreferences.getInstance();
      
      // Only save to user-specific settings if authenticated
      if (Provider.of<AuthProvider>(context, listen: false).isAuthenticated) {
        final languageKey = _getUserSpecificKey(_languageKey, context);
        await prefs.setString(languageKey, languageCode);
      } else {
        // For non-authenticated users, save to global settings
        await prefs.setString(_languageKey, languageCode);
      }
    } catch (e) {
      print('Error saving language: $e');
    }
  }
} 