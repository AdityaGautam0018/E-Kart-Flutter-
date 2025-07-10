import 'package:flutter/material.dart';
import 'package:ekart/core/widgets/custom_textview_ellipsis.dart';
import 'package:ekart/features/home/presentation/Widgets/custom_product_count.dart';

class CartTile extends StatelessWidget {
  final String title, img;
  final int countNumber, price;
  final Function() add, remove, deleteItem, onTap;

  const CartTile(
      {super.key,
      required this.title,
      required this.price,
      required this.img,
      required this.add,
      required this.remove,
      required this.deleteItem,
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
              border: Border.all(width: 1, color: Colors.grey.shade400),
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
                spacing: 40,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width * 0.4,
                    child: CustomTextviewEllipsis(
                        text: title,
                        fontSize: 16,
                        maxLine: 3,
                        fontWeight: FontWeight.normal,
                        color: Colors.black),
                  ),
                  CustomProductCount(
                      title: "",
                      countNumber: countNumber,
                      remove: remove,
                      add: add)
                ],
              ),
              Spacer(),
              IconButton(
                  onPressed: deleteItem,
                  icon: Icon(
                    Icons.delete_outline,
                    color: Colors.black,
                    size: 25,
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
