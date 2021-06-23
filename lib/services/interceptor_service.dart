import 'package:dio/dio.dart';
import 'package:petgram_mobile_app/helpers/shared_preferences/token_pref.dart';

class HeaderInterceptor extends InterceptorsWrapper{
  @override
  Future onRequest(RequestOptions options,RequestInterceptorHandler handler) async{
    options.baseUrl = 'https://petgram-server.herokuapp.com/';
    final token = await TokenPref.getToken();
    if(token != null){
      print('token <====================> $token');
      options.headers['authorization'] = 'Bearer $token';
    }
    super.onRequest(options, handler);
  }
}