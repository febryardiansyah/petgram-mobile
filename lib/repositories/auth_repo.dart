import 'package:dio/dio.dart';
import 'package:petgram_mobile_app/services/base_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class Auth {
  Future<Response> signIn({String email, String password});

  Future<bool> hasToken();

  Future<void> persistToken(String token);

  Future<void> deleteToken();

  Future<List<String>> register(
      {String name, String password, String email, String petname});
}

class AuthRepository extends BaseService implements Auth {
  @override
  Future<Response> signIn({String email, String password}) async {
    Response response = await request(
        endpoint: 'user/signin',
        data: FormData.fromMap({'email': email, 'password': password}),
        requestType: RequestType.POST);
    return response;
  }

  @override
  Future<List<String>> register(
      {String name, String password, String email, String petname}) async {
    List<String> _list = [];
    try {
      Response response = await dio().post('user/register',
          data: FormData.fromMap({
            'email': email,
            'password': password,
            'name': name,
            'petname': petname,
          }));
      final message = response.data['message'].toString();
      final statusCode = response.statusCode.toString();
      _list.addAll([message, statusCode]);
      print(_list);
      return _list;
    } on DioError catch (e) {
      final message = e.response.data['message'].toString();
      final statusCode = e.response.statusCode.toString();
      _list.addAll([message, statusCode]);
      return _list;
    }
  }

  @override
  Future<void> deleteToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('token');
  }

  @override
  Future<bool> hasToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String _token = prefs.getString('token');
    return _token != null;
  }

  @override
  Future<void> persistToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', token);
  }
}
