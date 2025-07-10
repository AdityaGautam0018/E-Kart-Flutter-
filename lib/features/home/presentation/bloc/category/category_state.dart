part of 'category_bloc.dart';

@immutable
sealed class CategoryState {}

final class CategoryInitial extends CategoryState {}

class CategoryLoading extends CategoryState {}

class CategoryLoaded extends CategoryState {
  final List<CategoryEntity> categories;
  final List<ProductItem> products;

  CategoryLoaded({required this.categories,required this.products});
}

class CategoryError extends CategoryState {
  final String message;

  CategoryError(this.message);
}