
import 'package:dio/dio.dart';
import 'package:ekart/core/constants/endpoints.dart';
import 'package:ekart/features/home/data/models/category_model.dart';
import 'package:ekart/features/home/data/models/product_item.dart';
import 'package:ekart/features/profile/data/model/profile.dart';
import 'package:ekart/features/sign_login/data/models/user.dart';
import 'package:ekart/features/sign_login/data/models/user_login.dart';

class NetworkService {
  final Dio _dio = Dio();

  Future<void> createUser(User user) async {
    String uri = baseUrl+ signUpEndpoint;
    try {
      final response = await _dio.post(uri, data: user.toJson());
      if (response.statusCode == 201) {
        print("User Created: ${response.data}");
      } else {
        print('Failed with status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<String> loginUser(UserLogin userLogin) async {
    String uri = baseUrl + loginEndpoint;
    try {
      final response = await _dio.post(uri, data: userLogin.toJson());

      if (response.statusCode == 201) {
        print("User authenticated: ${response.data}");
      } else {
        print('Failed with status code: ${response.statusCode}');
      }
      return response.data['access_token'];
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<CategoryModel>> getCategories() async {
    String uri = baseUrl + allCategoryEndpoint;
    final response = await _dio.get(uri);
    try {
      if(response.statusCode == 200){
        print("Categories fetched: ${response.data}");
      }
      return (response.data as List)
          .map((json) => CategoryModel.fromJson(json))
          .toList();

    }catch(e){
      throw Exception(e.toString());
    }
  }
  Future<List<ProductItem>> getProductsByCategoryId(int id) async {
    String uri = 'https://api.escuelajs.co/api/v1/categories/$id/products/';
    final response = await _dio.get(uri);

    try {
      if (response.statusCode == 200) {
        print("Products by category: ${response.data}");
      }

      return (response.data as List)
          .map((json) => ProductItem.fromJson(json))
          .toList();
    } catch (e) {
      throw Exception(e.toString());
    }
  }
  Future<List<ProductItem>> getProducts() async {
    String uri = "https://api.escuelajs.co/api/v1/products/";
    final response = await _dio.get(uri);
    try {
      if(response.statusCode == 200){
        print("Product fetched: ${response.data}");
      }
      return (response.data as List)
          .map((json) => ProductItem.fromJson(json))
          .toList();

    }catch(e){
      throw Exception(e.toString());
    }
  }
  Future<List<ProductItem>> getSomeProducts() async {
    String uri = baseUrl + someLimitedProducts;
    final response = await _dio.get(uri);
    try {
      if(response.statusCode == 200){
        print("products fetched: ${response.data}");
      }
      return (response.data as List)
          .map((json) => ProductItem.fromJson(json))
          .toList();

    }catch(e){
      throw Exception(e.toString());
    }
  }

  Future<ProductItem> getProductById(int id) async {
    String uri = "https://api.escuelajs.co/api/v1/products/$id";
    final response = await _dio.get(uri);
    try {
      if(response.statusCode == 200){
        print("products by id fetched: ${response.data}");
      }
      return ProductItem.fromJson(response.data);
    }catch(e){
      throw Exception(e.toString());
    }
  }
  Future<Profile>getUserProfileInfo(String token)async{
    String uri = baseUrl+ profileEndpoint;
    final response = await _dio.get(uri,
    options: Options(
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      }
    ));
    try{
      if(response.statusCode == 200){
        print("profile details: ${response.data}");
      }
      return Profile.fromJson(response.data);
    }catch(e){
      throw Exception(e.toString());
    }
  }
}