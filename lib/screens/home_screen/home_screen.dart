import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:petgram_mobile_app/bloc/following_post_bloc/following_post_bloc.dart';
import 'package:petgram_mobile_app/bloc/signin_bloc/sign_in_bloc.dart';
import 'package:petgram_mobile_app/components/my_custom_view.dart';
import 'package:petgram_mobile_app/constants/base_color.dart';
import 'package:petgram_mobile_app/constants/base_string.dart';
import 'package:petgram_mobile_app/helpers/shared_preferences/profile_pref.dart';
import 'package:petgram_mobile_app/models/following_post_model.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<FollowingPostBloc>(context)..add(FetchFollowingPost());
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignInBloc,SignInState>(
      builder:(context,loginState)=> MyCustomView(
        title: 'Home',
//        subTitle: Text('Petgram',style: TextStyle(fontFamily: BaseString.fBillabong,color: BaseColor.purple2,fontSize: 40),),
      subTitle: IconButton(
        icon: Icon(Icons.arrow_back_ios),
        onPressed: (){
          context.bloc<SignInBloc>().add(SignOutBtnPressed());
        },
      ),
        body: BlocBuilder<FollowingPostBloc,FollowingPostState>(
          builder: (context,state){
            print(state);
            if(state is FollowingPostFailure){
              return Text(state.msg);
            }
            if (state is FollowingPostLoaded) {
              final data = state.data;
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
      )
    );
  }
}
class PostItem extends StatelessWidget {
  final FollowingPostModel data;

  PostItem({this.data});

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    final size = MediaQuery.of(context).size;
    return ListView.separated(
      separatorBuilder: (context,i) => Divider(),
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
      itemCount: data.postModel.length,
      itemBuilder: (context,i){
        final _list = data.postModel[i];
        if(data.postModel.length == 0){
          return Text('No Post yet');
        }
        return Container(
          width: size.width,
          height: 900.h,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
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
                    Text('${_list.createdAt} ago',style: TextStyle(color: BaseColor.grey2,fontSize: 10),)
                  ],
                ),
              ),
              GestureDetector(
                onTap: (){
                  Navigator.pushNamed(context, '/detailPost',arguments: PostModel(
                    id: _list.id,comments: _list.comments,likes: _list.likes,
                    createdAt: _list.createdAt,postedBy: _list.postedBy,
                    imageUrl: _list.imageUrl,caption: _list.caption
                  ));
                },
                child: Container(
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
              ),
              Padding(
                padding: EdgeInsets.only(left: 8,top: 4),
                child: Wrap(
                  children: [
                    Row(
                      children: [
                        _list.isLiked?Icon(Icons.favorite,color: BaseColor.red,):Icon(Icons.favorite_border),
                        Text('${_list.likes.length.toString()} likes'),
                        SizedBox(width: 10,),
                        Icon(Icons.chat_bubble_outline),
                        Text('${_list.comments.length} comments'),
                      ],
                    ),
                    Row(
                      children: [
                        Text(_list.postedBy.name,style: TextStyle(fontWeight: FontWeight.bold),),
                        SizedBox(width: 5,),
                        Text(_list.caption.length >= 30?_list.caption.substring(0,30)+'...':_list.caption)
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

