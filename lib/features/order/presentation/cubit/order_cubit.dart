import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../home/data/models/product_item.dart';

part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  OrderCubit() : super(OrderInitial());

  void addOrder(Map<ProductItem, int> newOrders) {
    if (state is OrderLoaded) {
      final existingOrders = (state as OrderLoaded).orderItems;
      final updateOrders = Map<ProductItem, int>.from(existingOrders);

      newOrders.forEach((product, quantity) {
        if (updateOrders.containsKey(product)) {
          updateOrders[product] = updateOrders[product]! + quantity;
        } else {
          updateOrders[product] = quantity;
        }
        emit(OrderLoaded(updateOrders));
      });
    }
    else{
      emit(OrderLoaded(newOrders));
    }
  }
}
