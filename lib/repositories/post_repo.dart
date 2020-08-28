import 'package:dio/dio.dart';
import 'package:petgram_mobile_app/models/following_post_model.dart';
import 'package:petgram_mobile_app/services/DioService.dart';

abstract class POST{
  Future<FollowingPostModel> getFollowingPost();
}

class PostRepo implements POST{

  @override
  Future<FollowingPostModel> getFollowingPost()async {
    try{
      Response response = await DioService.dio().get('post/followingpost');
      var res = FollowingPostModel.fromMap(response.data);
      return res;
    }on DioError catch(e){
      print('whyy error');
      print(e.response.data);
    }
  }
}