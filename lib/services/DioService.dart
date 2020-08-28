import 'package:dio/dio.dart';
import 'package:petgram_mobile_app/helpers/shared_preferences/token_pref.dart';

class DioService {
  static Dio dio() {
    final BaseOptions options = BaseOptions(
        baseUrl: 'https://petgram-server.herokuapp.com/',
      headers: {
        "authorization": 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI1ZjM5M2Q0MmI3MjNmYzE2ZTEzZWU2YWIiLCJpYXQiOjE1OTg1MjMyNTh9.WBPyAJDqGPrzA0NiOoe4sFSPAIr-lPC90BqQ1HCW1-A',
      },
//      connectTimeout: 5000,
//      receiveTimeout: 3000,
    );
    Dio dio = new Dio();
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (RequestOptions options)async{
        options.baseUrl = 'http://1d78b8f32a1e.ngrok.io/';
        final token = await TokenPref.getToken();
        if(token != null){
          print('token <====================> $token');
          options.headers['authorization'] = 'Bearer $token';
        }
        return options;
      }
    ));
    return dio;
  }
}
