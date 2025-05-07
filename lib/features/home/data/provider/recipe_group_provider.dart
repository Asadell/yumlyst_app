import 'package:flutter/widgets.dart';
import 'package:recipe_app/features/home/data/models/recipe_group.dart';
import 'package:recipe_app/features/home/data/repositories/recipe_group_respository.dart';
import 'package:recipe_app/features/home/data/static/recipe_group_list_result_state.dart';

class RecipeGroupProvider extends ChangeNotifier {
  final RecipeRepository _repository;

  RecipeGroupProvider(this._repository);

  List<RecipeGroup> _recipeGroups = [];
  RecipeGroupListResultState _resultState = RecipeGroupListNoneState();

  RecipeGroupListResultState get resultState => _resultState;
  List<RecipeGroup> get recipeGroups => _recipeGroups;

  Future<void> loadHomeRecipes() async {
    try {
      _resultState = RecipeGroupListLoadingState();
      notifyListeners();

      final result = await _repository.getHomeRecipes();
      _recipeGroups = result;
      _resultState = RecipeGroupListLoadedState(result);
      notifyListeners();
    } catch (e) {
      _resultState = RecipeGroupListErrorState(e.toString());
      notifyListeners();
    }
  }
}
