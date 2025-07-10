import 'package:flutter/material.dart';

import '../../../home/presentation/Widgets/custom_text_view.dart';
import 'custom_checkout_button.dart';

class CustomMyCartFooter extends StatelessWidget {
  const CustomMyCartFooter({super.key, required this.checkOut, required this.price});
  final Function() checkOut;
  final int price;

  @override
  Widget build(BuildContext context) {
    return  Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomTextView(
                text: 'Total price',
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Colors.grey),
            CustomTextView(
                text: '\u0024$price',
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.black),
          ],
        ),
        CustomCheckOutButton(
          minWidth: MediaQuery.sizeOf(context).width * 0.6,
          height: 30,
          title: 'Check out',
          onPress: checkOut,
          icon: const Icon(Icons.arrow_forward,color: Colors.white,),
        ),
      ],
    );
  }
}