import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petgram_mobile_app/bloc/all_post_bloc/all_post_bloc.dart';
import 'package:petgram_mobile_app/bloc/delete_post_bloc/delete_post_bloc.dart';
import 'package:petgram_mobile_app/bloc/edit_post_bloc/edit_post_bloc.dart';
import 'package:petgram_mobile_app/bloc/following_post_bloc/following_post_bloc.dart';
import 'package:petgram_mobile_app/bloc/my_profile_bloc/profile_bloc.dart';
import 'package:petgram_mobile_app/components/my_form_field.dart';
import 'package:petgram_mobile_app/constants/base_color.dart';
import 'package:petgram_mobile_app/models/post_models/following_post_model.dart';

class ProfilePhotosList extends StatelessWidget {
  final List<PostModel> postList;
  final bool isMe;
  final GlobalKey<ScaffoldState> scaffoldKey;
  TextEditingController _controller = TextEditingController();

  ProfilePhotosList({this.postList,this.isMe,this.scaffoldKey});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.only(top: 10),
      itemCount: postList.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, mainAxisSpacing: 0, crossAxisSpacing: 0),
      itemBuilder: (context, i) {
        _controller = TextEditingController(text: postList[i].caption);
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
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
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
                    icon: Icon(Icons.more_vert,color: BaseColor.white,),
                    onPressed: (){
                      showModalBottomSheet(
                          context: context,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)
                          ),
                          builder: (context)=>BlocListener<DeletePostBloc,DeletePostState>(
                            listener: (context,state){
                              if(state is DeletePostSuccess){
                                print('success');
                                BlocProvider.of<ProfileBloc>(context).add(FetchMyProfile());
                                BlocProvider.of<AllPostBloc>(context).add(FetchAllPostEvent());
                                scaffoldKey.currentState.showSnackBar(SnackBar(
                                  content: Text('Delete Success'),
                                ));
                              }
                              if(state is DeletePostFailure){

                              }
                            },
                            child: Container(
                        height: 130.0,
                         child: Column(
                             children: [
                               ListTile(
                                 leading: Icon(Icons.delete),
                                 title: Text('Delete Post'),
                                 onTap: (){
                                   BlocProvider.of<DeletePostBloc>(context)..add(DeletePost(
                                       id: postList[i].id
                                   ));
                                     Future.delayed(Duration(seconds: 1),(){
//                                     BlocProvider.of<ProfileBloc>(context).add(FetchMyProfile());
//                                     BlocProvider.of<FollowingPostBloc>(context).add(UpdateFollowingPost());
//                                     BlocProvider.of<AllPostBloc>(context).add(FetchAllPostEvent());
                                       Navigator.pop(context);
                                     });
                                 },
                               ),
                               ListTile(
                                 leading: Icon(Icons.edit),
                                 title: Text('Edit Post'),
                                 onTap: (){
                                   Navigator.pop(context);
                                   showDialog(context: context,builder: (context)=>BlocListener<EditPostBloc,EditPostState>(
                                     listener: (context,state){
                                       print('edit post $state');
                                       if(state is EditPostLoading){
                                         scaffoldKey.currentState..hideCurrentSnackBar()
                                           ..showSnackBar(SnackBar(
                                             content: Text('Loading..'),
                                           ));
                                       }
                                       if(state is EditPostSuccess){
                                         scaffoldKey.currentState..hideCurrentSnackBar()
                                           ..showSnackBar(SnackBar(
                                             content: Text('Success Edit Post'),
                                           ));
                                       }
                                       if(state is EditPostFailure){
                                         scaffoldKey.currentState
                                           ..hideCurrentSnackBar()..showSnackBar(SnackBar(
                                           content: Text(state.msg),
                                         ));
                                       }
                                     },
                                     child: AlertDialog(
                                       title: Text('Edit Post'),
                                       content: MyFormField(
                                         textEditingController: _controller,
                                         keyboardType: TextInputType.text,
                                         labelText: 'Caption',
                                         hintText: 'Caption',
//                                         initialValue: postList[i].caption,
                                       ),
                                       actions: [
                                         FlatButton(
                                           onPressed: (){
                                             Navigator.pop(context);
                                           },
                                           child: Text('Cancel'),
                                         ),
                                         FlatButton(
                                           child: Text('Done'),
                                           onPressed: (){
                                             Navigator.pop(context);
                                             BlocProvider.of<EditPostBloc>(context).add(EditPost(
                                                 id: postList[i].id,caption: _controller.text
                                             ));
                                           },
                                         )
                                       ],
                                     ),
                                   ));
//                                   Navigator.pushNamed(context, '/editPost',arguments: postList[i].caption);
                                 },
                               ),
                             ],
                         ),
                      ),
                          ));
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
