import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ekart/features/home/presentation/bloc/category/category_bloc.dart';
import 'package:ekart/features/home/presentation/bloc/product/product_bloc.dart';
import 'package:ekart/features/home/presentation/cubit/wishlist_cubit.dart';
import 'package:ekart/features/order/presentation/cubit/order_cubit.dart';
import 'package:ekart/features/sign_login/presentation/pages/login_page.dart';
import 'core/services/dioservice/network_service.dart';
import 'features/cart/presentation/bloc/cart_bloc.dart';
import 'features/profile/presentation/cubit/profile_cubit.dart';
import 'features/sign_login/presentation/blocs/login/login_bloc.dart';
import 'features/sign_login/presentation/blocs/signup/sign_up_bloc.dart';
import 'features/sign_login/presentation/cubit/auth_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LoginBloc(NetworkService()),
        ),
        BlocProvider(
          create: (context) => SignUpBloc(NetworkService()),
        ),
        BlocProvider(
          create: (context) => CategoryBloc(NetworkService()),
        ),
        BlocProvider(
          create: (context) => ProductBloc(NetworkService()),
        ),
        BlocProvider(
          create: (context) => WishlistCubit(),
        ),
        BlocProvider(
          create: (context) => CartBloc(),
        ),
        BlocProvider(
          create: (context) => OrderCubit(),
        ),
        BlocProvider(
          create: (context) => AuthCubit(),
        ),
        BlocProvider(
          create: (context) => ProfileCubit(NetworkService()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'E-Kart',
        home: LoginPage()
      ),
    );
  }
}