import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';

class Order {
  Map foods;
  String orderTime;
  String orderLocation;
  String paymentMethod;
  int id;
  Map soups;

  Order(this.foods, this.soups, this.orderTime, this.orderLocation,
      this.paymentMethod, this.id);

  Future<void> addOrder() async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    print("in add order");
    addCount();
    return users
        .doc("SxHI0lmZHaO8r2BnwtuH/")
        .update({
          id.toString(): {
            "foods": foods,
            "soups": soups,
            "location": orderLocation,
            "time": orderTime,
            "payment method": paymentMethod
          }
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));

  }

  Future<void> addCount() async {
    Map limits = {};
    await FirebaseFirestore.instance
        .collection('limits')
        .doc("kZ5NRpx5WBxLOLwKPWwQ")
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        limits = documentSnapshot.data() as Map<dynamic, dynamic>;
      } else {
        print('Document does not exist on the database');
      }
      print("done with getData");
    });
    CollectionReference reference =
        FirebaseFirestore.instance.collection('limits');
    for (int i = 0; i < foods.length; i++) {
      if (limits.containsKey(foods.keys.elementAt(i))) {
        reference
            .doc('kZ5NRpx5WBxLOLwKPWwQ')
            .update({'${foods.keys.elementAt(i)}': limits[foods.keys.elementAt(i)]+foods[foods.keys.elementAt(i)][0]})
            .then((value) => print("User Added"))
            .catchError((error) => print("Failed to add user: $error"));
      } else {
        reference
            .doc('kZ5NRpx5WBxLOLwKPWwQ')
            .update({'${foods.keys.elementAt(i)}' : foods[foods.keys.elementAt(i)][0]})
            .then((value) => print("User Added"))
            .catchError((error) => print("Failed to add user: $error"));
      }
    }
  }
}
