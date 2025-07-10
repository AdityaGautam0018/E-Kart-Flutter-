import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:ekart/core/services/sources/shared_pref.dart';
import 'package:ekart/features/sign_login/data/models/user_login.dart';

import '../../../../../core/services/dioservice/network_service.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  NetworkService networkService;

  LoginBloc(this.networkService) : super(LoginInitial()) {
    on<LoginButtonPressed>(_onLoginButtonPressed);
  }

  FutureOr<void> _onLoginButtonPressed(LoginButtonPressed event,
      Emitter<LoginState> emit)async {
    emit(LoginLoading());
    try{
      final token = await networkService.loginUser(UserLogin(email: event.email, password: event.password));
      // await SharedPreferenceHelper().storeUserToken(token: token);
      emit(LoginSuccess(token));
    }catch(e){
      emit(LoginFailure(e.toString()));
    }
  }
}
