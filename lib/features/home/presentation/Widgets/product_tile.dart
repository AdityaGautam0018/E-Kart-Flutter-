import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ekart/core/widgets/custom_textview_ellipsis.dart';

import '../../data/models/product_item.dart';

class ProductTile extends StatelessWidget {
  final ProductItem productItem;
  final Function() onTap;
  final Function() onSave;
  final bool isLiked;

  const ProductTile(
      {super.key,
      required this.productItem,
      required this.onTap,
      required this.onSave,
      required this.isLiked});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: Card(
                clipBehavior: Clip.antiAlias,
                color: Colors.grey.shade50,
                elevation: 0.3,
                shadowColor: Colors.white,
                child: Stack(
                  children: [
                    // CachedNetworkImage(
                    //   imageUrl: productItem.images!.first,
                    //   fit: BoxFit.fill,
                    //   height: 130,
                    //   width: 190,
                    //   errorWidget: (context, url, error) => Icon(Icons.error),
                    // ),
                    Image.network(
                      productItem.images!.first,
                      fit: BoxFit.fill,
                      height: 130,
                      width: 190,
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: GestureDetector(
                        onTap: onSave,
                        child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: isLiked
                                ? Icon(
                                    Icons.favorite,
                                    color: Colors.red,
                                    size: 20,
                                  )
                                : Icon(
                                    Icons.favorite_border_sharp,
                                    color: Colors.black,
                                    size: 20,
                                  )),
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            CustomTextviewEllipsis(
                text: productItem.title,
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.black),
            SizedBox(
              height: 8,
            ),
            CustomTextviewEllipsis(
                text: '\u0024${productItem.price}',
                fontSize: 16,
                fontWeight: FontWeight.w300,
                color: Colors.black)
          ],
        ));
  }
}
