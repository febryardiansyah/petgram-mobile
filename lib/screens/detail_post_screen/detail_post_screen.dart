import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:petgram_mobile_app/bloc/detail_post_bloc/detail_post_bloc.dart';
import 'package:petgram_mobile_app/bloc/following_post_bloc/following_post_bloc.dart';
import 'package:petgram_mobile_app/bloc/like_unlike_bloc/like_unlike_bloc.dart';
import 'package:petgram_mobile_app/bloc/postComment_bloc/post_comment_bloc.dart';
import 'package:petgram_mobile_app/constants/base_color.dart';
import 'package:petgram_mobile_app/helpers/shared_preferences/profile_pref.dart';
import 'package:petgram_mobile_app/models/post_models/detail_post_model.dart';
import 'package:petgram_mobile_app/models/post_models/following_post_model.dart';
import 'package:petgram_mobile_app/screens/detail_post_screen/comment_form.dart';
import 'package:photo_view/photo_view.dart';

class DetailPostScreen extends StatefulWidget {
  final PostModel postModel;

  DetailPostScreen({this.postModel});

  @override
  _DetailPostScreenState createState() => _DetailPostScreenState();
}

class _DetailPostScreenState extends State<DetailPostScreen> {
  PostModel get post => widget.postModel;

  String image = '';
  bool _isShowLove = false;
  _getImageLink()async{
    String img = await ProfilePreference.getProfile();
    setState(() {
      image = img;
    });
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<DetailPostBloc>(context).add(FetchDetailPost(id: post.id));
    BlocProvider.of<PostCommentBloc>(context);
    _getImageLink();
  }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    ScreenUtil.init(context);
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: BaseColor.black
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        },icon: Icon(Icons.arrow_back_ios),),
        title: GestureDetector(
          onTap: (){
            Navigator.pushNamed(context, '/userProfile',arguments: post.postedBy.id);
          },
          child: Row(
              children: [
            Container(
              width: 70.w,
              height: 70.h,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: NetworkImage(post.postedBy.profilePic),
                      fit: BoxFit.cover
                  )
              ),
            ),
            SizedBox(width: 8,),
            Text(post.postedBy.name,style: TextStyle(fontWeight: FontWeight.bold,color: BaseColor.black),)]),
        ),
        actions: [
          Center(child: Text('${post.createdAt}',style: TextStyle(color: BaseColor.grey2,fontSize: 12),))
        ],
      ),
      body: BlocConsumer<DetailPostBloc,DetailPostState>(
        listener: (context,state){},
        builder:(context,state){
         if(state is DetailPostLoading){
           return Center(child: Text('loading...'),);
         }
         if(state is DetailPostLoaded){
           final _data = state.detailPost.post;
           return SingleChildScrollView(
             child: Container(
               width: size.width,
               height: size.height*0.9,
               child: Stack(
                 children: [
                   Column(
                     children: [
                       GestureDetector(
                         child: Container(
                           width: size.width,
                           height: 700.h,
                           decoration: BoxDecoration(
                               image: DecorationImage(
                                   image: NetworkImage(_data.imageUrl),
                                   fit: BoxFit.cover
                               )
                           ),
                           child: _isShowLove?FlareActor('assets/flares/love_heart.flr',animation: _isShowLove?'Like heart':'',):Center(),
                         ),
                         onTap: (){
                           showModalBottomSheet(context: context,isScrollControlled: true,
                               backgroundColor: BaseColor.black,
                               builder: (context){
                             return Container(
                               height: MediaQuery.of(context).size.height - 50,
                               child: PhotoView(
                                 imageProvider: NetworkImage(_data.imageUrl),
                               ),
                             );
                           });
                         },
                         onDoubleTap: (){
                           setState(() {
                             _isShowLove = true;
                           });
                           context.bloc<LikeUnlikeBloc>().add(LikeEvent(id: _data.id));
                           Future.delayed(Duration(milliseconds: 500),(){
                             context.bloc<DetailPostBloc>().add(UpdateDetailPost(id: widget.postModel.id));
                             context.bloc<FollowingPostBloc>().add(UpdateFollowingPost());
                           });

                           Future.delayed(Duration(seconds: 3),(){
                             setState(() {
                               _isShowLove = false;
                             });
                           });
                         },
                       ),
                       SizedBox(width: 10,),
                       Padding(
                         padding: EdgeInsets.only(left: 8,top: 4),
                         child: Wrap(
                           children: [
                             Row(
                               children: [
                                 _data.isLiked ?GestureDetector(
                                   child: Icon(Icons.favorite,color: BaseColor.red,),
                                   onTap: (){

                                     context.bloc<LikeUnlikeBloc>().add(UnlikeEvent(id: _data.id));
                                     Future.delayed(Duration(milliseconds: 500),(){
                                       context.bloc<DetailPostBloc>().add(UpdateDetailPost(id: widget.postModel.id));
                                       context.bloc<FollowingPostBloc>().add(UpdateFollowingPost());
                                     });

                                   },):GestureDetector(
                                   child: Icon(Icons.favorite_border),
                                   onTap: (){

                                     context.bloc<LikeUnlikeBloc>().add(LikeEvent(id: _data.id));
                                     Future.delayed(Duration(milliseconds: 500),(){
                                       context.bloc<DetailPostBloc>().add(UpdateDetailPost(id: widget.postModel.id));
                                       context.bloc<FollowingPostBloc>().add(UpdateFollowingPost());
                                     });

                                   },
                                 ),
                                 Text('${_data.likes.length.toString()} likes'),
                                 SizedBox(width: 10,),
                                 Icon(Icons.chat_bubble_outline),
                                 Text('${_data.comments.length} comments'),
                               ],
                             ),
                             Row(
                               children: [
                                 Text(_data.postedBy.name,style: TextStyle(fontWeight: FontWeight.bold),),
                                 SizedBox(width: 5,),
                                 Expanded(child: Text(_data.caption))
                               ],
                             )
                           ],
                         ),
                       ),
                       _data.comments.length == 0?Padding(
                         padding: EdgeInsets.only(top: 30),
                         child: Text('no comment yet',style: TextStyle(color: BaseColor.grey3,fontStyle: FontStyle.italic),),
                       ):Padding(
                         padding: const EdgeInsets.all(8.0),
                         child: Column(
                           children: _data.comments.map((e){
                             return Row(
                               children: [
                                 Container(
                                   width: 60.w,
                                   height: 60.h,
                                   decoration: BoxDecoration(
                                       shape: BoxShape.circle,
                                       image: DecorationImage(
                                           image: NetworkImage(e.postedBy.profilePic),
                                           fit: BoxFit.cover
                                       )
                                   ),
                                 ),
                                 SizedBox(width: 10,),
                                 Text(e.postedBy.name,style: TextStyle(fontWeight: FontWeight.bold),),
                                 SizedBox(width: 10,),
                                 Text(e.text),
                               ],
                             );
                           }).toList(),
                         ),
                       )
                     ],
                   ),
                   Positioned(
                       bottom: 20,
                       child: CommentForm(image: image,
                         id: _data.id,
                       ))
                 ],
               ),
             ),
           );
         }
         return Container();
        },
      ),
    );
  }
}
