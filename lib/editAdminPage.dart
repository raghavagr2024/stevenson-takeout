import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

Map foodItems = {};
Future<void> getFoodItems() async {
    FirebaseFirestore.instance
      .collection('everyday')
      .doc("IppA94yUj2wrIzawr5Al")
      .get()
      .then((DocumentSnapshot documentSnapshot) {
    if (documentSnapshot.exists) {
      foodItems['everyday'] = documentSnapshot.data() as Map<dynamic, dynamic>;
      print(foodItems.toString());
    } else {
      print('Document does not exist on the database');
    }

    print("done with getFoodItems");
  });
    FirebaseFirestore.instance
        .collection('week 1')
        .doc("GoeTLas8A4sj29bRuyw2")
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        foodItems['week 1'] = documentSnapshot.data() as Map<dynamic, dynamic>;
        print(foodItems.toString());
      } else {
        print('Document does not exist on the database');
      }

      print("done with getFoodItems");
    });
    FirebaseFirestore.instance
        .collection('week 2')
        .doc("JypyeLKmIyhEXlLebvHk")
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        foodItems['week 2'] = documentSnapshot.data() as Map<dynamic, dynamic>;
        print(foodItems.toString());
      } else {
        print('Document does not exist on the database');
      }

      print("done with getFoodItems");
    });
    FirebaseFirestore.instance
        .collection('week 3')
        .doc("NvUFdn08oieSPYfLQkU9")
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        foodItems['week 3'] = documentSnapshot.data() as Map<dynamic, dynamic>;
        print(foodItems.toString());
      } else {
        print('Document does not exist on the database');
      }

      print("done with getFoodItems");
    });
    FirebaseFirestore.instance
        .collection('week 4')
        .doc("YToUal6YkEc8XWndizBU")
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        foodItems['week 4'] = documentSnapshot.data() as Map<dynamic, dynamic>;
        print(foodItems.toString());
      } else {
        print('Document does not exist on the database');
      }

      print("done with getFoodItems");
    });

}
class EditPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _EditPage();
  }
}

class _EditPage extends State<EditPage> {
  @override
  Widget build(BuildContext context) {
    return Text(foodItems.toString());
  }
}