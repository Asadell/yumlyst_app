import 'package:recipe_app/features/food/data/models/recipe_detail.dart';
import 'package:recipe_app/features/food/data/services/recipe_detail_service.dart';

class RecipeDetailRepository {
  final RecipeService _recipeService;

  RecipeDetailRepository(this._recipeService);

  Future<RecipeDetail> getRecipeDetail(String recipeId) async {
    return await _recipeService.getRecipeDetail(recipeId);
  }
}
