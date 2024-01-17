import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mebnapp3/pages/home_page.dart';
import 'auth_page.dart';


class MainPage extends StatelessWidget {
    final PageController _pageController = PageController();


  MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData){
            return HomePage(pageController: _pageController);
          }else{
            return AuthPage();
          }
        },
        ),
    );
  }
}