import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:petgram_mobile_app/bloc/all_post_bloc/all_post_bloc.dart';
import 'package:petgram_mobile_app/components/my_custom_view.dart';
import 'package:petgram_mobile_app/constants/base_color.dart';
import 'package:petgram_mobile_app/models/following_post_model.dart';

class BrowseScreen extends StatefulWidget {
  @override
  _BrowseScreenState createState() => _BrowseScreenState();
}

class _BrowseScreenState extends State<BrowseScreen> {

  @override
  void initState() {
    super.initState();
    BlocProvider.of<AllPostBloc>(context).add(FetchAllPostEvent());

  }

  @override
  Widget build(BuildContext context) {
    return MyCustomView(
      title: 'Browse',
      subTitle: Text('Browse',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 40),),
      body: BlocBuilder<AllPostBloc,AllPostState>(
        builder: (context,state){
          if(state is AllPostLoaded){
            return BrowsePostList(posts: state.allPostModel.allPost,);
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

class BrowsePostList extends StatelessWidget {
  final List<PostModel>posts;

  BrowsePostList({this.posts});

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return Column(
      children: [
        GestureDetector(
          onTap: (){},
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
          child: StaggeredGridView.countBuilder(
            crossAxisCount: 4,
            itemCount: posts.length,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) => Container(
                decoration: BoxDecoration(

                  image: DecorationImage(
                    image: NetworkImage(posts[index].imageUrl),
                    fit: BoxFit.cover
                  )
                ),

            ),
            staggeredTileBuilder: (int index) =>
            StaggeredTile.count(2, index.isEven ? 3 : 1),
            mainAxisSpacing: 4.0,
            crossAxisSpacing: 4.0,
          ),
        )
//        GridView.builder(
//          itemCount: posts.length,
//          shrinkWrap: true,
//          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//            crossAxisCount: 3,crossAxisSpacing: 0,mainAxisSpacing: 0
//          ),
//          itemBuilder: (context,i){
//            return Image.network(posts[i].imageUrl);
//          },
//        )
      ],
    );
  }
}
