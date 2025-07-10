import 'package:ekart/features/home/domain/entity/category_entity.dart';

class CategoryModel extends CategoryEntity {
  CategoryModel({ required super.name, required super.image, required super.id, required super.slug});

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
       id: json['id'],slug: json['slug'],  name: json["name"], image: json['image']);
  }
  Map<String, dynamic> toJson() => {
    "id": id,
    "slug": slug,
    "name": name,
    "image": image,
  };
}
