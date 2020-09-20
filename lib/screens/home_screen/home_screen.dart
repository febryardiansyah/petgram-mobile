import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:like_button/like_button.dart';
import 'package:petgram_mobile_app/bloc/following_post_bloc/following_post_bloc.dart';
import 'package:petgram_mobile_app/bloc/like_unlike_bloc/like_unlike_bloc.dart';
import 'package:petgram_mobile_app/bloc/signin_bloc/sign_in_bloc.dart';
import 'package:petgram_mobile_app/components/my_custom_view.dart';
import 'package:petgram_mobile_app/constants/base_color.dart';
import 'package:petgram_mobile_app/constants/base_string.dart';
import 'package:petgram_mobile_app/helpers/shared_preferences/profile_pref.dart';
import 'package:petgram_mobile_app/models/post_models/following_post_model.dart';
import 'package:petgram_mobile_app/repositories/post_repo.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
   BlocProvider.of<FollowingPostBloc>(context)..add(FetchFollowingPost());
   BlocProvider.of<LikeUnlikeBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return MyCustomView(
        title: 'Home',
        showCreatePost: true,
        subTitle: Text('Petgram',style: TextStyle(fontFamily: BaseString.fBillabong,color: BaseColor.purple2,fontSize: 40),),
        body: BlocConsumer<FollowingPostBloc,FollowingPostState>(
          listener: (context,state){
//            print('listener <==> $state');
            if(state is FollowingPostFailure){
              Scaffold.of(context)..hideCurrentSnackBar()
                  ..showSnackBar(SnackBar(
                    content: Text('no internet'),
                  ));
            }
          },
          builder: (context,state){
            print('builder <===> $state');
            if(state is FollowingPostFailure){
              return Text(state.msg);
            }
            if (state is FollowingPostLoaded) {
              final data = state.data;
              if(state.data.postModel.length == 0){
                return Center(
                  child: Text('No Post Yet'),
                );
              }
              return PostItem(data: data,);
            }
            if(state is FollowingPostLoading){
              return Center(
                child: Text('Loading'),
              );
            }
            return Container();
          },
        )
    );
  }
}

class PostItem extends StatefulWidget {
  final FollowingPostModel data;

  PostItem({this.data});

  @override
  _PostItemState createState() => _PostItemState();
}

class _PostItemState extends State<PostItem> {

  bool _isShowLove = false;
  bool _isLiked = false;
  int _selectedIndex = 0;
  List _loveList = [];
  int _totalLikes = 0;

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    final size = MediaQuery.of(context).size;
    return ListView.separated(
      separatorBuilder: (context,i) => Divider(),
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
      itemCount: widget.data.postModel.length,
      itemBuilder: (context,i){

        final _list = widget.data.postModel[i];

//          _isLiked = _list.isLiked;
//          _totalLikes = _list.likes.length;

        _loveList.insertAll(i, [FlareActor('assets/flares/love_heart.flr',animation: _isShowLove?'Like heart':'null',fit: BoxFit.contain,)]);

        Future<bool> onLikeButtonTapped(bool isLiked) async{
          if(!_list.isLiked){
            context.bloc<LikeUnlikeBloc>().add(LikeEvent(id: _list.id));
            context.bloc<FollowingPostBloc>().add(UpdateFollowingPost());
          }else{
            context.bloc<LikeUnlikeBloc>().add(UnlikeEvent(id: _list.id));
            context.bloc<FollowingPostBloc>().add(UpdateFollowingPost());
          }
          return true;
        }

        if(widget.data.postModel.length == 0){
          return Text('No Post yet');
        }
        return Container(
          width: size.width,
          height: 900.h,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: (){
                    print(_list.postedBy.id);
                    Navigator.pushNamed(context, '/userProfile',arguments: _list.postedBy.id);
                  },
                  child: Row(
                    children: [
                      Container(
                        width: 60.w,
                        height: 60.h,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: NetworkImage(_list.postedBy.profilePic),
                            fit: BoxFit.cover
                          )
                        ),
                      ),
                      SizedBox(width: 10,),
                      Text(_list.postedBy.name),
                      Spacer(),
                      Text('${_list.createdAt}',style: TextStyle(color: BaseColor.grey2,fontSize: 10),)
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onDoubleTap: (){

                  context.bloc<LikeUnlikeBloc>().add(LikeEvent(id: _list.id));


                print('${_loveList[i]} $i');

                  setState(() {
                    _isShowLove = true;
                    _selectedIndex = i;


                });
                  Future.delayed(Duration(seconds: 3),(){
                    setState(() {
                      context.bloc<FollowingPostBloc>().add(UpdateFollowingPost());
                      _isShowLove = false;
                    });
                  });
                },
                onTap: (){
                  Navigator.pushNamed(context, '/detailPost',arguments: PostModel(
                    id: _list.id,comments: _list.comments,likes: _list.likes,
                    createdAt: _list.createdAt,postedBy: _list.postedBy,
                    imageUrl: _list.imageUrl,caption: _list.caption,isLiked: _list.isLiked
                  ));
                },
                child: Stack(
                  children: [
                    Container(
                      width: size.width,
                      height: 560.h,
                      decoration: BoxDecoration(
                        color: BaseColor.grey3,
                        image: DecorationImage(
                          image: NetworkImage(_list.imageUrl),
                          fit: BoxFit.cover
                        )
                      ),
                    ),
                    _isShowLove?i == _selectedIndex?Positioned.fill(
                      child: Center(
                        child: Container(
                          width: 130,
                          height: 130,
//                            child: Icon(Icons.favorite,size: 70,color: BaseColor.red,),
                          child: _loveList[_selectedIndex],
                        ),
                      ),
                    ):Center():Center()
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 8,top: 4),
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
                            return _list.isLiked?Icon(
                              Icons.favorite,
                              color: BaseColor.red,
                            ):Icon(Icons.favorite_border,);
                          },
                          onTap: onLikeButtonTapped,
                          likeCount: _list.likes.length,
                          countBuilder: (int count, bool isLiked, String text) {
                            var color = _list.isLiked ? Colors.deepPurpleAccent : Colors.grey;
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
//                        _list.isLiked ? GestureDetector(
//                          child: Icon(Icons.favorite,color: BaseColor.red,),
//                        onTap: (){
//
//                          context.bloc<LikeUnlikeBloc>().add(UnlikeEvent(id: _list.id));
//                          Future.delayed(Duration(milliseconds: 500));
//                          context.bloc<FollowingPostBloc>().add(UpdateFollowingPost());
//
//                        },):
//                        GestureDetector(
//                          child: Icon(Icons.favorite_border),
//                          onTap: (){
//
//                            context.bloc<LikeUnlikeBloc>().add(LikeEvent(id: _list.id));
//                            Future.delayed(Duration(milliseconds: 500),(){
//                              context.bloc<FollowingPostBloc>().add(UpdateFollowingPost());
//                            });
//
//                          },
//                        ),
//                        Text('${_list.likes.length} likes'),
                        SizedBox(width: 10,),
                        Icon(Icons.chat_bubble_outline),
                        Text('${_list.comments.length} comments'),
                      ],
                    ),
                    Row(
                      children: [
                        Text(_list.postedBy.name,style: TextStyle(fontWeight: FontWeight.bold),),
                        SizedBox(width: 5,),
                        Text(_list.caption == null ? '':_list.caption.length >= 30?_list.caption.substring(0,30)+'...':_list.caption)
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }

}

