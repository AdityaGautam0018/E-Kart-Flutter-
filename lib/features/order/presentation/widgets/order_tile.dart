import 'package:flutter/material.dart';
import 'package:ekart/features/home/presentation/Widgets/custom_text_view.dart';

import '../../../../core/widgets/custom_textview_ellipsis.dart';

class OrderTile extends StatelessWidget {
  final String img, title;
  final int price,qty;

  const OrderTile(
      {super.key,
      required this.img,
      required this.title,
      required this.price,
      required this.qty});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Container(
        width: MediaQuery.sizeOf(context).width,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(border: Border.all(width: 1, color: Colors.grey.shade400),
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: Row(
          spacing: 14,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(40),
              child: Image.network(
                img,
                height: 80,
                width: 80,
                fit: BoxFit.cover,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 10,
              children: [
                SizedBox(
                  width: MediaQuery.sizeOf(context).width * 0.3,
                  child: CustomTextviewEllipsis(
                      text: title,
                      fontSize: 16,
                      maxLine: 3,
                      fontWeight: FontWeight.normal,
                      color: Colors.black),
                ),
                CustomTextView(
                    text: "Qty: ${qty.toString()}",
                    fontSize: 18,
                    fontWeight: FontWeight.w300,
                    color: Colors.black)
              ],
            ),
            Spacer(),
            Column(
              spacing: 45,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: Colors.lightGreen.shade100,
                      borderRadius: BorderRadius.circular(10)),
                  child: CustomTextView(
                      text: "Ordered",
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.green.shade900),
                ),
                CustomTextView(
                    text: "\u0024$price",
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black)
              ],
            )
          ],
        ),
      ),
    );
  }
}
