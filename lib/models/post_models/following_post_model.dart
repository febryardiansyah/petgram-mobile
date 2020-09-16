class FollowingPostModel {
  String message;
  List<PostModel> postModel;

  FollowingPostModel({this.message, this.postModel});

  factory FollowingPostModel.fromMap(Map<String, dynamic> json) {
    return FollowingPostModel(
        message: json['message'],
        postModel: List<PostModel>.from(
            json['followingPostUser'].map((item) => PostModel.fromMap(item))));
  }
}

class PostModel {
  String id, caption, imageUrl, createdAt;
  List<String> likes;
  PostedByModel postedBy;
  List<CommentModel> comments;
  bool isLiked;

  PostModel(
      {this.id,
      this.caption,
      this.imageUrl,
      this.createdAt,
      this.likes,
      this.postedBy,
      this.comments,
      this.isLiked});

  factory PostModel.fromMap(Map<String, dynamic> json) {
    return PostModel(
        id: json['_id'],
        caption: json['caption'],
        imageUrl: json['imageUrl'],
        postedBy: PostedByModel.fromMap(json['postedBy']),
        createdAt: json['createdAt'],
        likes: List<String>.from(json['likes']),
        isLiked: json['isLiked'],
        comments: List<CommentModel>.from(
            json['comments'].map((i) => CommentModel.fromMap(i))));
  }
}

class CommentModel {
  String id, text;
  bool isCommentByMe;
  PostedByModel postedBy;

  CommentModel({this.id, this.text, this.postedBy,this.isCommentByMe});

  factory CommentModel.fromMap(Map<String, dynamic> json) {
    return CommentModel(
      id: json['_id'],
      text: json['text'],
      isCommentByMe: json['isCommentbyMe'],
      postedBy: PostedByModel.fromMap(json['postedBy']),
    );
  }
}

class PostedByModel {
  String id, name, profilePic;

  PostedByModel({this.id, this.name, this.profilePic});

  factory PostedByModel.fromMap(Map<String, dynamic> json) {
    return PostedByModel(
        id: json['_id'], name: json['name'], profilePic: json['profilePic']);
  }
}
