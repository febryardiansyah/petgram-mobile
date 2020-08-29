import 'package:dio/dio.dart';
import 'package:petgram_mobile_app/models/following_post_model.dart';
import 'package:petgram_mobile_app/services/base_service.dart';

abstract class POST{
  Future<FollowingPostModel> getFollowingPost();
}

class PostRepo extends BaseService implements POST{

  @override
  Future<FollowingPostModel> getFollowingPost()async {
    Response response = await request(endpoint:'post/followingpost',requestType: RequestType.GET );
    var res = FollowingPostModel.fromMap(response.data);
    return res;
//    try{
//      Response response = await dio().get('post/followingpost');
//      var res = FollowingPostModel.fromMap(response.data);
//      return res;
//    }on DioError catch(e){
//      print('whyy error');
//      print(e.response.data);
//    }
  }
}