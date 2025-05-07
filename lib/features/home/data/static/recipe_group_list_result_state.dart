import 'package:recipe_app/features/home/data/models/recipe_group.dart';

sealed class RecipeGroupListResultState {}

class RecipeGroupListNoneState extends RecipeGroupListResultState {}

class RecipeGroupListLoadingState extends RecipeGroupListResultState {}

class RecipeGroupListErrorState extends RecipeGroupListResultState {
  final String error;

  RecipeGroupListErrorState(this.error);
}

class RecipeGroupListLoadedState extends RecipeGroupListResultState {
  final List<RecipeGroup> data;

  RecipeGroupListLoadedState(this.data);
}
