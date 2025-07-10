import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:ekart/features/home/presentation/Widgets/custom_product_count.dart';
import 'package:ekart/features/home/presentation/Widgets/custom_product_footer.dart';
import '../../../cart/presentation/bloc/cart_bloc.dart';
import '../bloc/product/product_bloc.dart';
import '../cubit/wishlist_cubit.dart';

class FullProductPage extends StatefulWidget {
  final int id;

  const FullProductPage({super.key, required this.id});

  @override
  State<FullProductPage> createState() => _FullProductPageState();
}

class _FullProductPageState extends State<FullProductPage> {
  @override
  void initState() {
    context.read<ProductBloc>().add(FetchProductById(widget.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        if (state is ProductLoaded) {
          final product = state.product;
          final productId = product?.id;
          final quantity = state.quantities[product?.id]??1;
          return Scaffold(
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      CarouselSlider(
                          items: product?.images?.map((item) {
                            return Builder(builder: (context) {
                              return SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: Image.network(
                                  item,
                                  fit: BoxFit.cover,
                                ),
                              );
                            });
                          }).toList(),
                          options: CarouselOptions(
                              height: MediaQuery.of(context).size.height * 0.4,
                              aspectRatio: 16 / 9,
                              viewportFraction: 1,
                              initialPage: 0,
                              enableInfiniteScroll: true,
                              reverse: false,
                              autoPlay: false,
                              autoPlayInterval: const Duration(seconds: 3),
                              autoPlayAnimationDuration:
                                  const Duration(seconds: 2),
                              autoPlayCurve: Curves.fastOutSlowIn,
                              enlargeCenterPage: true,
                              scrollDirection: Axis.horizontal,
                              onPageChanged: (index, reason) {
                                context
                                    .read<ProductBloc>()
                                    .add(UpdateCarouselIndex(index));
                              })),
                      Positioned(
                        bottom: 10,
                        child: AnimatedSmoothIndicator(
                          activeIndex: state.currentIndex,
                          count: product?.images?.length ?? 1,
                          duration: const Duration(microseconds: 500),
                          effect: const ExpandingDotsEffect(
                              dotWidth: 5,
                              dotHeight: 5,
                              activeDotColor: Colors.white),
                        ),
                      ),
                      Positioned(
                          left: 5,
                          top: 30,
                          child: IconButton(
                              onPressed: () => Navigator.pop(context),
                              icon: Icon(
                                Icons.arrow_back,
                                size: 40,
                                color: Colors.white,
                              )))
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                product?.title ?? "NA",
                                style: TextStyle(
                                    fontSize: 24,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600),
                                softWrap: true,
                              ),
                            ),
                            BlocSelector<WishlistCubit, WishlistState, bool>(
                              selector: (state) {
                                if (state is WishlistLoaded) {
                                  return state.products
                                      .any((p) => p.id == product?.id);
                                }
                                return false;
                              },
                              builder: (context, isLiked) {
                                return GestureDetector(
                                    onTap: () {
                                      final wishlistCubit =
                                          context.read<WishlistCubit>();
                                      isLiked
                                          ? wishlistCubit
                                              .removeFromWishlist(product!)
                                          : wishlistCubit
                                              .addToWishlist(product!);
                                    },
                                    child: isLiked
                                        ? Icon(
                                            Icons.favorite,
                                            color: Colors.red,
                                            size: 20,
                                          )
                                        : Icon(
                                            Icons.favorite_border_sharp,
                                            color: Colors.black,
                                            size: 20,
                                          ));
                              },
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Divider(
                          height: 1,
                          color: Colors.grey,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Description",
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.w800),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(product?.description ?? "",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.normal)),
                        SizedBox(
                          height: 40,
                        ),
                        CustomProductCount(
                          title: "Quantity",
                            countNumber: quantity ,
                            remove: () {
                              context
                                  .read<ProductBloc>()
                                  .add(DecreaseQuantity(productId!));
                            },
                            add: () {
                              context
                                  .read<ProductBloc>()
                                  .add(IncreaseQuantity(productId!));
                            }),
                        const SizedBox(
                          height: 16,
                        ),
                        const Divider(
                          height: 1,
                          color: Colors.grey,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomProductFooter(
                            addCart: () {
                              context.read<CartBloc>().add(AddToCart(
                                  product: product!,
                                  quantity: quantity));
                            },
                            price: (product?.price??1) * quantity)
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        } else {
          return SizedBox.shrink();
        }
      },
    );
  }
}
