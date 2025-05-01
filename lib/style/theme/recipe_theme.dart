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

  static TextSelectionThemeData get _textSelectionTheme {
    return TextSelectionThemeData(
      cursorColor: RecipeColors.primary700.color,
      selectionHandleColor: RecipeColors.primary700.color,
    );
  }

  static InputDecorationTheme get _inputDecorationTheme {
    return InputDecorationTheme(
      hintStyle: TextStyle(color: Colors.grey.shade400),
      filled: true,

      // input tidak fokus
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15.0),
        borderSide: BorderSide(
          color: Colors.grey.shade300,
          width: 1.5,
        ),
      ),

      // input fokus
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15.0),
        borderSide: BorderSide(
          color: RecipeColors.primary700.color,
          width: 1.5,
        ),
      ),
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
      textSelectionTheme: _textSelectionTheme,
      inputDecorationTheme: _inputDecorationTheme,
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
