import 'package:flutter/material.dart';

class IncrementButton extends StatelessWidget {
  final VoidCallback onPressed;

  const IncrementButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(Icons.add, color: Colors.white),
      style: IconButton.styleFrom(
        backgroundColor: Colors.green,
        padding: EdgeInsets.all(8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}