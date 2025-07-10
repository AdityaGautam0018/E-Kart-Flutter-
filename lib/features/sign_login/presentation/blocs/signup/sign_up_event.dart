part of 'sign_up_bloc.dart';

@immutable
sealed class SignUpEvent {}

class SignUpButtonPressed extends SignUpEvent {
  final String name;
  final String email;
  final String password;
  final String? avatarPath;

  SignUpButtonPressed({
    required this.name,
    required this.email,
    required this.password,
    required this.avatarPath,
  });
}
