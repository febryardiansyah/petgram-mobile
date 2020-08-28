import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:petgram_mobile_app/constants/base_color.dart';
import 'package:petgram_mobile_app/constants/base_string.dart';

class MyCustomView extends StatefulWidget {
  final Widget body;
  final String title;
  final Widget subTitle;

  MyCustomView({this.body,this.title,this.subTitle});

  @override
  _MyCustomViewState createState() => _MyCustomViewState();
}

class _MyCustomViewState extends State<MyCustomView> {
  ScrollController _controller = ScrollController();
  bool _scroll = false;
  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      if(_controller.position.userScrollDirection == ScrollDirection.forward){
        setState(() {
          _scroll = false;
        });
      }else if (_controller.position.userScrollDirection == ScrollDirection.reverse) {
        setState(() {
          _scroll = true;
        });
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return NestedScrollView(
      controller: _controller,
      physics: BouncingScrollPhysics(),
      headerSliverBuilder:(context,bool isScrolled) => [
        SliverAppBar(
          centerTitle: true,
//          elevation: _scroll?4:0,
          expandedHeight: 250.h,
          stretch: true,
          leading: _scroll?Icon(FontAwesomeIcons.cat,color: BaseColor.purple2,):null,
          title: Text(_scroll?widget.title:'',style: TextStyle(color: BaseColor.black,fontWeight: FontWeight.bold),),
          pinned: true,
          floating: false,
          backgroundColor:Colors.white,
          flexibleSpace: FlexibleSpaceBar(
            background: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: widget.subTitle,
              ),
            ),
          ),
        )
      ],
      body: widget.body,
    );
  }
}
