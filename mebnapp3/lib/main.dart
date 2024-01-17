import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mebnapp3/components/nabvar.dart';
import 'package:mebnapp3/pages/about_us.dart';
import 'package:mebnapp3/pages/home_page.dart';
import 'package:mebnapp3/pages/ministries_page.dart';
import 'package:mebnapp3/pages/settings.dart';
import 'firebase_options.dart';
//import 'login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final PageController _pageController = PageController();
   
  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: PageView(
          controller: _pageController,
          children: [
            HomePage(pageController: _pageController,),
            Ministries(pageController: _pageController,),
            AboutUs(pageController: _pageController,),
            SettingsPage(pageController: _pageController,),

            // ... otras páginas
          ],
        ),
        bottomNavigationBar: NavBar(
          pageIndex: 0, // Establece el índice inicial según sea necesario
          onTabChange: (index) {
            // Maneja el cambio de pestaña según sea necesario
            _pageController.animateToPage(index, duration: Duration(milliseconds: 300), curve: Curves.ease);
          },
          pageController: _pageController,
        ),
      ),
    );
  }
}
