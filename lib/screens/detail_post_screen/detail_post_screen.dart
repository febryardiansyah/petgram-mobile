import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:like_button/like_button.dart';
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
  GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  String image = 'https://res.cloudinary.com/febryar/image/upload/v1600259749/post/2020-09-16T12:35:47.303Z.jpg';
  bool _isShowLove = false;

  _getImageLink()async{
    String img = await ProfilePreference.getProfile();
    image = img;
  }

  @override
  void initState() {
    super.initState();
    _getImageLink();
    BlocProvider.of<DetailPostBloc>(context).add(FetchDetailPost(id: post.id));
    BlocProvider.of<PostCommentBloc>(context);
    BlocProvider.of<LikeUnlikeBloc>(context);

  }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    ScreenUtil.init(context);
    return Scaffold(
      key: _key,
      body: BlocConsumer<DetailPostBloc,DetailPostState>(
        listener: (context,state){
          if(state is DetailPostFailure){
            _key.currentState.showSnackBar(
              SnackBar(content: Text('Something wrong, i can feel it'),)
            );
          }
        },
        builder:(context,state){
          if(state is DetailPostLoading){
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
              body: Center(child: Text('Loading...'),),
            );
          }
          if(state is DetailPostLoaded){
            final _data = state.detailPost.post;
            return Scaffold(
                floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
                floatingActionButton: Container(height: 50,color: BaseColor.white,
                  child: CommentForm(id: _data.id,image: image,),),
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
                body: ListView(
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
                          child: BlocListener<LikeUnlikeBloc,LikeUnlikeState>(
                            listener: (context,state){
                              print('like state $state');
                              if(state is LikeSuccess || state is UnlikeSuccess){
                                BlocProvider.of<DetailPostBloc>(context).add(UpdateDetailPost(id: _data.id));
                                BlocProvider.of<FollowingPostBloc>(context).add(UpdateFollowingPost());
                              }
                              if(state is LikeFailure || state is UnlikeFailure){
                                BlocProvider.of<DetailPostBloc>(context).add(UpdateDetailPost(id: _data.id));
                                BlocProvider.of<FollowingPostBloc>(context).add(UpdateFollowingPost());
                                _key.currentState.showSnackBar(SnackBar(
                                  content: Text('Check Your Internet Connection !!'),
                                ));
                              }
                            },
                            child: Wrap(
                              children: [
                                Row(
                                  children: [
                                    LikeButton(
                                      circleColor: CircleColor(start: Color(0xff00ddff), end: Color(0xff0099cc)),
                                      bubblesColor: BubblesColor(
                                        dotPrimaryColor: Color(0xff33b5e5),
                                        dotSecondaryColor: Color(0xff0099cc),
                                      ),
                                      likeBuilder: (bool isLiked) {
                                        return _data.isLiked?Icon(
                                          Icons.favorite,
                                          color: BaseColor.red,
                                        ):Icon(Icons.favorite_border,);
                                      },
                                      onTap: (bool isLiked)async{
                                        if(!_data.isLiked){
                                          context.bloc<LikeUnlikeBloc>().add(LikeEvent(id: _data.id));

                                        }else{
                                          context.bloc<LikeUnlikeBloc>().add(UnlikeEvent(id: _data.id));

                                        }
                                        return true;
                                      },
                                      likeCount: _data.likes.length,
                                      countBuilder: (int count, bool isLiked, String text) {
                                        var color = _data.isLiked ? Colors.deepPurpleAccent : Colors.grey;
                                        Widget result;
                                        if (count == 0) {
                                          result = Text(
                                            "0 likes",
                                            style: TextStyle(color: color),
                                          );
                                        } else
                                          result = Text(
                                            '$text likes',
                                            style: TextStyle(color: color),
                                          );
                                        return result;
                                      },
                                    ),
//                                Text('${_data.likes.length.toString()} likes'),
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
                        ),
                        _data.comments.length == 0?Padding(
                          padding: EdgeInsets.only(top: 30),
                          child: Text('no comment yet',style: TextStyle(color: BaseColor.grey3,fontStyle: FontStyle.italic),),
                        ):Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: BouncingScrollPhysics(),
                            itemCount: _data.comments.length,
                            itemBuilder: (context,i){
                              return !_data.comments[i].isCommentByMe?
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 10.0),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 60.w,
                                      height: 60.h,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                              image: NetworkImage(_data.comments[i].postedBy.profilePic),
                                              fit: BoxFit.cover
                                          )
                                      ),
                                    ),
                                    SizedBox(width: 10,),
                                    Text(_data.comments[i].postedBy.name,style: TextStyle(fontWeight: FontWeight.bold),),
                                    SizedBox(width: 10,),
                                    Expanded(child: Text(_data.comments[i].text)),
                                  ],
                                ),
                              ):Slidable(
                                 actionPane: SlidableDrawerActionPane(),
                                 secondaryActions: <Widget>[
                                   IconSlideAction(
                                     caption: 'Delete',
                                     color: Colors.red,
                                     icon: Icons.delete,
                                     onTap: (){
                                       context.bloc<PostCommentBloc>().add(DeleteCommentEvent(
                                         id: _data.id,commentId: _data.comments[i].id
                                       ));
                                       Future.delayed(Duration(milliseconds: 500),(){
                                         context.bloc<DetailPostBloc>().add(UpdateDetailPost(id: _data.id));
                                         context.bloc<FollowingPostBloc>().add(UpdateFollowingPost());
                                       });
                                     },
                                   ),
                                 ],
                                 child: Padding(
                                   padding: EdgeInsets.symmetric(vertical: 10.0),
                                   child: Row(
                                     children: [
                                       Container(
                                         width: 60.w,
                                         height: 60.h,
                                         decoration: BoxDecoration(
                                             shape: BoxShape.circle,
                                             image: DecorationImage(
                                                 image: NetworkImage(_data.comments[i].postedBy.profilePic),
                                                 fit: BoxFit.cover
                                             )
                                         ),
                                       ),
                                       SizedBox(width: 10,),
                                       Text(_data.comments[i].postedBy.name,style: TextStyle(fontWeight: FontWeight.bold),),
                                       SizedBox(width: 10,),
                                       Expanded(child: Text(_data.comments[i].text)),
                                       Spacer(),
                                       Icon(Icons.arrow_back_ios)
                                     ],
                                   ),
                                 ),
                               );
                            },
                          ),
                        )
                      ],
                    ),

                  ],
                )
            );
          }
          return Container();
        },
      ),
    );
  }
}
