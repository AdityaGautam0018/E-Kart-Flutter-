part of 'product_bloc.dart';

@immutable
sealed class ProductEvent {}

class FetchSomeProducts extends ProductEvent {}
class UpdateCarouselIndex extends ProductEvent {
  final int index;

  UpdateCarouselIndex(this.index);
}
class FetchProductById extends ProductEvent {
  final int productId;

  FetchProductById(this.productId);
}
class IncreaseQuantity extends ProductEvent {
  final int productId;
  IncreaseQuantity(this.productId);
}

class DecreaseQuantity extends ProductEvent {
  final int productId;
  DecreaseQuantity(this.productId);
}
class SearchProducts extends ProductEvent {
  final String query;

  SearchProducts(this.query);
}