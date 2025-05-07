import 'package:recipe_app/features/home/data/models/recipe_group.dart';
import 'package:recipe_app/features/home/data/services/recipe_group_service.dart';

class RecipeRepository {
  final RecipeGroupService _recipeService;

  RecipeRepository(this._recipeService);

  Future<List<RecipeGroup>> getHomeRecipes() async {
    return await _recipeService.getHomeRecipes();
  }
}
