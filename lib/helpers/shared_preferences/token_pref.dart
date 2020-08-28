import 'package:shared_preferences/shared_preferences.dart';

class TokenPref{
  static Future<String> getToken()async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    String token = pref.get('token');
    return token;
  }
}