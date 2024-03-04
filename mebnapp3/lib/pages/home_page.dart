import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:getwidget/getwidget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Variables para almacenar los valores del título y la descripción
String titleText = '';
String descriptionText = '';

class HomePage extends StatelessWidget {
  final PageController pageController;

  HomePage({required this.pageController});

  @override
  Widget build(BuildContext context) {
    Future<DocumentSnapshot<Map<String, dynamic>>> fetchData() async {
      // Aquí colocarías el código para obtener los datos de Firestore
      // Por ejemplo:
      final documentSnapshot = await FirebaseFirestore.instance
          .collection('news')
          .doc('YgrUJWdCklOxA7G4uHQr')
          .get();
      return documentSnapshot;
    }

    final Widget emptyBlock = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: 100,
            color: Colors.white,
          ),
          SizedBox(height: 8), // Agrega un espacio entre los contenedores
          Container(
            width: MediaQuery.of(context).size.width * 0.5,
            height: 8,
            color: Colors.white,
          ),
        ],
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(translate('app_bar.title.homepagetitle')),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 20, 39, 20),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              GFCard(
                boxFit: BoxFit.cover,
                titlePosition: GFPosition.start,
                title: GFListTile(
                  titleText: 'Agua Pura Project',
                  icon: Icon(Icons.favorite),
                ),
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GFImageOverlay(
                      height: 200,
                      width: 400,
                      boxFit: BoxFit.cover,
                      borderRadius: BorderRadius.all(Radius.circular(6.0)),
                      image: AssetImage("assets/images/Aguapura6.jpg"),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 8.0, horizontal: 6.0),
                      child: Text(
                        'Thanks be to God, the follow-ups of the water filters are an opportunity to always share the gospel in San Jose de Pane.',
                        style: TextStyle(fontSize: 14.0),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8),
              FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                future: fetchData(),
                builder: (BuildContext context,
                    AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>>
                        snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else {
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      // Asigna los valores a las variables del título y la descripción
                      titleText = snapshot.data!['new_title'];
                      descriptionText = snapshot.data!['description'];

                      // Devuelve el widget deseado (puede ser un contenedor vacío)
                      return GFCard(
                        boxFit: BoxFit.cover,
                        titlePosition: GFPosition.start,
                        title: GFListTile(
                          titleText: titleText,
                          icon: Icon(Icons.favorite),
                        ),
                        content: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GFImageOverlay(
                              height: 200,
                              width: 400,
                              boxFit: BoxFit.cover,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(6.0)),
                              image: AssetImage("assets/images/Aguapura6.jpg"),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 6.0),
                              child: Text(
                                descriptionText,
                                style: TextStyle(fontSize: 14.0),
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                  }
                },
              ),
              SizedBox(height: 8),
              GFShimmer(
                child: emptyBlock,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
