import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:petgram_mobile_app/bloc/auth_bloc/auth_bloc.dart';
import 'package:petgram_mobile_app/bloc/following_post_bloc/following_post_bloc.dart';
import 'package:petgram_mobile_app/bloc/my_profile_bloc/profile_bloc.dart';
import 'package:petgram_mobile_app/bloc/signin_bloc/sign_in_bloc.dart';
import 'package:petgram_mobile_app/constants/base_color.dart';
import 'package:petgram_mobile_app/models/following_post_model.dart';
import 'package:petgram_mobile_app/models/user_profile_model.dart';
import 'package:petgram_mobile_app/screens/profile_screen/tab_child_list/profile_photos_list.dart';

class ProfileScreen extends StatefulWidget {
  final UserDetailModel userDetail;
  bool showLogout;


  ProfileScreen({this.userDetail,this.showLogout = true});

  @override
  ProfileScreenState createState() => ProfileScreenState();
}

const avatarSize = 60.0;
const minAvatarSize = 30.0;
const extraSpace = 70.0;

class ProfileScreenState extends State<ProfileScreen> {

  bool get showLogOutButton => widget.showLogout;

  @override
  Widget build(BuildContext context) {
    final userDetail = widget.userDetail.detailModel;
    final posts = widget.userDetail.postModel;
    return Scaffold(
      body: SafeArea(
        child: DefaultTabController(
          length: 3,
          child: NestedScrollView(
            physics: BouncingScrollPhysics(),
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverPersistentHeader(
                  delegate: MyHeaderDelegate(
                    extendedHeight: kToolbarHeight + avatarSize + extraSpace,
                    petname: userDetail.petname,name:userDetail.name,profilePic: userDetail.profilePic,
                    postList: posts,showLogOutButton:showLogOutButton
                      ),
                  pinned: true,
                ),
                SliverPersistentHeader(
                  pinned: true,
                  delegate: _SliverAppBarDelegate(TabBar(
                    indicatorColor: BaseColor.purple2,
                    labelColor: BaseColor.white,
                    unselectedLabelColor: BaseColor.purple2,
                    indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: BaseColor.purple2,
                      border: Border.all(width: 1,color: BaseColor.purple2),
                    ),
                    tabs: [
                      Tab(
                        child: Column(
                          children: [
                            Text('Photos'),
                            Text('${posts.length} ')
                          ],
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                        )
                      ),Tab(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Followers'),
                            Text('${userDetail.followers.length} ')
                          ],
                        ),
                      ),Tab(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Following'),
                            Text('${userDetail.following.length} ')
                          ],
                        ),
                      ),
                    ],
                  )),
                )
              ];
            },
            body: TabBarView(
              physics: NeverScrollableScrollPhysics(),
              children: [
                ProfilePhotosList(postList: posts,),
                Center(child: Text('${userDetail.followers.length} followers',style: TextStyle(color: BaseColor.black,fontSize: 12),)),
                Center(child: Text('${userDetail.following.length} following',style: TextStyle(color: BaseColor.black,fontSize: 12),)),

              ],
            )
          ),
        ),
      ),
    );
  }
}

class MyHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double extendedHeight;
  final String name,petname,profilePic;
  final List<PostModel>postList;
  bool showLogOutButton;

  MyHeaderDelegate({this.extendedHeight,this.petname,this.name,this.profilePic,this.postList,this.showLogOutButton});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    // print("shrinkOffset: $shrinkOffset ... $overlapsContent");
    double newSize = maxExtent - shrinkOffset;
    double newSizePercent = avatarSize + extraSpace - shrinkOffset;
    double newAvatarSize = avatarSize - shrinkOffset;
    double newAvatarSpace = avatarSize - shrinkOffset;
    if (newSize < minExtent) {
      newSize = minExtent;
    }
    if (newAvatarSize < minAvatarSize) {
      newAvatarSize = minAvatarSize;
    }
    if (newAvatarSpace < 0) {
      newAvatarSpace = 0;
    }
    final percent = (newSizePercent >= 0 ? newSizePercent : 0) /
        (avatarSize + extraSpace).abs();
    double avatarXPosition = max(
        ((MediaQuery.of(context).size.width / 2) - newAvatarSize / 2) * percent,
        15);

    double actionsXPosition = 50 * (1 - percent);

    return Container(
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: kToolbarHeight + newAvatarSpace,
            child: Stack(
              children: [
                AppBar(
                  title: Text(name,style: TextStyle(color: BaseColor.black),),
                  centerTitle: false,
                  elevation: 0.0,
                  leading: IconButton(
                    icon: Icon(Icons.arrow_back_ios,color: BaseColor.black,),
                    onPressed: (){
                      Navigator.pop(context);
                    },
                  ),
                  actions: [
                    showLogOutButton?Container(
                      width: 150,
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Positioned(
                            top: 0,
                            right: actionsXPosition,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: Icon(FontAwesomeIcons.signOutAlt,color: BaseColor.black),
                                  onPressed: (){

                                    BlocProvider.of<SignInBloc>(context).add(SignOutBtnPressed());
                                    showDialog(
                                        context: context,
                                        builder: (context){
                                          print('dialog');
                                          return AlertDialog(
                                            content: Text('loading...'),
                                          );
                                        }
                                    );
                                    Future.delayed(Duration(seconds: 3),(){
                                      print('after dialog');
                                      BlocProvider.of<ProfileBloc>(context).add(ResetProfileEvent());
                                      BlocProvider.of<FollowingPostBloc>(context).add(ResetFollowingPostEvent());
                                      Navigator.pushNamedAndRemoveUntil(context, '/loginScreen', (route) => false);
                                    });
                                  },
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ):Container(),
                  ],
                  backgroundColor: Colors.transparent,
                ),
                Positioned(
                  bottom: minAvatarSize / 2,
                  right: avatarXPosition,
                  child: CircleAvatar(
                    radius: newAvatarSize / 2,
                    backgroundColor: Colors.red,
                    backgroundImage: NetworkImage(profilePic),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Opacity(
              opacity: percent,
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.person_outline),
                            SizedBox(width: 8,),
                            Text(name,
                            style: Theme.of(context).textTheme.headline4),
                          ],
                    )),
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(FontAwesomeIcons.cat),
                      SizedBox(width: 8,),
                          Text(petname,
                          style: Theme.of(context).textTheme.headline6),
                        ],
                  ),
                )
              ]),
            ),
          ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => extendedHeight;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new Container(
      color: Colors.white,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}