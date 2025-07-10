part of 'product_bloc.dart';

@immutable
sealed class ProductState {}

final class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  final List<Offer> offers;
  final List<ProductItem> filteredOffers;
  final int currentIndex;
  final ProductItem? product;
  final Map<int, int> quantities;


  ProductLoaded(this.offers,this.filteredOffers, {this.product, this.currentIndex = 0, Map<int, int>? quantities,}): quantities = quantities ?? {};

  ProductLoaded copyWith({
    List<Offer>? offers,
    List<ProductItem>? filteredOffers,
    int? currentIndex,
    ProductItem? product,
    Map<int, int>? quantities,
  }) {
    return ProductLoaded(
      offers ?? this.offers,
      filteredOffers?? this.filteredOffers,
      product: product ?? this.product,
      currentIndex: currentIndex ?? this.currentIndex,
        quantities: quantities ?? this.quantities,
    );
  }
  // int get totalPrice => product!.price * quantity!;
}


class ProductError extends ProductState {
  final String message;
  ProductError(this.message);
}