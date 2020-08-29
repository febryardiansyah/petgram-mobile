import 'package:dio/dio.dart';
import 'package:petgram_mobile_app/helpers/shared_preferences/token_pref.dart';
import 'package:petgram_mobile_app/services/interceptor_service.dart';

enum RequestType {GET, POST, PUT, DELETE}

class BaseService {
  Dio _dio = new Dio();

  Future<dynamic> request({RequestType requestType,dynamic data,String endpoint})async{
    _dio.interceptors.add(HeaderInterceptor());
    Response _response;
    try{
      switch(requestType){
        case RequestType.GET:
          _response = await _dio.get(endpoint);
          break;
        case RequestType.POST:
          _response = await _dio.post(endpoint,data: data);
          break;
      }
    }on DioError catch(e){
      _response = e.response;
    }

    return _response;
  }
  Dio dio() {
    Dio dio = new Dio();
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (RequestOptions options)async{
//        options.baseUrl = 'https://petgram-server.herokuapp.com/';
        options.baseUrl = 'http://58ab31e0b3ef.ngrok.io/';
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
