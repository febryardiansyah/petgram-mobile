import 'package:dio/dio.dart';
import 'package:petgram_mobile_app/helpers/shared_preferences/token_pref.dart';

class HeaderInterceptor extends InterceptorsWrapper{
  @override
  Future onRequest(RequestOptions options) async{
//    options.baseUrl = 'https://petgram-server.herokuapp.com/';
    options.baseUrl = 'http://58ab31e0b3ef.ngrok.io/';
    final token = await TokenPref.getToken();
    if(token != null){
      print('token <====================> $token');
      options.headers['authorization'] = 'Bearer $token';
    }
    return options;
  }
}