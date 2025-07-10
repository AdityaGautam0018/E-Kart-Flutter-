import 'package:flutter/material.dart';

import 'custom_text_view.dart';

class CustomProductCount extends StatelessWidget {
  const CustomProductCount({super.key, required this.countNumber, required this.remove, required this.add, required this.title});
  final int countNumber;
  final Function() remove;
  final Function() add;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CustomTextView(
            text: title?? "",
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black),
        const SizedBox(
          width: 12,
        ),
        Container(
          width:  MediaQuery.of(context).size.width * 0.35,
          height: MediaQuery.of(context).size.height * 0.04,
          decoration: ShapeDecoration(
            color: Colors.grey.shade300,
            shape: const StadiumBorder(),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: remove,
                color: Colors.black,
                icon: const Icon(
                  Icons.remove,
                  size: 16,
                ),
              ),
              CustomTextView(
                  text: countNumber.toString(),
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black),
              IconButton(
                onPressed: add,
                color: Colors.black,
                icon: const Icon(
                  Icons.add,
                  size: 16,
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}