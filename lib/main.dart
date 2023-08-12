





import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:stevensontakeout/first_page.dart';
import 'package:stevensontakeout/order_class.dart';


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
  Stripe.publishableKey = 'pk_test_51NRPV1LU8oagmElpwEPTdKj8OxpZbamzV2NM4Yiw17lhl6wbfZ3ApiETA04JVNGIGbmJkwS78AfwnZNBYrlK0SAe00f80udHSe';




  await Firebase.initializeApp();
  await dotenv.load();

  runApp(MyApp());
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



