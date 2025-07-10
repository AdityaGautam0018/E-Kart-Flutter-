import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ekart/core/widgets/custom_scaffold.dart';
import 'package:ekart/features/home/presentation/Widgets/custom_text_view.dart';
import 'package:ekart/features/order/presentation/cubit/order_cubit.dart';
import 'package:ekart/features/order/presentation/widgets/order_tile.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: "Orders",
        child: Padding(
      padding: EdgeInsets.all(20),
      child: BlocBuilder<OrderCubit, OrderState>(
        builder: (context, state) {
          if (state is OrderLoaded) {
            final orders = state.orderItems;
            return ListView.builder(itemCount: orders.length,
                itemBuilder: (context, index) {
                  final product = orders.keys.elementAt(index);
                  final quantity = orders[product] ?? 1;
                  return OrderTile(img: product.images?.first ?? "",
                      title: product.title,
                      price: product.price * quantity,
                      qty: quantity);
                });
          }else{
            return Center(child: Text("No Orders Yet"),);
          }
        },
      ),
    ));
  }
}
