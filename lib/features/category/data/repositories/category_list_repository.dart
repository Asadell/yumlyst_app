import 'package:recipe_app/features/category/data/models/category.dart';
import 'package:recipe_app/features/category/data/services/category_list_service.dart';

class CategoryRepository {
  final CategoryListService _categoryService;

  CategoryRepository(this._categoryService);

  Future<List<Category>> getCategories() async {
    return await _categoryService.getCategories();
  }
}
