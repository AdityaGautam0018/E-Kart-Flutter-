import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../home/data/models/product_item.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial()) {
    on<AddToCart>(_addToCart);
    on<UpdateQuantity>(_updateQuantity);
    on<RemoveFromCart>(_removeFromCart);
    on<ClearCart>(_clearCart);
  }

  FutureOr<void> _addToCart(AddToCart event, Emitter<CartState> emit) async{
  final currentState = state;
    if (currentState is CartLoaded) {
      final updatedCart = Map<ProductItem, int>.from(currentState.cartItems);
      updatedCart[event.product] = event.quantity; // overwrite or insert new
      emit(CartLoaded(updatedCart));
    }else{
      emit(CartLoaded({event.product: event.quantity}));
    }
  }

  FutureOr<void> _updateQuantity(UpdateQuantity event, Emitter<CartState> emit) async{
    final currentItems = (state as CartLoaded).cartItems;
    final updatedItems = Map<ProductItem, int>.from(currentItems);
    final product = updatedItems.keys.firstWhere((p) => p.id == event.productId);
    updatedItems[product] = event.quantity;
    emit(CartLoaded(updatedItems));
  }

  FutureOr<void> _removeFromCart(RemoveFromCart event, Emitter<CartState> emit) async{
    if (state is CartLoaded) {
      final updatedItems = Map<ProductItem, int>.from((state as CartLoaded).cartItems);
      updatedItems.removeWhere((product, _) => product.id == event.productId);
      emit(CartLoaded(updatedItems));
    }
  }

  FutureOr<void> _clearCart(ClearCart event, Emitter<CartState> emit) async{
    emit(CartLoaded({}));
  }
}
