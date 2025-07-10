part of 'cart_bloc.dart';

@immutable
sealed class CartEvent {}

class AddToCart extends CartEvent {
  final ProductItem product;
  final int quantity;
  AddToCart({required this.product, required this.quantity});
}
class UpdateQuantity extends CartEvent {
  final int productId;
  final int quantity;
  UpdateQuantity(this.productId, this.quantity);
}
class RemoveFromCart extends CartEvent {
  final int productId;
  RemoveFromCart(this.productId);
}
class ClearCart extends CartEvent {}