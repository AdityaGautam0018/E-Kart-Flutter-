import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ekart/core/widgets/custom_scaffold.dart';
import 'package:ekart/features/home/presentation/Widgets/custom_search_bar_field.dart';
import 'package:ekart/features/home/presentation/bloc/product/product_bloc.dart';

import '../Widgets/product_tile.dart';
import '../cubit/wishlist_cubit.dart';
import 'full_product_page.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          spacing: 20,
          children: [
            TextField(
              controller: controller,
              onChanged: (value){
                context.read<ProductBloc>().add(SearchProducts(value));
              },
              decoration: InputDecoration(
                hintText: 'Search products...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              ),
            ),
            BlocBuilder<ProductBloc, ProductState>(
              builder: (context, state) {
                if (state is ProductLoaded) {
                  final products = state.filteredOffers;
                  if(products.isNotEmpty && controller.text.isNotEmpty) {
                    return Expanded(
                      child: GridView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: products.length,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                          ),
                          itemBuilder: (context, index) {
                            final product = products[index];
                            return BlocSelector<WishlistCubit,
                                WishlistState,
                                bool>(
                              selector: (state) {
                                if (state is WishlistLoaded) {
                                  return state.products.any((p) =>
                                  p.id == product.id);
                                }
                                return false;
                              },
                              builder: (context, isLiked) {
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
                                      final wishlistCubit = context.read<
                                          WishlistCubit>();

                                      isLiked
                                          ? wishlistCubit.removeFromWishlist(
                                          product)
                                          : wishlistCubit.addToWishlist(product);
                                    },
                                    isLiked: isLiked);
                              },
                            );
                          }),
                    );
                  }else{
                    return SizedBox.shrink();
                  }
                } else {
                  return SizedBox.shrink();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
