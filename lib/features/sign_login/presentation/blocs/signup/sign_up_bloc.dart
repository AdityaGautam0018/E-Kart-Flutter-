import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:ekart/features/sign_login/data/models/user.dart';

import '../../../../../core/services/dioservice/network_service.dart';

part 'sign_up_event.dart';

part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  NetworkService networkService;

  SignUpBloc(this.networkService) : super(SignUpInitial()) {
    on<SignUpEvent>((event, emit) {
      on<SignUpButtonPressed>(_onSignUpPressed);
    });
  }

  FutureOr<void> _onSignUpPressed(SignUpButtonPressed event,
      Emitter<SignUpState> emit) async {
    emit(SignUpLoading());
    try {
      await networkService.createUser(User(name: event.name,
          email: event.email,
          password: event.password,
          avatar: event.avatarPath?? "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?fm=jpg&q=60&w=3000&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8cGVyc29ufGVufDB8fDB8fHww"));
      emit(SignUpSuccess());
    }catch(e){
      emit(SignUpFailure(e.toString()));

    }
  }
}
