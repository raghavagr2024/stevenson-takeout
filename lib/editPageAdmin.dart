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
      foodItems = documentSnapshot.data() as Map<dynamic, dynamic>;
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
    return Text("to do");
  }
}