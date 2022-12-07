import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';


Map data = {};
void getData() async {
  FirebaseFirestore.instance
      .collection('users')
      .doc("SxHI0lmZHaO8r2BnwtuH")
      .get()
      .then((DocumentSnapshot documentSnapshot) {
    if (documentSnapshot.exists) {
      data =  documentSnapshot.data() as Map<dynamic, dynamic>;
      print(data.toString());
    } else {
      print('Document does not exist on the database');
    }
  });
}


class AdminPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {

    return _AdminPage();
  }

}

class _AdminPage extends State<AdminPage>{
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: (_getPage()),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.featured_play_list_rounded),
            label: 'Orders',
            backgroundColor: Color(0xFFc99a2c),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.edit),
            label: 'Edit Item',
              backgroundColor: Color(0xFFc99a2c)
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Add Item',
              backgroundColor: Color(0xFFc99a2c)

          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.production_quantity_limits),
            label: 'Set Limits',
              backgroundColor: Color(0xFFc99a2c)

          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xFF1f5d39),
        onTap: _onItemTapped,
      ),
    );

  }

  Widget _getPage(){
    getData();
    if (_selectedIndex == 0){
      return OrderPage();
    }
    return EditPage();
  }

}

class OrderPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {


    return Expanded(
      child: Column(
        children: [
            // ListView.builder(
            //     itemBuilder: _getOrders,
            //     itemCount: data.length,
            // )
        ],
      ),
    );
  }
  // Widget _getOrders(BuildContext context,int index) {
  //
  // }



}

class EditPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {

    return _EditPage();
  }

}

class _EditPage extends State<EditPage>{
  @override
  Widget build(BuildContext context) {
    return Text("add Page");
  }

}



class OrderTile extends StatefulWidget{
  Map<String, dynamic> items;
  BuildContext context;
  int index;

 OrderTile(this.context,this.items,this.index);

  @override
  State<StatefulWidget> createState() {
    return _OrderTile(context,items,index);
  }
}

class _OrderTile extends State<OrderTile>{
  BuildContext context;
  Map<String, dynamic> items;
  int index;

  _OrderTile(this.context,this.items,this.index);

  Widget build(context){


    return Card(
        child: Column(
          children: [

          ],
        )
    );
  }
}