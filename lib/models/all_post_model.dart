import 'package:equatable/equatable.dart';
import 'package:petgram_mobile_app/models/following_post_model.dart';

class AllPostModel extends Equatable{
  bool status;
  String message;
  List<PostModel> allPost;

  AllPostModel({this.status, this.message, this.allPost});


  factory AllPostModel.fromMap(Map<String,dynamic>json){
    return AllPostModel(
      status: json['status'],
      message: json['message'],
      allPost: List<PostModel>.from(json['allpost'].map((item)=> PostModel.fromMap(item)))
    );
  }

  @override
  List<Object> get props => [status,message,allPost];
}