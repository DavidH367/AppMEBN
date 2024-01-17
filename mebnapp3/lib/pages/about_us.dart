import 'package:flutter/material.dart';
import 'package:mebnapp3/components/nabvar.dart';

class AboutUs extends StatelessWidget {
  final PageController pageController;

  AboutUs({required this.pageController});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('About Us Page Content'),
          ],
        ),
      ),
    );
  }
}
