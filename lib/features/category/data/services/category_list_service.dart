import 'package:dio/dio.dart';
import 'package:recipe_app/core/network/api_endpoints.dart';
import 'package:recipe_app/core/network/base_response.dart';
import 'package:recipe_app/features/category/data/models/category.dart';

class CategoryListService {
  final Dio _dio;

  CategoryListService(this._dio);

  Future<List<Category>> getCategories() async {
    try {
      final result = await _dio.get(ApiEndpoints.categories);

      final response = BaseResponse<List<Category>>.fromJson(
        result.data,
        (json) => (json as List<dynamic>)
            .map((item) => Category.fromJson(item as Map<String, dynamic>))
            .toList(),
      );

      if (response.statusCode == 200) {
        return response.data ?? [];
      } else {
        final message = response.message ?? 'Failed to fetch categories';
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
}
