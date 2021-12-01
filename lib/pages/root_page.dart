import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:readingbook/constants/colors.dart';
import 'package:readingbook/pages/profile/profile.dart';
import 'package:sliding_clipped_nav_bar/sliding_clipped_nav_bar.dart';
import 'explore/explore.dart';
import 'bookmarked/bookmarked.dart';

class RootPage extends StatefulWidget {
  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int selectedIndex;
  Widget _animatedSwitcher;

  @override
  void initState() {
    super.initState();
    selectedIndex = 0;
    _animatedSwitcher = Explore();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        if (selectedIndex != 0) {
          setState(() {
            selectedIndex = 0;
          });
          _animatedSwitcher = selectedIndex == 0
              ? Explore()
              : selectedIndex == 1
                  ? Bookmarked()
                  : ProfilePage();
          return Future.value(false);
        } else {
          SystemNavigator.pop();
          return Future.value(false);
        }
      },
      child: Scaffold(
        body: AnimatedSwitcher(
          duration: Duration(milliseconds: 200),
          child: _animatedSwitcher,
        ),
        bottomNavigationBar: SlidingClippedNavBar(
          backgroundColor: ColorConstant.navBar,
          onButtonPressed: (index) {
            setState(() {
              selectedIndex = index;
            });
            _animatedSwitcher = selectedIndex == 0
                ? Explore()
                : selectedIndex == 1
                    ? Bookmarked()
                    : ProfilePage();
          },
          iconSize: 26,
          activeColor: ColorConstant.white,
          selectedIndex: selectedIndex,
          barItems: [
            BarItem(
              icon: Icons.explore,
              title: 'Explore',
            ),
            BarItem(
              icon: Icons.bookmark_add,
              title: 'Bookmarked',
            ),
            BarItem(
              icon: Icons.account_circle,
              title: 'Profile',
            ),
          ],
        ),
      ),
    );
  }

  // Widget ui() {
  //   return WillPopScope(
  //     onWillPop: () {
  //       if (selectedIndex != 0) {
  //         setState(() {
  //           selectedIndex = 0;
  //         });
  //         _animatedSwitcher = selectedIndex == 0
  //             ? Explore()
  //             : selectedIndex == 1
  //                 ? FavBook()
  //                 : ProfilePage();
  //         return Future.value(false);
  //       } else {
  //         SystemNavigator.pop();
  //         return Future.value(false);
  //       }
  //     },
  //     child: Scaffold(
  //         body: AnimatedSwitcher(
  //           duration: Duration(milliseconds: 300),
  //           child: _animatedSwitcher,
  //         ),
  //         bottomNavigationBar: BottomNavyBar(
  //           selectedIndex: selectedIndex,
  //           showElevation: true,
  //           onItemSelected: (index) => setState(() {
  //             selectedIndex = index;
  //             _animatedSwitcher = selectedIndex == 0
  //                 ? Explore()
  //                 : selectedIndex == 1
  //                     ? FavBook()
  //                     : ProfilePage();
  //           }),
  //           backgroundColor: Color.fromRGBO(36, 45, 53, 1),
  //           items: [
  //             BottomNavyBarItem(
  //               icon: Icon(Icons.explore),
  //               textAlign: TextAlign.center,
  //               title: Text('Explore'),
  //               inactiveColor: Colors.grey,
  //               activeColor: ColorConstant.purple,
  //             ),
  //             BottomNavyBarItem(
  //               icon: Icon(Icons.bookmark_border),
  //               textAlign: TextAlign.center,
  //               title: Text('Liked'),
  //               inactiveColor: Colors.grey,
  //               activeColor: ColorConstant.purple,
  //             ),
  //             BottomNavyBarItem(
  //               icon: Icon(Icons.data_usage),
  //               textAlign: TextAlign.center,
  //               title: Text('Profile'),
  //               inactiveColor: Colors.grey,
  //               activeColor: ColorConstant.purple,
  //             )
  //           ],
  //         )),
  //   );
  // }
}
