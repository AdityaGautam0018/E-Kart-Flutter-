import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ekart/core/widgets/custom_textview_ellipsis.dart';
import 'package:ekart/features/home/presentation/Widgets/custom_text_view.dart';
import 'package:ekart/utils/icons.dart';

class CategoryTile extends StatelessWidget {
  final String  categoryName;
  const CategoryTile({super.key, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    final icon = getCategoryIcon(categoryName);
    return Column(spacing: 8,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(color: Colors.grey.shade300,
              borderRadius: BorderRadius.all(Radius.circular(60),)),
          child: SvgPicture.asset(icon, height: 30, width: 30,fit: BoxFit.scaleDown,)
        ),
        CustomTextviewEllipsis(text: categoryName, fontSize: 13, fontWeight: FontWeight.normal, color: Colors.black,)
      ],
    );
  }
}
