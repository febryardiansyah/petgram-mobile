import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:petgram_mobile_app/bloc/detail_post_bloc/detail_post_bloc.dart';
import 'package:petgram_mobile_app/bloc/following_post_bloc/following_post_bloc.dart';
import 'package:petgram_mobile_app/bloc/my_profile_bloc/profile_bloc.dart';
import 'package:petgram_mobile_app/bloc/postComment_bloc/post_comment_bloc.dart';
import 'package:petgram_mobile_app/constants/base_color.dart';
import 'package:petgram_mobile_app/helpers/shared_preferences/profile_pref.dart';

class CommentForm extends StatelessWidget {
  final String image;
  final String id;

  TextEditingController _textCtrl = TextEditingController();


  CommentForm({this.image,this.id});

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width,
        maxHeight: MediaQuery.of(context).size.height),
        designSize: Size(720, 1280),
        orientation: Orientation.portrait);
//    final size = MediaQuery.of(context).size;

    return BlocConsumer<PostCommentBloc,PostCommentState>(
      listener: (context,state){
        if(state is PostCommentSuccess){
          BlocProvider.of<DetailPostBloc>(context).add(UpdateDetailPost(id: id));
          BlocProvider.of<FollowingPostBloc>(context).add(UpdateFollowingPost());
        }
        if(state is PostCommentFailure){
          Scaffold.of(context)..hideCurrentSnackBar()
              ..showSnackBar(SnackBar(content: Text(state.msg),));
        }
      },
      builder:(context,state) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            BlocBuilder<MyProfileBloc,MyProfileState>(
              builder:(context,state) {
                if(state is MyProfileLoaded){
                  return Container(
                    width: 100.w,
                    height: 100.h,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: BaseColor.grey3,
                        image: DecorationImage(
                            image: NetworkImage(state.userProfileModel.user.detailModel.profilePic),
                            fit: BoxFit.cover
                        )
                    ),
                  );
                }
                return Container();
              }
            ),
            SizedBox(width: 10,),
            Container(
              width: 700.w,
              height: 140.h,
              child: TextFormField(
                controller: _textCtrl,
                maxLines: 10,
                decoration: InputDecoration(
                   contentPadding: EdgeInsets.all(8),
                  hintText: 'enter comment..',
                  fillColor: BaseColor.grey1,
                  filled: true,
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: BaseColor.grey2,width: 1),
                      borderRadius: BorderRadius.all(Radius.circular(8))
                  ),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: BaseColor.grey2,width: 1),
                      borderRadius: BorderRadius.all(Radius.circular(8))
                  ),
                ),
              ),
            ),
            SizedBox(width: 10,),
            GestureDetector(
              onTap: (){
                context.read<PostCommentBloc>().add(CommentEvent(
                  id: id,text: _textCtrl.text,
                ));
                FocusScope.of(context).requestFocus(FocusNode());
                _textCtrl.clear();
              },
              child: Container(
                decoration: BoxDecoration(
                  color: BaseColor.grey1,
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  border: Border.all(width: 1,color: BaseColor.grey2),
                ),
                child: Center(
                  child: IconButton(
                    icon: Icon(Icons.send,color: BaseColor.red,),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
