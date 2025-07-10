part of 'order_cubit.dart';

@immutable
sealed class OrderState {}

final class OrderInitial extends OrderState {}

class OrderLoaded extends OrderState {
  final Map<ProductItem, int> orderItems;

  OrderLoaded(this.orderItems);
}
