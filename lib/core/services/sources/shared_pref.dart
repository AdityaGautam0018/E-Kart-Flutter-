import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHelper{
  static String userAccessToken = "USERACCESSTOKEN";

  storeUserToken({required String token})async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString(userAccessToken, token);
    await pref.reload();
  }

  Future<String?> getToken()async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.reload();
    return pref.getString(userAccessToken);
  }
}

