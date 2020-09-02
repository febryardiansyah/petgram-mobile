import 'package:dio/dio.dart';
import 'package:petgram_mobile_app/helpers/shared_preferences/token_pref.dart';

class HeaderInterceptor extends InterceptorsWrapper{
  @override
  Future onRequest(RequestOptions options) async{
    options.baseUrl = 'https://pegtram.azurewebsites.net/';
//    options.baseUrl = 'http://6db487588f77.ngrok.io/';
    final token = await TokenPref.getToken();
    if(token != null){
      print('token <====================> $token');
      options.headers['authorization'] = 'Bearer $token';
    }
    return options;
  }
}