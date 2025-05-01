import 'package:flutter/material.dart';
import 'package:recipe_app/features/auth/data/provider/static/auth_status.dart';
import '../../data/repositories/auth_repository.dart';

class AuthProvider extends ChangeNotifier {
  final AuthRepository _authRepository;

  AuthStatus _status = AuthStatus.unauthenticated;
  String? _errorMessage;

  AuthProvider(this._authRepository);

  AuthStatus get status => _status;
  String? get errorMessage => _errorMessage;

  Future<void> login(
      {required String identifier, required String password}) async {
    _errorMessage = null;

    if (identifier.isEmpty || password.isEmpty) {
      _errorMessage = 'Email/Username and Password cannot be empty';
      _status = AuthStatus.error;
      notifyListeners();
      return;
    }

    _status = AuthStatus.authenticating;
    notifyListeners();

    try {
      await _authRepository.login(identifier, password);
      _status = AuthStatus.authenticated;
    } catch (e) {
      _errorMessage = e.toString();
      _status = AuthStatus.error;
    } finally {
      notifyListeners();
    }
  }

  Future<void> register({
    required String username,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    _errorMessage = null;

    if (username.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      _errorMessage = 'All fields are required';
      _status = AuthStatus.error;
      notifyListeners();
      return;
    }

    if (password != confirmPassword) {
      _errorMessage = 'Passwords do not match';
      _status = AuthStatus.error;
      notifyListeners();
      return;
    }

    _status = AuthStatus.creatingAccount;
    notifyListeners();

    try {
      await _authRepository.register(username, email, password);
      _status = AuthStatus.accountCreated;
    } catch (e) {
      _errorMessage = e.toString();
      _status = AuthStatus.error;
    } finally {
      notifyListeners();
    }
  }

  void reset() {
    _status = AuthStatus.unauthenticated;
    _errorMessage = null;
    notifyListeners();
  }
}
