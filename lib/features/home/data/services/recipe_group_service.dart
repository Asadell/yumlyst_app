import 'package:dio/dio.dart';
import 'package:recipe_app/core/network/api_endpoints.dart';
import 'package:recipe_app/core/network/base_response.dart';
import 'package:recipe_app/features/home/data/models/recipe_group.dart';

class RecipeGroupService {
  final Dio _dio;

  RecipeGroupService(this._dio);

  Future<List<RecipeGroup>> getHomeRecipes() async {
    try {
      final result = await _dio.get(ApiEndpoints.homeRecipes);

      final response = BaseResponse<List<RecipeGroup>>.fromJson(
        result.data,
        (json) => (json as List<dynamic>)
            .map((item) => RecipeGroup.fromJson(item as Map<String, dynamic>))
            .toList(),
      );
      print('serviceakjj-$response');

      if (response.statusCode == 200) {
        return response.data ?? [];
      } else {
        final message = response.message ?? 'Failed to fetch home recipes';
        throw Exception(message);
      }
    } catch (error) {
      if (error is DioException) {
        throw Exception(
            error.response?.data['message'] ?? 'Network error occurred');
      }
      throw Exception('An unexpected error occurred');
      // throw Exception('An unexpected error occurredd, ${error.toString()}');
    }
  }
}
