import 'package:recipe_app/features/food/data/models/recipe_detail.dart';

sealed class RecipeDetailState {}

class RecipeDetailInitialState extends RecipeDetailState {}

class RecipeDetailLoadingState extends RecipeDetailState {}

class RecipeDetailLoadedState extends RecipeDetailState {
  final RecipeDetail data;

  RecipeDetailLoadedState(this.data);
}

class RecipeDetailErrorState extends RecipeDetailState {
  final String message;

  RecipeDetailErrorState(this.message);
}
