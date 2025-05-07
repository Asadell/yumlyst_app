import 'package:flutter/foundation.dart';
import 'package:recipe_app/features/food/data/repositories/recipe_detail_repository.dart';
import 'package:recipe_app/features/food/data/static/recipe_detail_result_state.dart';

class RecipeDetailProvider extends ChangeNotifier {
  final RecipeDetailRepository _repository;

  RecipeDetailProvider(this._repository);

  RecipeDetailState _state = RecipeDetailInitialState();
  RecipeDetailState get state => _state;

  String? _recipeId;
  String? get recipeId => _recipeId;

  Future<void> getRecipeDetail(String recipeId) async {
    try {
      _recipeId = recipeId;
      _state = RecipeDetailLoadingState();
      notifyListeners();

      final recipe = await _repository.getRecipeDetail(recipeId);
      _state = RecipeDetailLoadedState(recipe);
      notifyListeners();
    } catch (e) {
      _state = RecipeDetailErrorState(e.toString());
      notifyListeners();
    }
  }
}
