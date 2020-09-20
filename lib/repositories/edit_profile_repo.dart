import 'package:dio/dio.dart';
import 'package:petgram_mobile_app/services/base_service.dart';

class EditProfileRepo extends BaseService{

  Future<bool> edit({dynamic data})async{
    final Response response = await request(endpoint: 'user/editprofile',data: data,
        requestType: RequestType.PUT);
    print(response.data);
    final bool status = response.data['status'];
    return status;
  }
}