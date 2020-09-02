class LikeUnlikeModel{
  String message;
  bool status,isLiked;
  TotalLikesModel totalLikes;

  LikeUnlikeModel({this.message, this.status, this.isLiked, this.totalLikes});

  factory LikeUnlikeModel.fromMap(Map<String,dynamic>json){
    return LikeUnlikeModel(
      message: json['message'],
      status: json['status'],
      isLiked: json['isLiked'],
      totalLikes: json['result']
    );
  }
}

class TotalLikesModel{
  List<String>likes;

  TotalLikesModel({this.likes});

  factory TotalLikesModel.fromMap(Map<String,dynamic>json){
    return TotalLikesModel(
      likes: List<String>.from(json['likes'])
    );
  }
}