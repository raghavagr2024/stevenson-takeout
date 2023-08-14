import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:stevensontakeout/admin_home_page.dart';
import 'package:stevensontakeout/student_home.dart';

import 'first_page.dart';
import 'main.dart';
var ans = {};
getOrders() async {
  String id = "";
  print("in get orders");
  await FirebaseFirestore.instance
      .collection('users')
      .doc('K9303KrOwITuk8itlqrg')
      .get()
      .then((DocumentSnapshot documentSnapshot) {
    if (documentSnapshot.exists) {
      Map temp = (documentSnapshot.data() as Map<dynamic,dynamic>);
      User? user = FirebaseAuth.instance.currentUser;
      if(user!=null){
        String? key = user.email.toString().substring(0,user.email.toString().length-4);
        id = temp[key]['com'];
      }
      else{
        print("Fatal Error: user does not exist");
      }

    } else {
      print('Document does not exist on the database');
    }
  });

  await FirebaseFirestore.instance
      .collection('users')
      .doc('SxHI0lmZHaO8r2BnwtuH')
      .get()
      .then((DocumentSnapshot documentSnapshot) {
    if (documentSnapshot.exists) {
      Map temp = (documentSnapshot.data() as Map<dynamic,dynamic>);
      for(int i = 0; i<temp.length;i++){
        Map order = temp.values.elementAt(i);
        if(id==order["student-id"]){
          ans[temp.keys.elementAt(i)] = order;
        }
      }
    } else {
      print('Document does not exist on the database');
    }
  });
  print(ans);
}
class OrderHistory extends StatelessWidget{

  @override
  Widget build(BuildContext context) {

    print("in order page");
    print(ans.toString());
    return Scaffold(
      drawer: Drawer(width: 200,child: Column(
        children: [


          SizedBox(height: 50,),
          ListTile(
            title: Text("View Orders"),
            leading: Icon(Icons.account_circle),
            onTap: () async {
              await getOrders();
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => OrderHistory()));
            },
          ),
          ListTile(
            title: const Text("Create a new Order"),
            leading: const Icon(Icons.add),
            onTap: (){
              if (context.mounted) {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()));
              }
            },
          ),
          ListTile(
            title: const Text("Sign Out"),
            leading: const Icon(Icons.timer),
            onTap: () async {
              selectedSoups.clear();
              selected.clear();
              await FirebaseAuth.instance.signOut();
              print(FirebaseAuth.instance.currentUser);
              print("signed out");
              if (context.mounted) {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FirstPage()));
              }
            },
          ),


        ],
      ),
      ),
      body: Column(
        children: [
          SizedBox(height: 50,),
          DrawerButton(),
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
                        await FirebaseFirestore.instance
                            .collection('users')
                            .doc('SxHI0lmZHaO8r2BnwtuH')
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

class DrawerButton extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: IconButton(onPressed: (){
        print("in icon pressed");
        Scaffold.of(context).openDrawer();

      }, icon: Icon(Icons.menu,size: 35,)) ,
    );
  }

}