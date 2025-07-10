import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:ekart/core/widgets/custom_scaffold.dart';
import 'package:ekart/features/home/presentation/Widgets/category_tile.dart';
import 'package:ekart/features/home/presentation/Widgets/custom_text_view.dart';
import 'package:ekart/features/home/presentation/Widgets/offer_item.dart';
import 'package:ekart/features/home/presentation/bloc/category/category_bloc.dart';
import 'package:ekart/features/home/presentation/pages/category_page.dart';
import 'package:ekart/features/home/presentation/pages/search_page.dart';
import 'package:ekart/features/home/presentation/pages/wishlist_page.dart';

import '../bloc/product/product_bloc.dart';
import 'full_product_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    context.read<CategoryBloc>().add(FetchCategories());
    context.read<ProductBloc>().add(FetchSomeProducts());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        actions: [
          IconButton(
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => WishlistPage())),
              icon: Icon(
                Icons.favorite,
                color: Colors.white,
                size: 25,
              ))
        ],
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              // SearchPage(),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: GestureDetector(
                  onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=> SearchPage())),
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(width: 1, color: Colors.blueGrey),
                    ),
                    child: Row(
                      spacing: 15,
                      children: [
                        Icon(
                          Icons.search,
                        ),
                        CustomTextView(
                            text: "Search Products...",
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                            color: Colors.grey)
                      ],
                    ),
                  ),
                ),
              ),
              BlocBuilder<ProductBloc, ProductState>(
                builder: (context, state) {
                  if (state is ProductLoaded) {
                    final offers = state.offers;

                    return Stack(
                      alignment: Alignment.center,
                      children: [
                        CarouselSlider.builder(
                            itemCount: offers.length,
                            itemBuilder: (context, index, realIdx) {
                              final product = offers[index];
                              return OfferItem(
                                  offerDetails: product,
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                FullProductPage(
                                                    id: product.item.id)));
                                  });
                            },
                            options: CarouselOptions(
                                aspectRatio: 16 / 9,
                                viewportFraction: 1,
                                initialPage: 0,
                                enableInfiniteScroll: true,
                                reverse: false,
                                autoPlay: true,
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
                              count: offers.length,
                              duration: Duration(microseconds: 500),
                              effect: const ExpandingDotsEffect(
                                  dotWidth: 5,
                                  dotHeight: 5,
                                  activeDotColor: Colors.white),
                            ))
                      ],
                    );
                  } else {
                    return SizedBox.shrink();
                  }
                },
              ),
              SizedBox(
                height: 21,
              ),
              BlocBuilder<CategoryBloc, CategoryState>(
                bloc: context.read<CategoryBloc>()..add(FetchCategories()),
                builder: (context, state) {
                  log('Category state :=> $state');
                  if (state is CategoryLoaded) {
                    final categories = state.categories;

                    return GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        // important
                        shrinkWrap: true,
                        // important
                        itemCount: categories.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          mainAxisSpacing: 12,
                          crossAxisSpacing: 12,
                        ),
                        itemBuilder: (context, index) {
                          final category = categories[index];
                          return GestureDetector(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CategoryPage(
                                          categoryName: category.name,
                                          id: category.id,
                                        ))),
                            child: CategoryTile(categoryName: category.name),
                          );
                        });
                  } else if (state is CategoryError) {
                    return Center(
                      child: Text(state.message),
                    );
                  } else {
                    return SizedBox.shrink();
                  }
                },
              ),
            ],
          ),
        ));
  }
}
