


import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:stevensontakeout/first_page.dart';
import 'package:stevensontakeout/order.dart';
//TODO: Migrate from realtime database to cloud firestore
Map<String, dynamic> everyDayItems = {};
Map selected = {};
Map selectedSoups = {};
var soup1 = {};
var soup2 = {};
bool initDone = false;
Map<String, dynamic> weeklyItems = {};
Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0.0,),
        body: FirstPage()
      ),
    );

  }
}



