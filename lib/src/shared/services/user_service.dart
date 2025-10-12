import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:charity/src/features/home/models/user_model.dart';

class UserService {
  static const String _userKey = 'current_user';
  static UserModel? _currentUser;

  // Get current user
  static UserModel? get currentUser => _currentUser;

  // Initialize user service
  static Future<void> initialize() async {
    await _loadUserFromStorage();
  }

  // Load user from local storage
  static Future<void> _loadUserFromStorage() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userJson = prefs.getString(_userKey);
      if (userJson != null) {
        final userMap = json.decode(userJson);
        _currentUser = UserModel.fromJson(userMap);
      }
    } catch (e) {
      print('Error loading user from storage: $e');
    }
  }

  // Save user to local storage
  static Future<void> _saveUserToStorage() async {
    if (_currentUser != null) {
      try {
        final prefs = await SharedPreferences.getInstance();
        final userJson = json.encode(_currentUser!.toJson());
        await prefs.setString(_userKey, userJson);
      } catch (e) {
        print('Error saving user to storage: $e');
      }
    }
  }

  // Login user
  static Future<bool> login(String email, String password) async {
    // Simulate API call - in real app, this would call your backend
    await Future.delayed(const Duration(seconds: 1));
    
    // For demo purposes, create a default user
    _currentUser = UserModel(
      id: '1',
      name: 'Mr Hegazy',
      email: email,
      avatarUrl: 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e',
      donatedAmount: '\$150K',
      walletBalance: 500.00,
      donateAsAnonymous: false,
    );
    
    await _saveUserToStorage();
    return true;
  }

  // Register new user
  static Future<bool> register({
    required String name,
    required String email,
    required String password,
  }) async {
    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));
    
    _currentUser = UserModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      email: email,
      avatarUrl: 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e',
      donatedAmount: '\$0',
      walletBalance: 0.0,
      donateAsAnonymous: false,
    );
    
    await _saveUserToStorage();
    return true;
  }

  // Update user profile
  static Future<bool> updateProfile({
    String? name,
    String? email,
    String? avatarUrl,
  }) async {
    if (_currentUser == null) return false;
    
    _currentUser = _currentUser!.copyWith(
      name: name,
      email: email,
      avatarUrl: avatarUrl,
    );
    
    await _saveUserToStorage();
    return true;
  }

  // Update wallet balance
  static Future<bool> updateWalletBalance(double amount) async {
    if (_currentUser == null) return false;
    
    _currentUser = _currentUser!.copyWith(
      walletBalance: _currentUser!.walletBalance + amount,
    );
    
    await _saveUserToStorage();
    return true;
  }

  // Update anonymous donation preference
  static Future<bool> updateAnonymousPreference(bool isAnonymous) async {
    if (_currentUser == null) return false;
    
    _currentUser = _currentUser!.copyWith(
      donateAsAnonymous: isAnonymous,
    );
    
    await _saveUserToStorage();
    return true;
  }

  // Logout user
  static Future<void> logout() async {
    _currentUser = null;
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_userKey);
    } catch (e) {
      print('Error clearing user data: $e');
    }
  }

  // Check if user is logged in
  static bool get isLoggedIn => _currentUser != null;
}
