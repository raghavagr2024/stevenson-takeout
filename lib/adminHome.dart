import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';


Map data = {};
void _getData() async {
  DatabaseReference ref = FirebaseDatabase.instance.ref("");
  final snapshot = await ref.child("").get();
  if(snapshot.exists){
    data = snapshot.value as Map;
  }
  else{
    print("an error occurred");
  }
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
    if(_selectedIndex == 0){
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
            ListView.builder(
                itemBuilder: _getOrders,
                itemCount: data.length,
            )
        ],
      ),
    );
  }
  Widget _getOrders(BuildContext context,int index) {
  }



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

class OrderTile extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Card(

    )
  }

}
