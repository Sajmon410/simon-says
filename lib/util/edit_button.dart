import 'package:flutter/material.dart';

class EditButton extends StatelessWidget {
  VoidCallback onPressed;
 EditButton({
  super.key,
  required this.onPressed(),
  });

  @override
  Widget build(BuildContext context) {
    return   IconButton(
     icon: const Icon(Icons.edit, color: Colors.white),
      onPressed: onPressed,  // Poziv edit funkcije sa indexom
    );
  }
}