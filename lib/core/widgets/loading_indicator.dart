import 'package:flutter/material.dart';
import 'package:recipe_app/style/colors/recipe_colors.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      color: RecipeColors.primary700.color,
      strokeWidth: 3,
    );
  }
}
