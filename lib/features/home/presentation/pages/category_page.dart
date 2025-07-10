import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ekart/core/widgets/custom_scaffold.dart';
import 'package:ekart/features/home/presentation/Widgets/product_tile.dart';
import 'package:ekart/features/home/presentation/bloc/category/category_bloc.dart';
import 'package:ekart/features/home/presentation/cubit/wishlist_cubit.dart';
import 'package:ekart/features/home/presentation/pages/full_product_page.dart';

class CategoryPage extends StatefulWidget {
  final String categoryName;
  final int id;

  const CategoryPage({super.key, required this.categoryName, required this.id});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  void initState() {
    context.read<CategoryBloc>().add(FetchProductByCategory(id: widget.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: widget.categoryName,
      child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      child: BlocBuilder<CategoryBloc, CategoryState>(
        builder: (context, state) {
          if (state is CategoryLoaded) {
            final products = state.products;
            return GridView.builder(
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
                        return state.products.any((p) => p.id == product.id);
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
                            final wishlistCubit = context.read<WishlistCubit>();

                            isLiked
                                ? wishlistCubit.removeFromWishlist(product)
                                : wishlistCubit.addToWishlist(product);
                          },
                          isLiked: isLiked);
                    },
                  );
                });
          } else {
            return SizedBox.shrink();
          }
        },
      ),
    ),);
  }
}
