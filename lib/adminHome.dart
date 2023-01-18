import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stevensontakeout/editAdminPage.dart';

import 'orderAdminPage.dart';

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
              icon: Icon(Icons.production_quantity_limits),
              label: 'Set Limits',
              backgroundColor: Color(0xFFc99a2c)),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xFF1f5d39),
        onTap: _onItemTapped,
      ),
      floatingActionButton: const FloatingActionButton(onPressed: null, child: Icon(Icons.add)),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndDocked,
    );
  }

  Widget _getPage() {
    print("in get page");
    getData();
    if(_selectedIndex==0){
      return OrderPage();
    }
    else if(_selectedIndex==1){
      return EditPage();
    }
    return const Text("default");
  }
}






