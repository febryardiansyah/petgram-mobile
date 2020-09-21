import 'package:flutter/material.dart';
import 'package:petgram_mobile_app/constants/base_color.dart';
import 'package:shimmer/shimmer.dart';

class FollowingPostShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: BaseColor.grey1,
        highlightColor: BaseColor.grey2,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: 2,
          itemBuilder:(context,i)=> Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.all(8),
                width: 60,
                height: 10,
                decoration: BoxDecoration(
                    color: BaseColor.red,
                    borderRadius: BorderRadius.circular(20)
                ),
              ),
              Container(
                margin: EdgeInsets.all(8),
                width: MediaQuery.of(context).size.width,
                height: 150,
                decoration: BoxDecoration(
                    color: BaseColor.red,
                    borderRadius: BorderRadius.circular(20)
                ),
              ),
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.all(8),
                    width: 60,
                    height: 10,
                    decoration: BoxDecoration(
                        color: BaseColor.red,
                        borderRadius: BorderRadius.circular(20)
                    ),
                  ),
                  SizedBox(width: 10,),
                  Container(
                    margin: EdgeInsets.all(8),
                    width: 60,
                    height: 10,
                    decoration: BoxDecoration(
                        color: BaseColor.red,
                        borderRadius: BorderRadius.circular(20)
                    ),
                  ),
                ],
              )
            ],
          ),
        )
    );
  }
}
