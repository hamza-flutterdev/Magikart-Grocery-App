import 'package:flutter/material.dart';
import 'package:magikart_grocery_app/app_theme.dart';

class AddToCartButton extends StatelessWidget {
  final VoidCallback onPressed;

  const AddToCartButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        minimumSize: Size(0, 35),
      ),

      child: Text(
        'Add To Cart',
        style: TextStyle(
          fontSize: 14,
          color: AppTheme.extraLightGrey,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
