import 'package:flutter/material.dart';

import '../../features/home/presentation/Widgets/custom_text_view.dart';

class CustomScaffold extends StatelessWidget {
  final String? title;
  final List<Widget>? actions;
  final Widget child;
  const CustomScaffold({super.key, this.title, this.actions, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                Color(0xFFb0e0e6),
                Color(0xFF4682b4),

              ])),
        ),
        actions: actions,
        title: CustomTextView(
            text: title?? "E-Kart",
            fontSize: 30,
            fontWeight: FontWeight.w700,
            color: Colors.white),
      ),
      body: SafeArea(child: child),
    );
  }
}
