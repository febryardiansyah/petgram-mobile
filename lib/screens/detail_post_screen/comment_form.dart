import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:petgram_mobile_app/constants/base_color.dart';

class CommentForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Container(
            width: 80.w,
            height: 80.h,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: BaseColor.grey3
//                image: DecorationImage(
//                    image: NetworkImage(post.postedBy.profilePic),
//                    fit: BoxFit.cover
//                )
            ),
          ),
          SizedBox(width: 10,),
          Container(
            width: 700.w,
            height: 100.h,
            child: TextFormField(
              maxLines: 10,
              decoration: InputDecoration(
                hintText: 'enter comment..',
                fillColor: BaseColor.grey1,
                filled: true,
//                focusedBorder: OutlineInputBorder(
//                    borderSide: BorderSide(color: BaseColor.grey2,width: 1),
//                    borderRadius: BorderRadius.all(Radius.circular(8))
//                ),
              ),
            ),
          ),
          SizedBox(width: 10,),
          Container(
            decoration: BoxDecoration(
              color: BaseColor.grey1,
              borderRadius: BorderRadius.all(Radius.circular(8)),
              border: Border.all(width: 1,color: BaseColor.grey2),
            ),
            child: Center(
              child: IconButton(
                icon: Icon(Icons.send,color: BaseColor.red,),
              ),
            ),
          )
        ],
      ),
    );
  }
}
