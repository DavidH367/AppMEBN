import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mebnapp3/components/nabvar.dart';
import 'package:mebnapp3/pages/about_us.dart';
import 'package:mebnapp3/pages/home_page.dart';
import 'package:mebnapp3/pages/login_page.dart';
import 'package:mebnapp3/pages/ministries_page.dart';
import 'package:mebnapp3/pages/settings.dart';
import 'firebase_options.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_translate/src/widgets/localized_app.dart';


//import 'login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  var delegate = await LocalizationDelegate.create(
        fallbackLocale: 'en_US',
        preferences: TranslatePreferences(),
        supportedLocales: ['en_US', 'es']
      );

  runApp(LocalizedApp(
    delegate,
    MaterialApp(
      localizationsDelegates: [
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: delegate.supportedLocales,
      home: MyApp(),
    ),
  ));
}

class TranslatePreferences implements ITranslatePreferences {
  static const String _selectedLocaleKey = 'selected_locale';

  @override
  Future<Locale> getPreferredLocale() async {
    final preferences = await SharedPreferences.getInstance();

    if (!preferences.containsKey(_selectedLocaleKey)) {
      // Manejar el caso en que no se encuentra la clave
      // Puedes devolver una Locale predeterminada o lanzar una excepción
      return Locale('en', 'US'); // Por ejemplo, inglés como predeterminado
    }

    var locale = preferences.getString(_selectedLocaleKey);

    return localeFromString(locale!); // Asegúrate de que locale no sea nulo
  }

  @override
  Future savePreferredLocale(Locale locale) async {
    final preferences = await SharedPreferences.getInstance();

    await preferences.setString(_selectedLocaleKey, localeToString(locale));
  }
}


class MyApp extends StatelessWidget {
  final PageController _pageController = PageController();

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

   @override
  Widget build(BuildContext context) {

    return MaterialApp(
        home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
          if (snapshot.hasData) {
            // Si hay un usuario autenticado, muestra la página principal
            return Scaffold(
              body: PageView(
                physics: NeverScrollableScrollPhysics(), // Deshabilita el deslizamiento
                controller: _pageController,
                children: [
                  HomePage(
                    pageController: _pageController,
                  ),
                  Ministries(
                    pageController: _pageController,
                  ),
                  AboutUs(
                    pageController: _pageController,
                  ),
                  SettingsPage(pageController: _pageController, signOut: signOut),

                  // ... otras páginas
                ],
              ),
              bottomNavigationBar: NavBar(
                pageIndex: 0, // Establece el índice inicial según sea necesario
                onTabChange: (index) {
                  // Maneja el cambio de pestaña según sea necesario
                  _pageController.animateToPage(index,
                      duration: Duration(milliseconds: 300), curve: Curves.ease);
                },
                pageController: _pageController,
              ),
            );
          } else {
            // Si no hay un usuario autenticado, muestra la página de inicio de sesión
            return LoginPage(
              showRegisterPage: () {
                // Aquí va tu código para mostrar la página de registro
              },
            );
          }
        },
      ),
    );
  }
}
