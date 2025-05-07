import 'package:recipe_app/features/food/data/models/recipe.dart';

class RecipeGroup {
  String title;
  String? subtitle;
  List<Recipe> recipes;

  RecipeGroup({
    required this.title,
    this.subtitle,
    required this.recipes,
  });

  factory RecipeGroup.fromJson(Map<String, dynamic> json) => RecipeGroup(
        title: json["title"],
        subtitle: json["subtitle"],
        recipes:
            List<Recipe>.from(json["recipes"].map((x) => Recipe.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "subtitle": subtitle,
        "recipes": List<dynamic>.from(recipes.map((x) => x.toJson())),
      };
}
