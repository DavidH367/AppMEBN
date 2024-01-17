import 'package:flutter/material.dart';
import 'package:mebnapp3/components/nabvar.dart';

class SettingsPage extends StatelessWidget {
  final PageController pageController;

  SettingsPage({required this.pageController});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Settings Page Content'),
          ],
        ),
      ),
    );
  }
}
