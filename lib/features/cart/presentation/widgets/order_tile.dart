
import 'package:flutter/material.dart';

import '../../../../core/widgets/custom_textview_ellipsis.dart';
import '../../../home/presentation/Widgets/custom_text_view.dart';

class OrderTile extends StatelessWidget {
  final String title, img;
  final int countNumber, price;
  final Function() onTap;

  const OrderTile(
      {super.key,
        required this.title,
        required this.price,
        required this.img,
        required this.countNumber,
        required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 2,
        child: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Row(
            spacing: 10,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                spacing: 10,
                children: [
                  Container(
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Image.network(
                        img,
                        height: 80,
                        width: 90,
                        fit: BoxFit.cover,
                      )),
                  Text(
                    '\u0024$price',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              Column(
                spacing: 20,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width * 0.4,
                    child: CustomTextviewEllipsis(
                        text: title,
                        fontSize: 16,
                        maxLine: 3,
                        fontWeight: FontWeight.w800,
                        color: Colors.black),
                  ),
                  Row(spacing: 10,
                    children: [
                      CustomTextView(text: "Quantity:", fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black),
                      Container(
                        width:  MediaQuery.of(context).size.width * 0.09,
                        height: MediaQuery.of(context).size.height * 0.04,
                        decoration: ShapeDecoration(
                          color: Colors.grey.shade300,
                          shape: const StadiumBorder(),
                        ),
                        child: Center(
                          child: CustomTextView(
                              text: countNumber.toString(),
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.black),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
