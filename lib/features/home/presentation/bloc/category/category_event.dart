part of 'category_bloc.dart';

@immutable
sealed class CategoryEvent {}
class FetchCategories extends CategoryEvent {}
class FetchProductByCategory extends CategoryEvent {
  final int id;

  FetchProductByCategory({required this.id});
}