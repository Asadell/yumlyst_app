import 'package:recipe_app/features/auth/data/models/login_request.dart';
import 'package:recipe_app/features/auth/data/models/register_request.dart';

import '../services/auth_service.dart';

class AuthRepository {
  final AuthService _authService;

  AuthRepository(this._authService);

  Future<void> login(String identifier, String password) async {
    final request = LoginRequest(
      identifier: identifier,
      password: password,
    );
    await _authService.login(request);
  }

  Future<void> register(String username, String email, String password) async {
    final request = RegisterRequest(
      username: username,
      email: email,
      password: password,
    );
    await _authService.register(request);
  }

  Future<bool> isLoggedIn() async {
    return await _authService.isLoggedIn();
  }

  Future<void> logout() async {
    await _authService.logout();
  }
}
