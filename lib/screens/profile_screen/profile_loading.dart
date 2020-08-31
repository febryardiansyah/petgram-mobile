import 'package:flutter/material.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';
import 'package:petgram_mobile_app/constants/base_color.dart';

class ProfileScreenLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: Icon(Icons.arrow_back_ios,color: BaseColor.black,),
      ),
      body: ProfilePageShimmer(
        hasBottomBox: true,
      )
    );
  }
}
