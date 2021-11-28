import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:readingbook/constants/colors.dart';
import 'home.dart';
import 'explore.dart';
import 'favBooks.dart';
import 'profile.dart';

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
    return Scaffold(
      body: AnimatedSwitcher(
        duration: Duration(milliseconds: 300),
        child: _animatedSwitcher,
      ),
      bottomNavigationBar: SlidingClippedNavBar(
        backgroundColor: Colors.white,
        onButtonPressed: (index) {
          setState(() {
            selectedIndex = index;
          });
          _animatedSwitcher = selectedIndex == 0
              ? Explore()
              : selectedIndex == 1
                  ? FavBook()
                  : Profile();
          // controller.animateToPage(selectedIndex,
          //     duration: const Duration(milliseconds: 400), curve: Curves.easeOutQuad);
        },
        iconSize: 30,
        activeColor: Color(0xFF01579B),
        selectedIndex: selectedIndex,
        barItems: [
          BarItem(
            icon: Icons.event,
            title: 'Events',
          ),
          BarItem(
            icon: Icons.search_rounded,
            title: 'Search',
          ),

          /// Add more BarItem if you want
        ],
      ),
    );
  }

  Widget ui() {
    return WillPopScope(
      onWillPop: () {
        if (selectedIndex != 0) {
          setState(() {
            selectedIndex = 0;
          });
          _animatedSwitcher = selectedIndex == 0
              ? Explore()
              : selectedIndex == 1
                  ? FavBook()
                  : Profile();
          return Future.value(false);
        } else {
          SystemNavigator.pop();
          return Future.value(false);
        }
      },
      child: Scaffold(
          body: AnimatedSwitcher(
            duration: Duration(milliseconds: 300),
            child: _animatedSwitcher,
          ),
          bottomNavigationBar: BottomNavyBar(
            selectedIndex: selectedIndex,
            showElevation: true,
            onItemSelected: (index) => setState(() {
              selectedIndex = index;
              _animatedSwitcher = selectedIndex == 0
                  ? Explore()
                  : selectedIndex == 1
                      ? FavBook()
                      : Profile();
            }),
            backgroundColor: Color.fromRGBO(36, 45, 53, 1),
            items: [
              BottomNavyBarItem(
                icon: Icon(Icons.explore),
                textAlign: TextAlign.center,
                title: Text('Explore'),
                inactiveColor: Colors.grey,
                activeColor: ColorConstant.purple,
              ),
              BottomNavyBarItem(
                icon: Icon(Icons.bookmark_border),
                textAlign: TextAlign.center,
                title: Text('Liked'),
                inactiveColor: Colors.grey,
                activeColor: ColorConstant.purple,
              ),
              BottomNavyBarItem(
                icon: Icon(Icons.data_usage),
                textAlign: TextAlign.center,
                title: Text('Profile'),
                inactiveColor: Colors.grey,
                activeColor: ColorConstant.purple,
              )
            ],
          )),
    );
  }
}
