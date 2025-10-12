import 'package:flutter/foundation.dart';
import 'package:charity/src/features/home/models/user_model.dart';
import 'package:charity/src/shared/services/user_service.dart';

class UserProvider extends ChangeNotifier {
  UserModel? _user;
  bool _isLoading = false;
  String? _error;

  UserModel? get user => _user;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get isLoggedIn => _user != null;

  // Initialize provider
  Future<void> initialize() async {
    _setLoading(true);
    try {
      await UserService.initialize();
      _user = UserService.currentUser;
      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      _setLoading(false);
    }
  }

  // Login user
  Future<bool> login(String email, String password) async {
    _setLoading(true);
    _error = null;
    
    try {
      final success = await UserService.login(email, password);
      if (success) {
        _user = UserService.currentUser;
        notifyListeners();
        return true;
      } else {
        _error = 'Login failed';
        return false;
      }
    } catch (e) {
      _error = e.toString();
      return false;
    } finally {
      _setLoading(false);
    }
  }

  // Register user
  Future<bool> register({
    required String name,
    required String email,
    required String password,
  }) async {
    _setLoading(true);
    _error = null;
    
    try {
      final success = await UserService.register(
        name: name,
        email: email,
        password: password,
      );
      if (success) {
        _user = UserService.currentUser;
        notifyListeners();
        return true;
      } else {
        _error = 'Registration failed';
        return false;
      }
    } catch (e) {
      _error = e.toString();
      return false;
    } finally {
      _setLoading(false);
    }
  }

  // Update profile
  Future<bool> updateProfile({
    String? name,
    String? email,
    String? avatarUrl,
  }) async {
    _setLoading(true);
    _error = null;
    
    try {
      final success = await UserService.updateProfile(
        name: name,
        email: email,
        avatarUrl: avatarUrl,
      );
      if (success) {
        _user = UserService.currentUser;
        notifyListeners();
        return true;
      } else {
        _error = 'Profile update failed';
        return false;
      }
    } catch (e) {
      _error = e.toString();
      return false;
    } finally {
      _setLoading(false);
    }
  }

  // Update wallet balance
  Future<bool> updateWalletBalance(double amount) async {
    _setLoading(true);
    _error = null;
    
    try {
      final success = await UserService.updateWalletBalance(amount);
      if (success) {
        _user = UserService.currentUser;
        notifyListeners();
        return true;
      } else {
        _error = 'Wallet update failed';
        return false;
      }
    } catch (e) {
      _error = e.toString();
      return false;
    } finally {
      _setLoading(false);
    }
  }

  // Update anonymous donation preference
  Future<bool> updateAnonymousPreference(bool isAnonymous) async {
    _setLoading(true);
    _error = null;
    
    try {
      final success = await UserService.updateAnonymousPreference(isAnonymous);
      if (success) {
        _user = UserService.currentUser;
        notifyListeners();
        return true;
      } else {
        _error = 'Preference update failed';
        return false;
      }
    } catch (e) {
      _error = e.toString();
      return false;
    } finally {
      _setLoading(false);
    }
  }

  // Logout
  Future<void> logout() async {
    _setLoading(true);
    try {
      await UserService.logout();
      _user = null;
      _error = null;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
    } finally {
      _setLoading(false);
    }
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}
