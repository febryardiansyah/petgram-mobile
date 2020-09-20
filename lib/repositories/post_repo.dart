import 'dart:io';

import 'package:dio/dio.dart';
import 'package:petgram_mobile_app/models/post_models/all_post_model.dart';
import 'package:petgram_mobile_app/models/post_models/detail_post_model.dart';
import 'package:petgram_mobile_app/models/post_models/following_post_model.dart';
import 'package:petgram_mobile_app/models/post_models/like_unlike_model.dart';
import 'package:petgram_mobile_app/models/user_models/user_profile_model.dart';
import 'package:petgram_mobile_app/services/base_service.dart';

abstract class POST{
  Future<FollowingPostModel> getFollowingPost();
  Future<UserProfileModel> getMyProfile();
  Future<UserProfileModel> getUserProfile(String id);
  Future<LikeUnlikeModel> likePost(String id);
  Future<Response> unlikePost(String id);
  Future<AllPostModel> getAllPost();
  Future<DetailPostModel> getDetailPost({String id});
  Future<Response> postComment({String id,String text});
  Future<bool> deleteComment({String id,String commentId});
  Future<bool> deletePost(String id);
  Future<Response> createPost({File image,String caption});
  Future<bool> editPost({String id, String caption});
}

class PostRepo extends BaseService implements POST{

  @override
  Future<FollowingPostModel> getFollowingPost()async {
    Response response = await request(endpoint:'post/followingpost',requestType: RequestType.GET );
    if(response.data['message'] == 'no post'){
      return null;
    }
    var res = FollowingPostModel.fromMap(response.data);
    print(res.message);
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

  @override
  Future<LikeUnlikeModel> likePost(String id) async{
    final Response response = await request(endpoint: 'post/like',data: FormData.fromMap({
      'postId':id
    }),requestType: RequestType.PUT);
    print(response.data);
    final LikeUnlikeModel res = LikeUnlikeModel.fromMap(response.data);
    return res;
  }

  @override
  Future<Response> unlikePost(String id)async {
    final Response response = await request(endpoint: 'post/unlike',data: FormData.fromMap({
      'postId':id
    }),requestType: RequestType.PUT);
    print(response.data['message']);
    return response;
  }

  @override
  Future<AllPostModel> getAllPost() async{
    final Response response = await request(endpoint: 'post/allpost',requestType: RequestType.GET);
    print(response.data);
    final AllPostModel res = AllPostModel.fromMap(response.data);
    return res;
  }

  @override
  Future<DetailPostModel> getDetailPost({String id}) async {
    final Response response = await request(endpoint: 'post/detailpost/$id',requestType: RequestType.GET);
    print(response.data);
    DetailPostModel res = DetailPostModel.fromMap(response.data);
    return res;
  }

  @override
  Future<Response> postComment({String id,String text}) async {
    final Response response = await request(endpoint:'post/comment',requestType:RequestType.PUT,data: FormData.fromMap({
      'postId':id,'text':text
    }) );
    return response;
  }
  @override
  Future<bool> deleteComment({String id, String commentId}) async{
    final Response response = await request(endpoint: 'post/deletecomment',requestType: RequestType.PUT,data: FormData.fromMap({
      'postId':id,'commentId':commentId
    }));
    bool status = response.data['status'];
    return status;
  }

  @override
  Future<bool> deletePost(String id) async{
    final Response response = await request(endpoint: 'post/deletepost/$id',requestType: RequestType.DELETE);
    final bool status = response.data['status'];
    return status;
  }

  @override
  Future<Response> createPost({File image, String caption}) async{
    FormData data = FormData();
    if(image == null){
       data = FormData.fromMap({
        "caption":caption
      });
    }else{
      String fileName = image.path.split('/').last;
      data = FormData.fromMap({
        "image": await MultipartFile.fromFile(image.path,filename: fileName),
        "caption":caption
      });
    }

    final Response response = await request(endpoint: 'post/createpost',data: data,requestType: RequestType.POST);
    print(response.data);

    return response;
  }

  @override
  Future<bool> editPost({String id, String caption}) async{
    final Response response = await request(endpoint: 'post/editpost',data:FormData.fromMap({
      "postId":id,"caption":caption
    }),requestType: RequestType.PUT );
    final bool res = response.data['status'];
    return res;
  }

}