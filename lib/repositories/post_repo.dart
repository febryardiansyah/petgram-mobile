import 'package:dio/dio.dart';
import 'package:petgram_mobile_app/models/following_post_model.dart';
import 'package:petgram_mobile_app/models/user_profile_model.dart';
import 'package:petgram_mobile_app/services/base_service.dart';

abstract class POST{
  Future<FollowingPostModel> getFollowingPost();
  Future<UserProfileModel> getMyProfile();
  Future<UserProfileModel> getUserProfile(String id);
}

class PostRepo extends BaseService implements POST{

  @override
  Future<FollowingPostModel> getFollowingPost()async {
    Response response = await request(endpoint:'post/followingpost',requestType: RequestType.GET );
    if(response.data['message'] == 'no post'){
      return null;
    }
    var res = FollowingPostModel.fromMap(response.data);
    return res;
  }

  @override
  Future<UserProfileModel> getMyProfile() async{
    Response response = await request(endpoint: 'user/me',requestType: RequestType.GET);
    if(response.data ==null){
      return null;
    }
    UserProfileModel res = UserProfileModel.fromMap(response.data);
    return res;
  }

  @override
  Future<UserProfileModel> getUserProfile(String id)async {
    final Response response = await request(endpoint: 'user/profile/$id',requestType: RequestType.GET);
    print(response.data);
    final res = UserProfileModel.fromMap(response.data);
    return res;

  }
}