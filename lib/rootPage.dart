import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'pages/home.dart';
import 'pages/explore.dart';
import 'pages/favBooks.dart';
import 'pages/profile.dart';

class RootPage extends StatefulWidget {
  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int selectedIndex;
  double w, h;
  Widget _animatedSwitcher;

  _RootPageState() {
    selectedIndex = 0;
    _animatedSwitcher = Home();
  }

  @override
  Widget build(BuildContext context) {
    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;
    return Scaffold(
        body: AnimatedSwitcher(
          duration: Duration(milliseconds: 500),
          child: _animatedSwitcher,
        ),
        bottomNavigationBar: BottomNavyBar(
          selectedIndex: selectedIndex,
          showElevation: true, // use this to remove appBar's elevation
          onItemSelected: (index) => setState(() {
            selectedIndex = index;
            _animatedSwitcher = selectedIndex == 0
                ? Home()
                : selectedIndex == 1
                    ? Explore()
                    : selectedIndex == 2 ? FavBook() : Profile();
          }),
          // iconSize: w * 0.05,
          // containerHeight: h * 0.06,
          backgroundColor: Color.fromRGBO(36, 45, 53, 1),
          items: [
            BottomNavyBarItem(
              icon: Icon(Icons.home),
              title: Text('Home'),
              inactiveColor: Colors.grey,
              activeColor: Color.fromRGBO(167, 117, 139, 1),
            ),
            BottomNavyBarItem(
              icon: Icon(Icons.explore),
              title: Text('Explore'),
              inactiveColor: Colors.grey,
              activeColor: Color.fromRGBO(167, 117, 139, 1),
            ),
            BottomNavyBarItem(
              icon: Icon(Icons.bookmark_border),
              title: Text('Liked'),
              inactiveColor: Colors.grey,
              activeColor: Color.fromRGBO(167, 117, 139, 1),
            ),
            BottomNavyBarItem(
              icon: Icon(Icons.data_usage),
              title: Text('Profile'),
              inactiveColor: Colors.grey,
              activeColor: Color.fromRGBO(167, 117, 139, 1),
            )
          ],
        ));
  }
}
