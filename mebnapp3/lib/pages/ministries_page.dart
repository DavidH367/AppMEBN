import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:getwidget/getwidget.dart';
import 'package:carousel_slider/carousel_slider.dart';

// Variables para almacenar los valores del título y la descripción
String titleText = '';
String descriptionText = '';

class Ministries extends StatelessWidget {
  final PageController pageController;

  Ministries({required this.pageController});

  Future<QuerySnapshot<Map<String, dynamic>>> fetchLatestNews() {
    return FirebaseFirestore.instance
        .collection('ministries')
        .orderBy('start_year', descending: true)
        .get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(40.0), // Ajusta este valor según tu preferencia
        child: AppBar(
          title: Text(translate('app_bar.title.ministriespageTitle')),
          centerTitle: true,
          backgroundColor: Color.fromRGBO(20, 78, 119, 1.0),
        ),
      ),
      body: SingleChildScrollView(
  child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
        future: fetchLatestNews(),
        builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else {
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              List<Widget> newsCards = []; // Create an empty list to hold widgets
              for (var doc in snapshot.data!.docs) {
                String titleText = doc['ministry_name'];
                String descriptionText = doc['description'];
                String logoUrl = doc['logo_url'];
                // ... (rest of your code to fetch image URLs)

                // Create the ListTile widget outside the loop
                newsCards.add(
                  Card(
                    elevation: 12,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    color: Color.fromARGB(255, 20, 78, 119),
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(20),
                            topLeft: Radius.circular(20),
                          ),
                          child: Image.network(
                            logoUrl,
                            height: 300,
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                        ),
                        ListTile(
                          title: Text(titleText),
                          subtitle: Text(
                            descriptionText,
                            style: TextStyle(
                              color: Color.fromARGB(255, 214, 213, 213),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextButton(
                                  style: TextButton.styleFrom(
                                    backgroundColor: Colors.white,
                                  ),
                                  onPressed: () {
                                    // Add your button press logic here
                                    print('Learn More button pressed for $titleText');
                                  },
                                  child: const Text(
                                    "Learn More",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }

              return Column(children: newsCards); // Return the list of widgets
            }
          }
        },
      ),
    ],
  ),
),

    );
  }
}
