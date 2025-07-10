part of 'profile_cubit.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}
class ProfileLoaded extends ProfileState{
  final Profile profile;

  ProfileLoaded({required this.profile});

}