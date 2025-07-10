import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:ekart/core/services/dioservice/network_service.dart';
import 'package:ekart/features/home/data/models/category_model.dart';

import '../../../data/models/product_item.dart';
import '../../../domain/entity/category_entity.dart';

part 'category_event.dart';

part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  NetworkService networkService;

  CategoryBloc(this.networkService) : super(CategoryInitial()) {
    on<FetchCategories>(_fetchCategories);
    on<FetchProductByCategory>(_fetchProductByCategory);
  }

  FutureOr<void> _fetchCategories(
      FetchCategories event, Emitter<CategoryState> emit) async {
    try {
      emit(CategoryLoading());
      final category = await networkService.getCategories();
      emit(CategoryLoaded(categories: category, products: []));
    } catch (e) {
      emit(CategoryError(e.toString()));
    }
  }

  FutureOr<void> _fetchProductByCategory(
      FetchProductByCategory event, Emitter<CategoryState> emit) async {
    try {
      List<CategoryModel> categories = (state is CategoryLoaded)
          ? (state as CategoryLoaded).categories as List<CategoryModel>
          : <CategoryModel>[];
      emit(CategoryLoading());
      final products = await networkService.getProductsByCategoryId(event.id);
      emit(CategoryLoaded(categories: categories, products: products));
    } catch (e) {
      emit(CategoryError(e.toString()));
    }
  }
}
