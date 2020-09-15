import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petgram_mobile_app/bloc/delete_post_bloc/delete_post_bloc.dart';
import 'package:petgram_mobile_app/bloc/my_profile_bloc/profile_bloc.dart';
import 'package:petgram_mobile_app/constants/base_color.dart';
import 'package:petgram_mobile_app/models/post_models/following_post_model.dart';

class ProfilePhotosList extends StatelessWidget {
  final List<PostModel> postList;
  final bool isMe;

  ProfilePhotosList({this.postList,this.isMe});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.only(top: 10),
      itemCount: postList.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, mainAxisSpacing: 0, crossAxisSpacing: 0),
      itemBuilder: (context, i) {
        return Stack(
          children: [
            GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/detailPost',
                      arguments: postList[i]);
                },
                child: Image.network(
                  postList[i].imageUrl,
                  fit: BoxFit.cover,
                )),
            isMe?Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: BaseColor.red,
                  shape: BoxShape.circle
                ),
                child: Center(
                  child: IconButton(
                    icon: Icon(Icons.delete,color: BaseColor.white,),
                    onPressed: (){
                      BlocProvider.of<DeletePostBloc>(context)..add(DeletePost(
                        id: postList[i].id
                      ));

                      if(isMe){
                        BlocProvider.of<ProfileBloc>(context).add(FetchMyProfile());
                      }else{
                        BlocProvider.of<ProfileBloc>(context).add(FetchUserProfile());
                      }
                    },
                  ),
                ),
              )
            ):Center()
          ],
        );
      },
    );
  }
}
