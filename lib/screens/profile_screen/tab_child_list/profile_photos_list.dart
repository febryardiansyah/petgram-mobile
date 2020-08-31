import 'package:flutter/material.dart';
import 'package:petgram_mobile_app/models/following_post_model.dart';

class ProfilePhotosList extends StatelessWidget {
  final List<PostModel> postList;

  ProfilePhotosList({this.postList});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.only(top: 10),
      itemCount: postList.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 0,
        crossAxisSpacing: 0
      ),
      itemBuilder: (context,i){
        return Image.network(postList[i].imageUrl,fit: BoxFit.cover,);
      },
    );
  }
}
