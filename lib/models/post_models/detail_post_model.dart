import 'package:equatable/equatable.dart';
import 'package:petgram_mobile_app/models/post_models/following_post_model.dart';

class DetailPostModel extends Equatable {
  bool status;
  String message;
  PostModel post;

  DetailPostModel({this.status, this.message, this.post});


  factory DetailPostModel.fromMap(Map<String,dynamic>json){
    return DetailPostModel(
        status : json['status'],
      message: json['message'],
      post: PostModel.fromMap(json['post'])
    );
  }

  @override
  List<Object> get props => [status,message,post];
}
