import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:lhere/Constants/constants.dart';
import 'package:lhere/View/Homescreen/Pages/QuizPage/QuizPage.dart';
import 'package:lhere/View/Homescreen/Pages/homepage.dart';
import 'package:lhere/View/Homescreen/Pages/profilePage.dart';

class menu extends StatefulWidget {
  const menu({Key? key}) : super(key: key);

  @override
  _menuState createState() => _menuState();
}

class _menuState extends State<menu> {
  var _selectedTab = _SelectedTab.home;
  int _selectedIndex = 0;

  void _handleIndexChanged(int i) {
    setState(() {
      _selectedTab = _SelectedTab.values[i];
      _selectedIndex = i;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: DotNavigationBar(
          backgroundColor: Colors.white,
          currentIndex: _SelectedTab.values.indexOf(_selectedTab),
          onTap: _handleIndexChanged,
          enableFloatingNavBar: true,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              blurRadius: 5.0,
            ),
          ],
          // dotIndicatorColor: Colors.black,
          items: [
            /// Home
            DotNavigationBarItem(
              icon: const Icon(Icons.home),
              selectedColor: primarycolor,
            ),

            /// Likes
            DotNavigationBarItem(
              icon: const Icon(Icons.monetization_on_sharp),
              selectedColor: primarycolor,
            ),

            /// Profile
            DotNavigationBarItem(
              icon: const Icon(Icons.person),
              selectedColor: primarycolor,
            ),
          ],
        ),
        body: _selectedIndex == 0
            ? const homescreen()
            : _selectedIndex == 1
                ? const Quizscreen()
                : const profilescren());
  }
}

enum _SelectedTab { home, favorite, search, person }
