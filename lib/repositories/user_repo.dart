import 'dart:io';

import 'package:dio/dio.dart';
import 'package:petgram_mobile_app/models/user_models/search_user_model.dart';
import 'package:petgram_mobile_app/repositories/edit_profile_repo.dart';
import 'package:petgram_mobile_app/services/base_service.dart';


abstract class USER{
  Future<bool> followUser(String id);
  Future<bool> unFollowUser(String id);
  Future<bool> editProfilePic({File image});
  Future<bool> editNameProfile({String name});
  Future<bool> editPetNameProfile({String petname});
  Future<bool> editPasswordProfile({String password});
  Future<SearchUserModel> searchUser({String query});
}

class UserRepo extends BaseService implements USER{

  @override
  Future<bool> followUser(String id) async{
    final Response response = await request(endpoint: 'user/follow/$id',requestType: RequestType.PUT);
    final bool status = response.data['status'];
    print(response.data);
    return status;
  }

  @override
  Future<bool> unFollowUser(String id) async{
    final Response response = await request(endpoint: 'user/unfollow/$id',requestType: RequestType.PUT);
    final bool status = response.data['status'];
    print(response.data);
    return status;
  }

  @override
  Future<bool> editProfilePic({File image}) async{
    EditProfileRepo editProfileRepo = EditProfileRepo();
    bool status;
    if(image == null){
      status = await editProfileRepo.edit();
    }else{
      final String fileName = image.path.split('/').last;
      status = await editProfileRepo.edit(data: FormData.fromMap({
        "image": await MultipartFile.fromFile(image.path,filename: fileName)
      }));
    }
    return status;
  }

  @override
  Future<bool> editNameProfile({String name}) async{
    EditProfileRepo editProfileRepo = EditProfileRepo();
    bool status = await editProfileRepo.edit(data: FormData.fromMap({
      "name":name
    }));
    return status;
  }

  @override
  Future<bool> editPetNameProfile({String petname}) async{
    EditProfileRepo editProfileRepo = EditProfileRepo();
    bool status = await editProfileRepo.edit(data: FormData.fromMap({
      "petname":petname
    }));
    return status;
  }

  @override
  Future<bool> editPasswordProfile({String password}) async {
    EditProfileRepo editProfileRepo = EditProfileRepo();
    bool status = await editProfileRepo.edit(data: FormData.fromMap({
      "password":password
    }));
    return status;
  }

  @override
  Future<SearchUserModel> searchUser({String query}) async{
    final Response response = await request(endpoint: 'user/search?user=$query',requestType: RequestType.GET);
    final SearchUserModel res = SearchUserModel.fromMap(response.data);
    print(response.data);
    return res;
  }
}