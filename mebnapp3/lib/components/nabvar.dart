import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class NavBar extends StatelessWidget {
  final int pageIndex;
  final Function(int) onTabChange;
  final PageController pageController;

  NavBar({required this.pageIndex, required this.onTabChange, required this.pageController});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 20, 39, 20),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 13.0, vertical: 11),
        child: GNav(
          backgroundColor: Color.fromARGB(255, 20, 39, 20),
          color: Colors.white,
          activeColor: Colors.white,
          tabBackgroundColor: Colors.grey.shade600,
          gap: 8,
          selectedIndex: pageIndex,
          onTabChange: onTabChange,
          padding: EdgeInsets.all(16),
          tabs: const [
            GButton(
              icon: Icons.home,
              text: 'Home',
            ),
            GButton(
              icon: Icons.favorite,
              text: 'Ministries',
            ),
            GButton(
              icon: Icons.auto_stories,
              text: 'About Us',
            ),
            GButton(
              icon: Icons.settings,
              text: 'Setting',
            ),
          ],
        ),
      ),
    );
  }
}
