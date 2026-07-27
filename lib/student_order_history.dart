import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:stevensontakeout/admin_home_page.dart';
var ans = {};
String currentStudentId = "";

Future<String> getCurrentStudentId() async {
  String id = "";
  await FirebaseFirestore.instance
      .collection('users')
      .doc('K9303KrOwITuk8itlqrg')
      .get()
      .then((DocumentSnapshot documentSnapshot) {
    if (documentSnapshot.exists) {
      Map temp = (documentSnapshot.data() as Map<dynamic, dynamic>);
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        String email = user.email.toString();
        String key = email.endsWith(".com")
            ? email.substring(0, email.length - 4)
            : email;
        if (temp[key] is Map && temp[key]['com'] != null) {
          id = temp[key]['com'].toString();
        } else if (temp[email] != null) {
          id = temp[email].toString();
        } else if (temp[key] != null) {
          id = temp[key].toString();
        }
      } else {
        print("Fatal Error: user does not exist");
      }
    } else {
      print('Document does not exist on the database');
    }
  });
  return id;
}

getOrders() async {
  print("in get orders");
  ans.clear();
  String id = await getCurrentStudentId();
  currentStudentId = id;
  if (id.isEmpty) {
    print("Could not resolve current student ID");
    return;
  }

  await FirebaseFirestore.instance
      .collection('users')
      .doc(id)
      .get()
      .then((DocumentSnapshot documentSnapshot) {
    if (documentSnapshot.exists) {
      Map temp = (documentSnapshot.data() as Map<dynamic, dynamic>);
      for (int i = 0; i < temp.length; i++) {
        if (temp.values.elementAt(i) is Map) {
          Map order = temp.values.elementAt(i);
          if (id == order["student-id"]) {
            ans[temp.keys.elementAt(i)] = order;
          }
        }
      }
    } else {
      print('Document does not exist on the database');
    }
  });
  if (ans.isEmpty) {
    await FirebaseFirestore.instance
        .collection('users')
        .doc('SxHI0lmZHaO8r2BnwtuH')
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        Map temp = (documentSnapshot.data() as Map<dynamic, dynamic>);
        for (int i = 0; i < temp.length; i++) {
          if (temp.values.elementAt(i) is Map) {
            Map order = temp.values.elementAt(i);
            if (id == order["student-id"]) {
              ans[temp.keys.elementAt(i)] = order;
            }
          }
        }
      } else {
        print('Document does not exist on the database');
      }
    });
  }
  print(ans);
}
class OrderHistory extends StatelessWidget{




  @override
  Widget build(BuildContext context) {

    print("in order page");
    print(ans.toString());
    return Scaffold(
      body: Column(
        children: [
          if (ans.isNotEmpty)
            Expanded(
              child: ListView.builder(
                itemBuilder: _getOrders,
                itemCount: ans.length,
              ),
            ),

          SizedBox(height: 40),
          if(ans.isEmpty)
            Text("No orders", style: TextStyle(fontSize: 30),),

          const SizedBox()


        ],
      ),
    ) ;


  }

  Widget _getOrders(BuildContext context, int index) {
    print("in get orders");
    return OrderTile(context, index);
  }
}

class OrderTile extends StatefulWidget {
  BuildContext context;
  int index;

  OrderTile(this.context, this.index);

  @override
  State<StatefulWidget> createState() {
    return _OrderTile(context, index);
  }
}

class _OrderTile extends State<OrderTile> {
  BuildContext context;

  int index;

  _OrderTile(this.context, this.index);

  Widget build(context) {
    print("in order tile");
    Map values = ans.values.elementAt(index);
    Map foods = values['foods'];
    Map soups = values['soups'];
    values.remove('foods');
    values.remove('soups');
    String current = "";

    for (var i = 0; i < values.length - 1; i++) {
      current += values.keys.elementAt(i) +
          ":    " +
          values.values.elementAt(i) +
          "\n";
    }
    var format = NumberFormat.currency(symbol: "\$", decimalDigits: 2);
    if(foods==null){
      current +="";
    }
    else{
      current += "foods: \n";
      for(int i = 0; i<foods.length;i++){
        current += "${foods.values.elementAt(i)[0]}   ${foods.keys.elementAt(i)}:   ${format.format(foods.values.elementAt(i)[0]*foods.values.elementAt(i)[1])}\n";
      }
    }
    if(soups==null){
      current+="";
    }
    else{
      current += "Soups: \n";
      for(int i = 0; i<soups.length;i++){
        if(soups.values.elementAt(i)[0]!=0){
          current += "${soups.values.elementAt(i)[0]}   12 oz. ${soups.keys.elementAt(i)}: ${format.format(soups.values.elementAt(i)[0]*2)}\n";
        }
        if(soups.values.elementAt(i)[1]!=0){
          current += "${soups.values.elementAt(i)[1]}   8 oz. ${soups.keys.elementAt(i)}: ${format.format(soups.values.elementAt(i)[1]*1.5)}\n";
        }
      }
    }




    return Card(
        child: Align(
          alignment: Alignment.centerLeft,
          child: Column(
            children: [
              Text(
                'Order id: ${ans.keys.elementAt(index)}',
                style: const TextStyle(fontSize: 25),
              ),
              const SizedBox(height: 20),
              ListTile(
                title: Text(current),
                trailing: IconButton(
                  onPressed: (){
                    deleteOrderDialog(index);
                  },
                  icon: Icon(Icons.highlight_remove_outlined),
                ),
              )

            ],
          ),
        ));
  }

  Future<void> deleteOrderDialog(int i) async {

    return await showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, s) {
            return Container(
              height: 300,
              width: 300,
              child: AlertDialog(
                title: Text("Deleting order for order ID :${ans.keys.elementAt(index)}"),
                content: SingleChildScrollView(
                  child: ListBody(
                    children: <Widget>[
                      Text("Deleting this order will clear it from the list")
                    ],
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                      onPressed: (){
                        Navigator.of(context).pop();
                      },
                      child: Text("Cancel")
                  ),
                  TextButton(
                      onPressed: () async {
                        String studentId = currentStudentId;
                        Map selectedOrder = ans.values.elementAt(index);
                        if (selectedOrder["student-id"] != null) {
                          studentId = selectedOrder["student-id"];
                        }
                        String documentId = studentId.isEmpty
                            ? 'SxHI0lmZHaO8r2BnwtuH'
                            : studentId;
                        await FirebaseFirestore.instance
                            .collection('users')
                            .doc(documentId)
                            .update({
                          '${ans.keys.elementAt(index)}': FieldValue.delete()
                        }).whenComplete(() {
                          print('Field Deleted');
                        });
                        print("done with delete");
                        Navigator.of(context).pop();
                        setState(() {
                          ans.remove(ans.keys.elementAt(index));
                        });
                      },
                      child: Text("Confirm")
                  ),

                ],
              ),
            );
          });
        });
  }

}