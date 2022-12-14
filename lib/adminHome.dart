import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

Map data = {};

Future<void> getData() async {
  await FirebaseFirestore.instance
      .collection('users')
      .doc("SxHI0lmZHaO8r2BnwtuH")
      .get()
      .then((DocumentSnapshot documentSnapshot) {
    if (documentSnapshot.exists) {
      data = documentSnapshot.data() as Map<dynamic, dynamic>;
      print(data.toString());
    } else {
      print('Document does not exist on the database');
    }
    print("done with getData");
  });
}

class AdminPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AdminPage();
  }
}

class _AdminPage extends State<AdminPage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    getData();
    print("in main page");
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
              backgroundColor: Color(0xFFc99a2c)),
          BottomNavigationBarItem(
              icon: Icon(Icons.add),
              label: 'Add Item',
              backgroundColor: Color(0xFFc99a2c)),
          BottomNavigationBarItem(
              icon: Icon(Icons.production_quantity_limits),
              label: 'Set Limits',
              backgroundColor: Color(0xFFc99a2c)),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xFF1f5d39),
        onTap: _onItemTapped,
      ),
    );
  }

  Widget _getPage() {
    print("in get page");
    getData().then((value) => null);
    return OrderPage();
  }
}

class OrderPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("in order page");

    print(data.length);
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemBuilder: _getOrders,
            itemCount: data.length,
          ),
        )
      ],
    );
  }

  Widget _getOrders(BuildContext context, int index) {
    print("in get orders");
    return OrderTile(context, index);
  }
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
    return Text("add Page");
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
    String current = "";
    Map values = data.values.elementAt(index);
    for (var i = 0; i < values.length - 1; i++) {
      current += values.keys.elementAt(i) +
          ":    " +
          values.values.elementAt(i) +
          "\n";
    }
    Map items = values.values.elementAt(values.length - 1);

    return Card(
        child: Align(
      alignment: Alignment.centerLeft,
      child: Column(
        children: [
          Text(
            'Student id: ${data.keys.elementAt(index)}',
            style: const TextStyle(fontSize: 25),
          ),
          const SizedBox(height: 20),
          Text(current)
        ],
      ),
    ));
  }
}
