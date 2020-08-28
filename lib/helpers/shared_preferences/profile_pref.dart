import 'package:shared_preferences/shared_preferences.dart';

class ProfilePreference {

  static void setProfile(String url)async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('profilePic', url);
  }

  static Future<String> getProfile()async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    String pic = pref.getString('profilePic');
    return pic;
  }

  static Future<void> removeProfile()async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.remove('profilePic');
  }
}