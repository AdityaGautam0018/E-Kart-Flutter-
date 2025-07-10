import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ekart/core/widgets/custom_scaffold.dart';
import 'package:ekart/features/cart/presentation/page/check_out_page.dart';
import 'package:ekart/features/home/presentation/pages/full_product_page.dart';
import 'package:ekart/features/main/presentation/widget/cart_tile.dart';
import 'package:ekart/features/main/presentation/widget/custom_addcart_footer.dart';

import '../bloc/cart_bloc.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: "My Cart",
        child: BlocBuilder<CartBloc, CartState>(builder: (context, state) {
      if (state is CartLoaded) {
        final items = state.cartItems;
        final totalPrice = items.entries
            .map((entry) => entry.key.price * entry.value)
            .fold<int>(0, (sum, itemTotal) => sum + itemTotal);
        if (items.isEmpty) {
          return Center(
            child: Text("No Items added in Cart"),
          );
        }
        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final product = items.keys.elementAt(index);
                    final quantity = items[product] ?? 1;
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CartTile(
                        title: product.title,
                        price: product.price * quantity,
                        img: product.images?.first ?? "",
                        add: () {
                          context
                              .read<CartBloc>()
                              .add(UpdateQuantity(product.id, quantity + 1));
                        },
                        remove: () {
                          if (quantity > 1) {
                            context
                                .read<CartBloc>()
                                .add(UpdateQuantity(product.id, quantity - 1));
                          }
                        },
                        deleteItem: () {
                          context
                              .read<CartBloc>()
                              .add(RemoveFromCart(product.id));
                        },
                        countNumber: quantity,
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      FullProductPage(id: product.id)));
                        },
                      ),
                    );
                  }),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: CustomMyCartFooter(
                  checkOut: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CheckOutPage()));
                  },
                  price: totalPrice),
            )
          ],
        );
      } else {
        return Center(
          child: Text("No item added to cart "),
        );
      }
    }));
  }
}
