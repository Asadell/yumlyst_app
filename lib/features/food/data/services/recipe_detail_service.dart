import 'package:dio/dio.dart';
import 'package:recipe_app/core/network/api_endpoints.dart';
import 'package:recipe_app/core/network/base_response.dart';
import 'package:recipe_app/features/food/data/models/recipe_detail.dart';

class RecipeService {
  final Dio _dio;

  RecipeService(this._dio);

  Future<RecipeDetail> getRecipeDetail(String recipeId) async {
    try {
      final result = await _dio.get(
        '${ApiEndpoints.recipeDetail}/$recipeId',
      );

      final response = BaseResponse<RecipeDetail?>.fromJson(
        result.data,
        (json) => json != null
            ? RecipeDetail.fromJson(json as Map<String, dynamic>)
            : null,
      );

      if (response.statusCode == 200 && response.data != null) {
        return response.data!;
      } else {
        final message = response.message ?? 'Failed to get recipe details';
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
