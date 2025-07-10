import 'package:flutter/material.dart';

import '../../../home/presentation/Widgets/custom_text_view.dart';

class CustomCheckOutButton extends StatelessWidget {
  const CustomCheckOutButton(
      {super.key,
      required this.minWidth,
      required this.height,
      required this.title,
      required this.onPress,
      required this.icon});

  final double minWidth;
  final double height;
  final String title;
  final Widget icon;
  final Function() onPress;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(10),
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
          borderRadius: BorderRadius.circular(10),
          onTap: onPress,
          child: Container(
              width: minWidth,
              padding: EdgeInsets.all(8),
              height: 44,
              child: Center(
                child: CustomTextView(
                    text: title,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
              )),
        ),
      ),
    );
  }
}
