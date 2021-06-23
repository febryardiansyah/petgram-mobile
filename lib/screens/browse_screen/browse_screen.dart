import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:petgram_mobile_app/bloc/all_post_bloc/all_post_bloc.dart';
import 'package:petgram_mobile_app/components/my_custom_view.dart';
import 'package:petgram_mobile_app/constants/base_color.dart';
import 'package:petgram_mobile_app/models/post_models/following_post_model.dart';

class BrowseScreen extends StatefulWidget {
  @override
  _BrowseScreenState createState() => _BrowseScreenState();
}

class _BrowseScreenState extends State<BrowseScreen> {

  Completer<void> _refreshCompleter;

  @override
  void initState() {
    super.initState();
    _refreshCompleter = Completer<void>();
    BlocProvider.of<AllPostBloc>(context).add(FetchAllPostEvent());
  }

  @override
  Widget build(BuildContext context) {
    return MyCustomView(
      title: 'Browse',
      subTitle: Text('Browse',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 40),),
      body: BlocConsumer<AllPostBloc,AllPostState>(
        listener: (context,state){
          if(state is AllPostLoaded){
            _refreshCompleter?.complete();
            _refreshCompleter = Completer();
          }
        },
        builder: (context,state){
          if(state is AllPostLoaded){
            return BrowsePostList(postList: state.allPost,refreshCompleter: _refreshCompleter,state: state,);
          }else if(state is AllPostFailure){
            return Text(state.msg);
          }else if(state is AllPostLoading){
            return Text('loading...');
          }
          return Container();
        },
      ),
    );
  }
}

class BrowsePostList extends StatefulWidget {

  final List<PostModel>postList;
  final PostModel post;
  final AllPostLoaded state;
  Completer<void> refreshCompleter;

  BrowsePostList({this.postList,this.post,this.refreshCompleter,this.state});

  @override
  _BrowsePostListState createState() => _BrowsePostListState();
}

class _BrowsePostListState extends State<BrowsePostList> {

  ScrollController _scrollController = ScrollController();

  AllPostLoaded get state => widget.state;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if(_scrollController.position.pixels == _scrollController.position.maxScrollExtent){
        BlocProvider.of<AllPostBloc>(context).add(FetchAllPostEvent());
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width,
        maxHeight: MediaQuery.of(context).size.height),
        designSize: Size(720, 1280),
        orientation: Orientation.portrait);
    return Column(
      children: [
        GestureDetector(
          onTap: ()=>Navigator.pushNamed(context, '/search'),
          child: Container(
            height: 100.h,
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.search,color: BaseColor.grey2,),
                Text('search user..',style: TextStyle(color: BaseColor.grey2,fontSize: 15),)
              ],
            ),
            decoration: BoxDecoration(
                color: BaseColor.grey1,
                border: Border.all(color: BaseColor.grey3),
                borderRadius: BorderRadius.circular(8)
            ),
          ),
        ),
        SizedBox(height: 20,),
        Expanded(
          child: RefreshIndicator(
            onRefresh: (){
              BlocProvider.of<AllPostBloc>(context).add(UpdateAllPost());
            return widget.refreshCompleter.future;
            },
            child: StaggeredGridView.countBuilder(
              controller: _scrollController,
              crossAxisCount: 4,
              itemCount: state.hasReachedMax ?widget.postList.length:widget.postList.length+1,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) =>
                  index >= state.allPost.length?Container(
                    alignment: Alignment.center,
                    child: SizedBox(
                      width: 33,height: 33,
                      child: CircularProgressIndicator(),
                    ),
                  ):GestureDetector(
                onTap: (){
                  Navigator.pushNamed(context, '/detailPost',arguments: widget.postList[index]);
                },
                child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(widget.postList[index].imageUrl),
                        fit: BoxFit.cover
                      )
                    ),

                ),
              ),
              staggeredTileBuilder: (int index) => StaggeredTile.count(2, index.isEven ? 2 : 4),
              mainAxisSpacing: 0.0,
              crossAxisSpacing: 0.0,
            ),
          ),
        )
//        RefreshIndicator(
//          onRefresh: (){
//            BlocProvider.of<AllPostBloc>(context).add(UpdateAllPost());
//            return widget.refreshCompleter.future;
//          },
//          child: GridView.builder(
//            itemCount: widget.postList.length,
//            physics: BouncingScrollPhysics(),
//            shrinkWrap: true,
//            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//              crossAxisCount: 3,crossAxisSpacing: 0,mainAxisSpacing: 0
//            ),
//            itemBuilder: (context,i){
//              return Image.network(widget.postList[i].imageUrl,fit: BoxFit.cover,);
//            },
//          ),
//        )
      ],
    );
  }
}
