import 'package:recipe_app/features/category/data/models/category.dart';

sealed class CategoryListResultState {}

class CategoryListNoneState extends CategoryListResultState {}

class CategoryListLoadingState extends CategoryListResultState {}

class CategoryListErrorState extends CategoryListResultState {
  final String error;

  CategoryListErrorState(this.error);
}

class CategoryListLoadedState extends CategoryListResultState {
  final List<Category> data;

  CategoryListLoadedState(this.data);
}
