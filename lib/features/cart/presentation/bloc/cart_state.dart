part of 'cart_bloc.dart';

@immutable
sealed class CartState {}

final class CartInitial extends CartState {}
class CartLoading extends CartState{}
class CartLoaded extends CartState {
  final Map<ProductItem, int> cartItems;

  CartLoaded(this.cartItems);


  double get totalPrice => cartItems.entries
      .map((e) => e.key.price * e.value)
      .fold(0.0, (a, b) => a + b);
}
class CartLoadingFailure extends CartState{}
