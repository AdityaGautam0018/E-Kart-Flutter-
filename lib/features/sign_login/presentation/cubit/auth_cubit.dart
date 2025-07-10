import 'package:bloc/bloc.dart';

class AuthCubit extends Cubit<String?> {
  AuthCubit() : super(null);

  void setToken(String token) => emit(token);
  String? get token => state;
}