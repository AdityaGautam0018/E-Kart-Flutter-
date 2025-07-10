part of 'wishlist_cubit.dart';

@immutable
sealed class WishlistState {}

final class WishlistInitial extends WishlistState {}
class WishlistLoaded extends WishlistState {
  final List<ProductItem> products;
  WishlistLoaded(this.products);
}
