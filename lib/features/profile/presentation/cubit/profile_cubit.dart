import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:ekart/core/services/dioservice/network_service.dart';
import 'package:ekart/features/profile/data/model/profile.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  NetworkService networkService;
  ProfileCubit(this.networkService) : super(ProfileInitial());
 


  getUserProfile(String token)async{
    final profile = await networkService.getUserProfileInfo(token);
    emit(ProfileLoaded(profile: profile));
  }
}
