import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

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

      body: (
            OrderPage()
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.featured_play_list_rounded),
            label: 'Orders',
            backgroundColor: const Color(0xFFc99a2c),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.edit),
            label: 'Edit Item',
              backgroundColor: const Color(0xFFc99a2c)
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Add Item',
              backgroundColor: const Color(0xFFc99a2c)

          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.production_quantity_limits),
            label: 'Set Limits',
              backgroundColor: const Color(0xFFc99a2c)

          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xFF1f5d39),
        onTap: _onItemTapped,
      ),
    );

  }

}

class OrderPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    DatabaseReference ref = FirebaseDatabase.instance.ref("");

// Get the Stream
    Stream<DatabaseEvent> stream = ref.onValue;

// Subscribe to the stream!
    stream.listen((DatabaseEvent event) {
      print('Event Type: ${event.type}'); // DatabaseEventType.value;
      print('Snapshot: ${event.snapshot.value}'); // DataSnapshot
    });

    return Text("hi");
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


