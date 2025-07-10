import 'package:flutter/material.dart';

import 'custom_text_view.dart';

class CustomAddCartButton extends StatelessWidget {
  const CustomAddCartButton(
      {super.key,
        required this.minWidth,
        required this.height,
        required this.title,
        required this.onPress});

  final double minWidth;
  final double height;
  final String title;
  final Function() onPress;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(10), // Material has to define shape
      child: Ink(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF0047ab),
              Color(0xFF1ca9c9),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(10), // Ensure ripple respects shape
          onTap: onPress,
          child: Container(
            width: minWidth,
            height: 44,
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.add_shopping_cart, color: Colors.white),
                SizedBox(width: MediaQuery.of(context).size.width * 0.1),
                CustomTextView(
                  text: title,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ),
      ),
    );

  }
}