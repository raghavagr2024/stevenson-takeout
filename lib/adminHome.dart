import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stevensontakeout/editAdminPage.dart';

import 'orderAdminPage.dart';

Map data = {};

var allEverydayCategories = ['Grille','Panini','Slice of Life','Soup'];
var allWeeklyCategories = ['Monday','Tuesday','Wednesday', 'Thursday','Friday', 'Panini','Soup'];
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
        backgroundColor: Color(0xFFc99a2c),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.featured_play_list_rounded),
            label: 'Orders',

          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.edit),
              label: 'Edit Item',
              ),
          BottomNavigationBarItem(
              icon: Icon(Icons.production_quantity_limits),
              label: 'Set Limits',
              ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xFF1f5d39),
        onTap: _onItemTapped,
      ),
      floatingActionButton:  FloatingActionButton(
          backgroundColor: const Color(0xFF1f5d39),
          onPressed: (){
              addItemDialog();
          },
          child: Icon(Icons.add)
      ),
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

  Future<void> addItemDialog() async {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    var itemName = TextEditingController();
    var itemPrice = TextEditingController();
    List tags = [];
    tags.add(collections.first);
    tags.add('Panini');
    tags.add(dayCategories[0]);

    return await showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, s) {
            return Container(
              height: 300,
              width: 300,
              child: AlertDialog(
                title: Text("Adding Item"),
                content: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      DropdownButton<String>(
                        value: tags[0],
                        elevation: 16,
                        onChanged: (String? value) {
                          // This is called when the user selects an item.

                          s(() {
                            tags[0] = value!;
                          });
                        },
                        items: collections.map<DropdownMenuItem<String>>(
                                (String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                      ),

                      if(tags[0] == 'everyday')
                        DropdownButton<String>(
                          value: tags[1],
                          elevation: 16,
                          onChanged: (String? value) {
                            // This is called when the user selects an item.

                            s(() {
                              tags[1] = value!;
                            });
                          },
                          items: allEverydayCategories.map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                        ),

                      if(tags[0] != 'everyday')
                        Container(
                          child: Column(
                            children: [
                              DropdownButton<String>(
                                value: tags[1],
                                elevation: 16,
                                onChanged: (String? value) {
                                  // This is called when the user selects an item.

                                  s(() {
                                    tags[1] = value!;
                                  });
                                },
                                items: allWeeklyCategories.map<DropdownMenuItem<String>>(
                                        (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                              ),
                              if(days.contains(tags[1]))
                                DropdownButton<String>(
                                  value: tags[2],
                                  elevation: 16,
                                  onChanged: (String? value) {
                                    // This is called when the user selects an item.

                                    s(() {
                                      tags[2] = value!;
                                    });
                                  },
                                  items: dayCategories.map<DropdownMenuItem<String>>(
                                          (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                ),
                            ],
                          ),
                        ),


                      if((tags[0] == 'everyday' && tags[1] != 'Soup') || (tags[0] != 'everyday' && tags[1] != 'Soup'))
                        Container(
                          height: 200,
                          child:
                          Column(
                            children: [
                              TextFormField(
                                decoration: InputDecoration(
                                  hintText: "Item name"
                                ),
                                validator: (value){
                                  if(value==null || value.isEmpty){
                                    return "Please enter a  name";
                                  }
                                  return null;
                                },
                                controller: itemName,
                              ),
                              TextFormField(
                                decoration: InputDecoration(
                                  hintText: "Item price"
                                ),
                                validator: (value){
                                  if(value == null || value.isEmpty){
                                    return "Please enter a price";
                                  }
                                  else{

                                  }
                                },
                                controller: itemPrice,
                              ),
                            ],
                          ),
                        )



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
                        String call = "";
                        if((tags[0]=='everyday' && tags[1] != 'Soup') || (tags[0]!='everyday' && tags[1]=='Panini')){
                          call = "${tags[0]}.${tags[1]}.${itemName.text}";
                        }
                        else if(tags[0]=='everyday' && tags[1] != 'Soup'){
                          call = "${tags[0]}.${tags[1]}.${tags[2]}.${itemName.text}";
                        }
                        FirebaseFirestore.instance
                            .collection('everyday')
                            .doc('IppA94yUj2wrIzawr5Al')
                            .update({
                          '$call':
                          double.parse(itemPrice.text.toString())
                        }).then((value) => null);

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






