import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String text;
  VoidCallback onPressed;
   MyButton({
    super.key,
    required this.text,
    required this.onPressed,
    });

@override
Widget build(BuildContext context) {
  return MaterialButton(
    onPressed: onPressed,
    color: Color(0xFF10001B),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15), // Set border radius
    ),
    child: Text(
      text,
      style: TextStyle(color: Colors.white),
    ),
  );
}}