import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ekart/core/widgets/custom_scaffold.dart';
import 'package:ekart/features/home/presentation/cubit/wishlist_cubit.dart';

import '../Widgets/product_tile.dart';
import 'full_product_page.dart';

class WishlistPage extends StatefulWidget {
  const WishlistPage({super.key});

  @override
  State<WishlistPage> createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: "My Wishlist",
        child:  Padding(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      child: BlocBuilder<WishlistCubit, WishlistState>(
        builder: (context, state) {
          if (state is WishlistLoaded) {
            final products = state.products;
            if (products.isEmpty) {
              return const Center(child: Text("No items in your wishlist."));
            }
            return GridView.builder(
                itemCount: products.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                ),
                itemBuilder: (context, index) {
                  final product = products[index];
                  return ProductTile(
                      productItem: product,
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    FullProductPage(id: product.id)));
                      },
                      onSave: () {
                        context.read<WishlistCubit>().removeFromWishlist(product);
                      },
                      isLiked: true);
                });
          } else {
            return SizedBox.shrink();
          }
        },
      ),
    ));
  }
}
