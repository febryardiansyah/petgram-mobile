import 'package:dio/dio.dart';
import 'package:petgram_mobile_app/models/following_post_model.dart';
import 'package:petgram_mobile_app/models/user_profile_model.dart';
import 'package:petgram_mobile_app/services/base_service.dart';

abstract class POST{
  Future<FollowingPostModel> getFollowingPost();
  Future<UserProfileModel> getMyProfile();
}

class PostRepo extends BaseService implements POST{

  @override
  Future<FollowingPostModel> getFollowingPost()async {
    Response response = await request(endpoint:'post/followingpost',requestType: RequestType.GET );
    print(response.data);
    var res = FollowingPostModel.fromMap(response.data);
    return res;
  }

  @override
  Future<UserProfileModel> getMyProfile() async{
    Response response = await request(endpoint: 'user/me',requestType: RequestType.GET);
    print(response.data);
    UserProfileModel res = UserProfileModel.fromMap(response.data);
    return res;
  }
}