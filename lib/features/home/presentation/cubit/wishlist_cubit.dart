import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../data/models/product_item.dart';

part 'wishlist_state.dart';

class WishlistCubit extends Cubit<WishlistState> {
  WishlistCubit() : super(WishlistInitial());

  void addToWishlist(ProductItem item) {
    final currentList =
        state is WishlistLoaded ? (state as WishlistLoaded).products : [];

    if (currentList.any((i) => i.id == item.id)) return;

    emit(WishlistLoaded([...currentList, item]));
  }

  void removeFromWishlist(ProductItem item) {
    if (state is WishlistLoaded) {
      final updatedList = (state as WishlistLoaded)
          .products
          .where((i) => i.id != item.id)
          .toList();

      emit(WishlistLoaded(updatedList));
    }
  }

  bool isInWishlist(ProductItem item) {
    if (state is WishlistLoaded) {
      return (state as WishlistLoaded).products.any((i) => i.id == item.id);
    }
    return false;
  }

  List<ProductItem> getWishlistItems() {
    return state is WishlistLoaded ? (state as WishlistLoaded).products : [];
  }
}
