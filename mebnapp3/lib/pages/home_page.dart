import 'package:flutter/material.dart';
import 'package:mebnapp3/components/nabvar.dart';

class HomePage extends StatelessWidget {
  final PageController pageController;

  HomePage({required this.pageController});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Home Page Content'),
          ],
        ),
      ),
    );
  }
}


