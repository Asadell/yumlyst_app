import 'package:flutter/material.dart';
import 'package:recipe_app/style/colors/recipe_colors.dart';

class PrimaryActionButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isFullWidth;
  final double height;
  final Color? backgroundColor;
  final Color? textColor;
  final double borderRadius;
  final EdgeInsetsGeometry? padding;
  final bool isLoading;

  const PrimaryActionButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isFullWidth = true,
    this.height = 50,
    this.backgroundColor,
    this.textColor,
    this.borderRadius = 10,
    this.padding,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        foregroundColor: textColor ?? Colors.white,
        backgroundColor: backgroundColor ?? RecipeColors.primary700.color,
        padding: padding ?? EdgeInsets.symmetric(horizontal: 32, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        minimumSize: isFullWidth ? Size(double.infinity, height) : null,
        disabledBackgroundColor: RecipeColors.primary700.color.withOpacity(0.5),
      ),
      child: isLoading
          ? SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: Colors.white,
              ),
            )
          : Text(
              text,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: textColor ?? Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
            ),
    );
  }
}

// Contoh penggunaan
// PrimaryActionButton(
//   text: 'Login',
//   onPressed: () {
//     // Handle login
//   },
// )

// Contoh penggunaan dengan status loading
// PrimaryActionButton(
//   text: 'Login',
//   onPressed: () {},
//   isLoading: true,
// )

// Contoh penggunaan dengan kustomisasi
// PrimaryActionButton(
//   text: 'Register',
//   onPressed: () {},
//   backgroundColor: Colors.green,
//   isFullWidth: false,
//   padding: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
// )
