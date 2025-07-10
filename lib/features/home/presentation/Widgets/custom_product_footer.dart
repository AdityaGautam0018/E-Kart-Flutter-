import 'package:flutter/material.dart';

import 'custom_add_cart_button.dart';
import 'custom_text_view.dart';

class CustomProductFooter extends StatelessWidget {
  const CustomProductFooter({super.key, required this.addCart, required this.price});
  final Function() addCart;
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
        CustomAddCartButton(
          minWidth: MediaQuery.of(context).size.width * 0.6,
          height: 30,
          title: 'Add Cart',
          onPress: addCart,
        ),
      ],
    );
  }
}