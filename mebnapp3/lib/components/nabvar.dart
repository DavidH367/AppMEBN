import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:flutter_translate/flutter_translate.dart';


class NavBar extends StatelessWidget {
  final int pageIndex;
  final Function(int) onTabChange;
  final PageController pageController;

  NavBar({required this.pageIndex, required this.onTabChange, required this.pageController});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromRGBO(20, 78, 119, 1.0),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 13.0, vertical: 6),
        child: GNav(
          backgroundColor: Color.fromRGBO(20, 78, 119, 1.0),
          color: Colors.white,
          activeColor: Colors.white,
          tabBackgroundColor: Color.fromRGBO(193, 70, 39, 1.0),
          gap: 2,
          selectedIndex: pageIndex,
          onTabChange: onTabChange,
          
          padding: EdgeInsets.all(10),
          tabs:  [
            GButton(
              icon: Icons.home,
              text: translate('app_bar.title.homepagetitle'),
              textStyle: GoogleFonts.fredoka(textStyle: TextStyle(color: Color.fromARGB(255, 255, 255, 255))),              
            ),
            GButton(
              icon: Icons.favorite,
              text: 'Ministries',
              textStyle: GoogleFonts.fredoka(textStyle: TextStyle(color: Color.fromARGB(255, 255, 255, 255))),              
            ),
            GButton(
              icon: Icons.auto_stories,
              text: 'About Us',
              textStyle: GoogleFonts.fredoka(textStyle: TextStyle(color: Color.fromARGB(255, 255, 255, 255))),              
            ),
            GButton(
              icon: Icons.settings,
              text: translate('app_bar.title.settingstitle'),
              textStyle: GoogleFonts.fredoka(textStyle: TextStyle(color: Color.fromARGB(255, 255, 255, 255))),              
            ),
          ],
        ),
      ),
    );
  }
}
