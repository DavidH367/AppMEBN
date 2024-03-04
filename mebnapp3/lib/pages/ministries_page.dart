import 'package:flutter/material.dart';

class Ministries extends StatelessWidget {
  final PageController pageController;

  Ministries({required this.pageController});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Ministries Page Content'),
          ],
        ),
      ),
    );
  }
}
