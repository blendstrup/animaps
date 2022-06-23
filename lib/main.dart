import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'data/hospital_model.dart';
import 'pages/map_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  FirebaseFirestore.instance.settings =
      Settings(cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED);

  runApp(ProviderScope(child: App()));
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Animaps',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        canvasColor: Color(0xFFF3F4F9),
        //cardColor: Colors.grey[200],
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: FutureBuilder<QuerySnapshot>(
          future:
              FirebaseFirestore.instance.collection('animal-hospitals').get(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) return Text("Something went wrong :(");
            if (snapshot.connectionState == ConnectionState.done) {
              var docs = snapshot.data!.docs;
              List<Hospital> list = docs
                  .map((DocumentSnapshot doc) => Hospital.fromMap(
                        doc.data() as Map<String, dynamic>,
                        documentID: doc.id,
                      ))
                  .toList();

              list.sort((a, b) => int.parse(a.documentID).compareTo(
                    int.parse(b.documentID),
                  ));

              return MapView(list: list);
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
