import 'package:flutter/cupertino.dart';

class FollowersList extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      shrinkWrap: true,

    );
  }
}
