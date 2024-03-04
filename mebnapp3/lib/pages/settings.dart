import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SettingsPage extends StatefulWidget {
  final PageController pageController;
  final Future<void> Function() signOut; // Añade un parámetro para signOut aquí

  const SettingsPage(
      {Key? key, required this.pageController, required this.signOut})
      : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    //var localizationDelegate = LocalizedApp.of(context).delegate;
    return Scaffold(
      appBar: AppBar(
        title: Text(translate('app_bar.title.settingstitle')),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 20, 39, 20),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            //Text(translate('language.selected_message', args: {
            //  'language': translate(
            //      'language.name.${localizationDelegate.currentLocale.languageCode}')
            //})),
            //Padding(
            //    padding: EdgeInsets.only(top: 25, bottom: 160),
            //    child: CupertinoButton.filled(
            //      padding: const EdgeInsets.symmetric(
            //          vertical: 10.0, horizontal: 36.0),
            //      onPressed: () => _onActionSheetPress(context),
            //      child: Text(translate('button.change_language')),
            //   )),
            Padding(
              padding: EdgeInsets.only(top: 20.0), // Ajustar el padding
              child: Text('Settings Page Content'),
            ),
            Expanded(
              child: Container(),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 20.0),
              child: ElevatedButton(
                onPressed: () async {
                  FirebaseAuth.instance.signOut();
                },
                child: Text(translate('button.logout')),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void showDemoActionSheet(
    {required BuildContext context, required Widget child}) {
  showCupertinoModalPopup<String>(
      context: context,
      builder: (BuildContext context) => child).then((String? value) {
    if (value != null) changeLocale(context, value);
  });
}

void _onActionSheetPress(BuildContext context) {
  showDemoActionSheet(
    context: context,
    child: CupertinoActionSheet(
      title: Text(translate('language.selection.title')),
      message: Text(translate('language.selection.message')),
      actions: <Widget>[
        CupertinoActionSheetAction(
          child: Text(translate('language.name.en')),
          onPressed: () => Navigator.pop(context, 'en_US'),
        ),
        CupertinoActionSheetAction(
          child: Text(translate('language.name.es')),
          onPressed: () => Navigator.pop(context, 'es'),
        )
      ],
      cancelButton: CupertinoActionSheetAction(
        isDefaultAction: true,
        onPressed: () => Navigator.pop(context, null),
        child: Text(translate('button.cancel')),
      ),
    ),
  );
}
