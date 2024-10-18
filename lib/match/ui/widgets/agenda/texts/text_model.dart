import 'package:flutter/material.dart';

class TextModel extends StatelessWidget {
  const TextModel({
    super.key,
    required this.text,
    required this.color,
    required this.size,
  });

  final String text;
  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(20),
        child: Text(text,
            style: TextStyle(
                fontSize: size,
                fontWeight: FontWeight.bold,
                
                decoration: TextDecoration.none)));
  }
}
