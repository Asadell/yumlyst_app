import 'package:dio/dio.dart';
import '../storage/secure_storage.dart';
import 'interceptors/auth_interceptor.dart';
import 'interceptors/logging_interceptor.dart';
import 'api_endpoints.dart';

class DioClient {
  final Dio _dio;
  final SecureStorageService _secureStorage;

  DioClient(this._secureStorage) : _dio = Dio() {
    _dio.options.baseUrl = ApiEndpoints.baseUrl;
    _dio.options.connectTimeout = const Duration(seconds: 30);
    _dio.options.receiveTimeout = const Duration(seconds: 30);
    _dio.interceptors.add(AuthInterceptor(_secureStorage));
    _dio.interceptors.add(LoggingInterceptor());
  }

  Dio get dio => _dio;
}
