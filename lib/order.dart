import 'package:firebase_database/firebase_database.dart';

class Order{
   Map foods;
   String orderTime;
   String orderLocation;
   String paymentMethod;
   int id;
  Order(this.foods, this.orderTime, this.orderLocation, this.paymentMethod,this.id);

  Future<void> addOrder() async {
    DatabaseReference ref = FirebaseDatabase.instance.ref(id.toString());
    await ref.set({
      "items": foods,
      "time": orderTime,
      "location" : orderLocation,
      "payment method": paymentMethod
    });
    print("done");
  }

}