import 'package:equatable/equatable.dart';
import 'package:petgram_mobile_app/models/post_models/following_post_model.dart';

class UserProfileModel extends Equatable {
  bool status;
  String message;
  UserDetailModel user;

  UserProfileModel({this.status, this.message, this.user});


  factory UserProfileModel.fromMap(Map<String,dynamic>json){
    return UserProfileModel(
      status: json['status'],
      message: json['message'],
      user: UserDetailModel.fromMap(json['user'])
    );
  }

  @override
  List<Object> get props => [status,message,user];
}

class UserDetailModel {
  DetailModel detailModel;
  List<PostModel> postModel;

  UserDetailModel({this.detailModel, this.postModel});

  factory UserDetailModel.fromMap(Map<String, dynamic> json) {
    return UserDetailModel(
        detailModel: DetailModel.fromMap(json['detail']),
        postModel: List<PostModel>.from(
            json['posts'].map((item) => PostModel.fromMap(item))));
  }
}

class DetailModel {
  String id, email, name, petname, profilePic;
  bool isMe;
  List<String> following;
  List<String> followers;

  DetailModel(
      {this.id,
      this.email,
      this.name,
      this.petname,
      this.profilePic,
      this.following,
      this.followers,
      this.isMe});

  factory DetailModel.fromMap(Map<String, dynamic> json) {
    return DetailModel(
      id: json['_id'],
      name: json['name'],
      petname: json['petname'],
      profilePic: json['profilePic'],
      email: json['email'],
      isMe: json['isMe'],
      followers: List<String>.from(json['followers']),
      following: List<String>.from(json['following']),
    );
  }
}
