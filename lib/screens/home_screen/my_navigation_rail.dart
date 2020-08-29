import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:petgram_mobile_app/constants/base_color.dart';
import 'package:petgram_mobile_app/helpers/shared_preferences/profile_pref.dart';
import 'package:petgram_mobile_app/screens/browse_screen/browse_screen.dart';
import 'package:petgram_mobile_app/screens/login_screen/login_screen.dart';

import 'home_screen.dart';

class MyNavigationRail extends StatefulWidget {
  @override
  _MyNavigationRailState createState() => _MyNavigationRailState();
}

class _MyNavigationRailState extends State<MyNavigationRail> {
  int _selectedIndex = 0;
  String _profilePic = '';
  List<Widget> _childern = [
    HomeScreen(),
    BrowseScreen(),
    BrowseScreen(),
  ];
  _setPic()async{
    String savedPic = await ProfilePreference.getProfile();
    setState(() {
      _profilePic = savedPic;
    });
  }
  @override
  void initState() {
    super.initState();
    _setPic();
  }
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return Scaffold(
      body: SafeArea(
        child: Row(
          children: <Widget>[
            NavigationRail(
              trailing: Padding(
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.width /2),
                child: GestureDetector(
                  onTap: (){},
                  child: Icon(Icons.settings,color: BaseColor.white,),
                ),
              ),
              leading: GestureDetector(onTap: () {print('tap');}, child: Container(
                margin: EdgeInsets.all(8),
                width: 30,height: 50,decoration: BoxDecoration(
                color: BaseColor.grey1,
                shape: BoxShape.circle,
//                image: DecorationImage(image: NetworkImage(_profilePic),fit: BoxFit.cover)
              ),
              )),
              selectedIndex: _selectedIndex,
              onDestinationSelected: (int index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              labelType: NavigationRailLabelType.selected,
              backgroundColor: BaseColor.purple2,
              selectedIconTheme: IconThemeData(color: BaseColor.white),
              unselectedIconTheme: IconThemeData(color: BaseColor.grey1),
              destinations: [
                NavigationRailDestination(
                  icon: Icon(Icons.home),
                  selectedIcon: Icon(FontAwesomeIcons.home),
                  label: Text(''),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.search),
                  selectedIcon: Icon(FontAwesomeIcons.search),
                  label: Text(''),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.notifications_none),
                  selectedIcon: Icon(Icons.notifications),
                  label: Text(''),
                ),
              ],
            ),
            VerticalDivider(thickness: 1, width: 1),
            // This is the main content.
            Expanded(
              child: Center(
                child: IndexedStack(
                 index: _selectedIndex,
                  children: _childern,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
