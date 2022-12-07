import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';

class Order {
  Map foods;
  String orderTime;
  String orderLocation;
  String paymentMethod;
  int id;

  Order(this.foods, this.orderTime, this.orderLocation, this.paymentMethod,
      this.id);

  Future<void> addOrder() async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    print("in add order");
    return users.doc("SxHI0lmZHaO8r2BnwtuH/").update({
      id.toString(): {"items":foods,"location":orderLocation,"time":orderTime,"payment method":paymentMethod}
        }
    ).then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }
}
