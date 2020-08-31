import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:petgram_mobile_app/constants/base_color.dart';

class ProfileScreen extends StatelessWidget {
  final String name, profilePic, petname;

  ProfileScreen({this.name, this.profilePic, this.petname});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    ScreenUtil.init(context);
    return Scaffold(
      body: DefaultTabController(
        length: 3,
        child: NestedScrollView(
          physics: BouncingScrollPhysics(),
          headerSliverBuilder: (context,bool isScrolled) {
            return [
              SliverAppBar(
                expandedHeight: 200.0,
                centerTitle: true,
                pinned: true,
                leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: BaseColor.black,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                title: Text(
                  name,
                  style: TextStyle(color: BaseColor.black),
                ),
                backgroundColor: Colors.white,
                flexibleSpace: FlexibleSpaceBar(
                    centerTitle: true,
                    title: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                              color: BaseColor.grey2,
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: NetworkImage(profilePic),
                                  fit: BoxFit.cover)),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(name,style: TextStyle(color: BaseColor.black),),
                            Text(petname,style: TextStyle(color: BaseColor.black),),
                          ],
                        )
                      ],
                    )),
              ),
              SliverPersistentHeader(
                pinned: true,
                delegate: __SliverAppBarDelegate(
                  TabBar(
                    labelColor: BaseColor.red,
                    unselectedLabelColor: BaseColor.grey3,
                    tabs: [
                      Tab(
                        icon: Icon(Icons.arrow_back_ios),
                      ),
                      Tab(
                        icon: Icon(Icons.arrow_back_ios),
                      ),
                      Tab(
                        icon: Icon(Icons.arrow_back_ios),
                      ),
                    ],
                  ),
                ),
              )
            ];
          },
          body: TabBarView(
            children: [
              Center(child: Text('1')),
              Text('2'),
              Text('3'),
            ],
          ),
        ),
      ),
    );
  }
}

class __SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar _tabBar;

  __SliverAppBarDelegate(this._tabBar);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      child: _tabBar,
    );
  }

  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  double get minExtent => _tabBar.preferredSize.height;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
