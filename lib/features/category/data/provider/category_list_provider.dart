import 'package:flutter/widgets.dart';
import 'package:recipe_app/features/category/data/models/category.dart';
import 'package:recipe_app/features/category/data/repositories/category_list_repository.dart';
import 'package:recipe_app/features/category/data/static/category_list_result_state.dart';

class CategoryListProvider extends ChangeNotifier {
  final CategoryRepository _repository;

  CategoryListProvider(this._repository);

  List<Category> _allCategories = [];
  CategoryListResultState _resultState = CategoryListNoneState();

  CategoryListResultState get resultState => _resultState;
  List<Category> get allCategories => _allCategories;

  Future<void> loadCategories() async {
    try {
      _resultState = CategoryListLoadingState();
      notifyListeners();

      final result = await _repository.getCategories();
      _allCategories = result;
      _resultState = CategoryListLoadedState(result);
      notifyListeners();
    } catch (e) {
      _resultState = CategoryListErrorState(e.toString());
      notifyListeners();
    }
  }
}
