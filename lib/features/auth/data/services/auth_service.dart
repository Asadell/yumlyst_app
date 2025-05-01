import 'package:dio/dio.dart';
import 'package:recipe_app/core/network/base_response.dart';
import 'package:recipe_app/features/auth/data/models/auth_response.dart';
import 'package:recipe_app/features/auth/data/models/login_request.dart';
import 'package:recipe_app/features/auth/data/models/register_request.dart';
import '../../../../core/network/api_endpoints.dart';
import '../../../../core/storage/secure_storage.dart';

class AuthService {
  final Dio _dio;
  final SecureStorageService _secureStorage;

  AuthService(this._dio, this._secureStorage);

  Future<void> login(LoginRequest request) async {
    try {
      final result = await _dio.post(
        ApiEndpoints.login,
        data: request.toJson(),
      );

      final response = BaseResponse<AuthResponse?>.fromJson(
          result.data,
          (json) => json != null
              ? AuthResponse.fromJson(json as Map<String, dynamic>)
              : null);

      if (response.statusCode == 200) {
        await _secureStorage.saveToken(response.data?.token ?? '');
      } else {
        final message = response.message ?? 'Failed to login';
        throw Exception(message);
      }
    } catch (error) {
      if (error is DioException) {
        throw Exception(
            error.response?.data['message'] ?? 'Network error occurred');
      }
      throw Exception('An unexpected error occurred');
    }
  }

  Future<void> register(RegisterRequest request) async {
    try {
      final result = await _dio.post(
        ApiEndpoints.register,
        data: request.toJson(),
      );

      final response = BaseResponse<AuthResponse?>.fromJson(
          result.data,
          (json) => json != null
              ? AuthResponse.fromJson(json as Map<String, dynamic>)
              : null);

      if (response.statusCode == 200) {
        await _secureStorage.saveToken(response.data?.token ?? '');
      } else {
        final message = response.message ?? 'Failed to register';
        throw Exception(message);
      }
    } catch (error) {
      if (error is DioException) {
        throw Exception(
            error.response?.data['message'] ?? 'Network error occurred');
      }
      throw Exception('An unexpected error occurred');
    }
  }

  Future<bool> isLoggedIn() async {
    return await _secureStorage.hasToken();
  }

  Future<void> logout() async {
    await _secureStorage.deleteToken();
  }
}
