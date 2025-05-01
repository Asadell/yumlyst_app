import 'package:flutter/material.dart';
import 'package:recipe_app/style/colors/recipe_colors.dart';
import 'package:recipe_app/style/typography/recipe_text_styles.dart';

class RecipeTheme {
  static TextTheme get _textTheme {
    return TextTheme(
      displayLarge: RecipeTextStyles.displayLarge,
      displayMedium: RecipeTextStyles.displayMedium,
      displaySmall: RecipeTextStyles.displaySmall,
      headlineLarge: RecipeTextStyles.headlineLarge,
      headlineMedium: RecipeTextStyles.headlineMedium,
      headlineSmall: RecipeTextStyles.headlineSmall,
      titleLarge: RecipeTextStyles.titleLarge,
      titleMedium: RecipeTextStyles.titleMedium,
      titleSmall: RecipeTextStyles.titleSmall,
      bodyLarge: RecipeTextStyles.bodyLargeBold,
      bodyMedium: RecipeTextStyles.bodyLargeMedium,
      bodySmall: RecipeTextStyles.bodyLargeRegular,
      labelLarge: RecipeTextStyles.labelLarge,
      labelMedium: RecipeTextStyles.labelMedium,
      labelSmall: RecipeTextStyles.labelSmall,
    );
  }

  static AppBarTheme get _appBarTheme {
    return AppBarTheme(
      toolbarTextStyle: _textTheme.titleLarge,
      shape: const BeveledRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(14),
          bottomRight: Radius.circular(14),
        ),
      ),
    );
  }

  static ThemeData get lightTheme {
    return ThemeData(
      colorSchemeSeed: RecipeColors.primary900.color,
      brightness: Brightness.light,
      textTheme: _textTheme,
      useMaterial3: true,
      appBarTheme: _appBarTheme,
    );
  }

//  static ThemeData get darkTheme {
//    return ThemeData(
//      colorSchemeSeed: RecipeColors.primary900.color,
//      brightness: Brightness.dark,
//      textTheme: _textTheme,
//      useMaterial3: true,
//      appBarTheme: _appBarTheme,
//    );
//  }
}
