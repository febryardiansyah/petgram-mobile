import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:petgram_mobile_app/bloc/following_post_bloc/following_post_bloc.dart';
import 'package:petgram_mobile_app/bloc/like_unlike_bloc/like_unlike_bloc.dart';
import 'package:petgram_mobile_app/constants/base_color.dart';
import 'package:petgram_mobile_app/helpers/shared_preferences/profile_pref.dart';
import 'package:petgram_mobile_app/models/following_post_model.dart';
import 'package:petgram_mobile_app/screens/detail_post_screen/comment_form.dart';

class DetailPostScreen extends StatefulWidget {
  final PostModel postModel;

  DetailPostScreen({this.postModel});

  @override
  _DetailPostScreenState createState() => _DetailPostScreenState();
}

class _DetailPostScreenState extends State<DetailPostScreen> {
  PostModel get post => widget.postModel;

  String image = '';

  _getImageLink()async{
    String img = await ProfilePreference.getProfile();
    setState(() {
      image = img;
    });
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<FollowingPostBloc>(context)..add(FetchFollowingPost());
    BlocProvider.of<LikeUnlikeBloc>(context);
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
          Center(child: Text('${post.createdAt} ago',style: TextStyle(color: BaseColor.grey2,fontSize: 12),))
        ],
      ),
      body: BlocBuilder<FollowingPostBloc,FollowingPostState>(
        builder:(context,state)=> SingleChildScrollView(
          child: Container(
            width: size.width,
            height: size.height*0.9,
            child: Stack(
              children: [
//            Container(
//              width: size.width,
//              height: size.height,
//            ),
                Column(
                  children: [
                    Container(
                      width: size.width,
                      height: 700.h,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(post.imageUrl),
                              fit: BoxFit.cover
                          )
                      ),
                    ),
                    SizedBox(width: 10,),
                    Padding(
                      padding: EdgeInsets.only(left: 8,top: 4),
                      child: Wrap(
                        children: [
                          Row(
                            children: [
                              post.isLiked ?GestureDetector(
                                child: Icon(Icons.favorite,color: BaseColor.red,),
                                onTap: (){

                                  context.bloc<LikeUnlikeBloc>().add(UnlikeEvent(id: post.id));
                                  context.bloc<FollowingPostBloc>().add(UpdateFollowingPost());

                                },):GestureDetector(
                                child: Icon(Icons.favorite_border),
                                onTap: (){

                                  context.bloc<LikeUnlikeBloc>().add(LikeEvent(id: post.id));
                                  context.bloc<FollowingPostBloc>().add(UpdateFollowingPost());

                                },
                              ),
                              Text('${post.likes.length.toString()} likes'),
                              SizedBox(width: 10,),
                              Icon(Icons.chat_bubble_outline),
                              Text('${post.comments.length} comments'),
                            ],
                          ),
                          Row(
                            children: [
                              Text(post.postedBy.name,style: TextStyle(fontWeight: FontWeight.bold),),
                              SizedBox(width: 5,),
                              Expanded(child: Text(post.caption))
                            ],
                          )
                        ],
                      ),
                    ),
                    post.comments.length == 0?Padding(
                      padding: EdgeInsets.only(top: 30),
                      child: Text('no comment yet',style: TextStyle(color: BaseColor.grey3,fontStyle: FontStyle.italic),),
                    ):Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: post.comments.map((e){
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
                      child: CommentForm(image: image,))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
