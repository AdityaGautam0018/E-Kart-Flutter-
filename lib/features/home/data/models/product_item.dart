import 'dart:convert';

import 'package:ekart/features/home/data/models/category_model.dart';

class ProductItem {
  ProductItem({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.images,
  });

  final int id;
  final String title;
  final int price;
  final String description;
  final CategoryModel? category;
  final List<String>? images;

  factory ProductItem.fromJson(Map<dynamic, dynamic> json) => ProductItem(
        id: json["id"],
        title: json["title"],
        price: json["price"],
        description: json["description"],
        category: json["category"] == null
            ? null
            : CategoryModel.fromJson(json["category"]),
        images: json["images"] == null
            ? null
            : List<String>.from(json["images"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "price": price,
        "description": description,
        "category": category?.toJson(),
        "images":
            images == null ? null : List<dynamic>.from(images!.map((x) => x)),
      };
}

List<ProductItem> productItemFromJson(String str) =>
    List<ProductItem>.from(jsonDecode(str).map((x) => ProductItem.fromJson(x)));

String productItemToJson(List<ProductItem> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
