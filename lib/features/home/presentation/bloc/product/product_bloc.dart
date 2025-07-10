import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:ekart/core/services/dioservice/network_service.dart';
import 'package:ekart/features/home/data/models/product_item.dart';

import '../../../data/models/offer.dart';

part 'product_event.dart';

part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  NetworkService networkService;

  ProductBloc(this.networkService) : super(ProductInitial()) {
    on<FetchSomeProducts>(_fetchSomeProducts);
    on<UpdateCarouselIndex>(_updateCarouselIndex);
    on<FetchProductById>(_fetchProductById);
    on<IncreaseQuantity>(_increaseQuantity);
    on<DecreaseQuantity>(_decreaseQuantity);
    on<SearchProducts>(_searchProducts);
  }

  FutureOr<void> _fetchSomeProducts(
      FetchSomeProducts event, Emitter<ProductState> emit) async {
    emit(ProductLoading());
    final someProducts = await networkService.getSomeProducts();
    final products = await networkService.getSomeProducts();
    try {
      final List<Offer> offers = someProducts.map((item) {
        return Offer(
          offerPercentage: item.price > 500 ? '30%' : '15%',
          offerMassage: "Today's Special",
          item: item,
        );
      }).toList();
      emit(ProductLoaded(offers, []));
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }

  FutureOr<void> _updateCarouselIndex(
      UpdateCarouselIndex event, Emitter<ProductState> emit) async {
    if (state is ProductLoaded) {
      final currentState = state as ProductLoaded;
      emit(currentState.copyWith(currentIndex: event.index));
    }
  }

  FutureOr<void> _fetchProductById(
      FetchProductById event, Emitter<ProductState> emit) async {
    final product = await networkService.getProductById(event.productId);
    try {
      if (state is ProductLoaded) {
        final currentState = state as ProductLoaded;
        emit(currentState.copyWith(product: product));
      }
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }

  FutureOr<void> _increaseQuantity(
      IncreaseQuantity event, Emitter<ProductState> emit) {
    final currentState = state as ProductLoaded;
    final updatedQuantities = Map<int, int>.from(currentState.quantities);
    updatedQuantities[event.productId] =
        (updatedQuantities[event.productId] ?? 1) + 1;

    emit(currentState.copyWith(quantities: updatedQuantities));
  }

  FutureOr<void> _decreaseQuantity(
      DecreaseQuantity event, Emitter<ProductState> emit) {
    final currentState = state as ProductLoaded;
    final updatedQuantities = Map<int, int>.from(currentState.quantities);

    final currentQuantity = updatedQuantities[event.productId] ?? 1;
    if (currentQuantity > 1) {
      updatedQuantities[event.productId] = currentQuantity - 1;
      emit(currentState.copyWith(quantities: updatedQuantities));
    }
  }

  FutureOr<void> _searchProducts(
      SearchProducts event, Emitter<ProductState> emit) async {
    if (state is ProductLoaded) {
      final products = await networkService.getProducts();
      final currentState = state as ProductLoaded;
      final filtered = products
          .where((offer) => offer.title
              .toLowerCase()
              .contains(event.query.toLowerCase()))
          .toList();
      emit(currentState.copyWith(filteredOffers: filtered));
    }
  }
}
