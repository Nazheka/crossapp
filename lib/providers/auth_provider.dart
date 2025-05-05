import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:dailyhabit/providers/settings_provider.dart';

enum AuthStatus { initial, authenticated, unauthenticated, guest }

class UserData {
  final String id;
  final String username;
  final String password; // In a real app, this would be hashed

  UserData({
    required this.id,
    required this.username,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'password': password,
    };
  }

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json['id'],
      username: json['username'],
      password: json['password'],
    );
  }
}

class AuthProvider extends ChangeNotifier {
  AuthStatus _status = AuthStatus.initial;
  String? _userId;
  String? _username;
  bool _isGuest = false;
  List<UserData> _users = [];

  AuthStatus get status => _status;
  String? get userId => _userId;
  String? get username => _username;
  bool get isGuest => _isGuest;
  bool get isAuthenticated => _status == AuthStatus.authenticated || _status == AuthStatus.guest;

  AuthProvider() {
    _loadAuthState();
    _loadUsers();
  }

  Future<void> _loadUsers() async {
    final prefs = await SharedPreferences.getInstance();
    final usersJson = prefs.getString('users');
    
    if (usersJson != null) {
      final List<dynamic> usersList = json.decode(usersJson);
      _users = usersList.map((user) => UserData.fromJson(user)).toList();
    }
  }

  Future<void> _saveUsers() async {
    final prefs = await SharedPreferences.getInstance();
    final usersJson = json.encode(_users.map((user) => user.toJson()).toList());
    await prefs.setString('users', usersJson);
  }

  Future<void> _loadAuthState() async {
    final prefs = await SharedPreferences.getInstance();
    final savedUserId = prefs.getString('userId');
    final savedUsername = prefs.getString('username');
    final isGuest = prefs.getBool('isGuest') ?? false;

    if (savedUserId != null) {
      _userId = savedUserId;
      _username = savedUsername;
      _isGuest = isGuest;
      _status = isGuest ? AuthStatus.guest : AuthStatus.authenticated;
    } else {
      _status = AuthStatus.unauthenticated;
    }
    notifyListeners();
  }

  // Helper method to load user-specific settings
  Future<void> _loadUserSettings(BuildContext context) async {
    if (context == null) return;
    
    try {
      final settingsProvider = Provider.of<SettingsProvider>(context, listen: false);
      await settingsProvider.loadUserSpecificSettings(context);
    } catch (e) {
      print('Error loading user settings: $e');
    }
  }

  Future<void> loginAsGuest() async {
    final prefs = await SharedPreferences.getInstance();
    
    // Generate a random guest ID
    _userId = 'guest_${DateTime.now().millisecondsSinceEpoch}';
    _username = 'Guest User';
    _isGuest = true;
    
    // Save to preferences
    await prefs.setString('userId', _userId!);
    await prefs.setString('username', _username!);
    await prefs.setBool('isGuest', true);
    
    _status = AuthStatus.guest;
    notifyListeners();
  }

  Future<bool> login(String username, String password, BuildContext context) async {
    // Find user with matching credentials
    final user = _users.firstWhere(
      (user) => user.username == username && user.password == password,
      orElse: () => UserData(id: '', username: '', password: ''),
    );
    
    if (user.id.isEmpty) {
      return false; // User not found or password incorrect
    }
    
    final prefs = await SharedPreferences.getInstance();
    
    _userId = user.id;
    _username = user.username;
    _isGuest = false;
    
    // Save to preferences
    await prefs.setString('userId', _userId!);
    await prefs.setString('username', _username!);
    await prefs.setBool('isGuest', false);
    
    _status = AuthStatus.authenticated;
    notifyListeners();
    
    // Load user-specific settings
    await _loadUserSettings(context);
    
    return true;
  }

  Future<bool> register(String username, String password, BuildContext context) async {
    // Check if username already exists
    if (_users.any((user) => user.username == username)) {
      return false; // Username already taken
    }
    
    // Create new user
    final newUser = UserData(
      id: 'user_${DateTime.now().millisecondsSinceEpoch}',
      username: username,
      password: password,
    );
    
    // Add to users list
    _users.add(newUser);
    await _saveUsers();
    
    final prefs = await SharedPreferences.getInstance();
    
    _userId = newUser.id;
    _username = newUser.username;
    _isGuest = false;
    
    // Save to preferences
    await prefs.setString('userId', _userId!);
    await prefs.setString('username', _username!);
    await prefs.setBool('isGuest', false);
    
    _status = AuthStatus.authenticated;
    notifyListeners();
    
    // Load user-specific settings
    await _loadUserSettings(context);
    
    return true;
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    
    // Clear saved data
    await prefs.remove('userId');
    await prefs.remove('username');
    await prefs.remove('isGuest');
    
    _userId = null;
    _username = null;
    _isGuest = false;
    _status = AuthStatus.unauthenticated;
    notifyListeners();
  }
} 