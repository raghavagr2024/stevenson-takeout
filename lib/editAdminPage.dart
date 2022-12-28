import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


Map allItems = {};
var _search = TextEditingController();
var documents = [
  'IppA94yUj2wrIzawr5Al',
  'GoeTLas8A4sj29bRuyw2',
  'JypyeLKmIyhEXlLebvHk',
  'NvUFdn08oieSPYfLQkU9',
  'YToUal6YkEc8XWndizBU'
];

var collections = ['everyday', 'week 1', 'week 2', 'week 3', 'week 4'];

var days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday'];

Future<void> getAllItems() async {
  FirebaseFirestore.instance
      .collection('everyday')
      .doc("IppA94yUj2wrIzawr5Al")
      .get()
      .then((DocumentSnapshot documentSnapshot) {
    if (documentSnapshot.exists) {
      allItems['everyday'] = documentSnapshot.data() as Map<dynamic, dynamic>;
      print(allItems.toString());
    } else {
      print('Document does not exist on the database');
    }

    print("done with getallItems");
  });
  FirebaseFirestore.instance
      .collection('week 1')
      .doc("GoeTLas8A4sj29bRuyw2")
      .get()
      .then((DocumentSnapshot documentSnapshot) {
    if (documentSnapshot.exists) {
      allItems['week 1'] = documentSnapshot.data() as Map<dynamic, dynamic>;
      print(allItems.toString());
    } else {
      print('Document does not exist on the database');
    }

    print("done with getallItems");
  });
  FirebaseFirestore.instance
      .collection('week 2')
      .doc("JypyeLKmIyhEXlLebvHk")
      .get()
      .then((DocumentSnapshot documentSnapshot) {
    if (documentSnapshot.exists) {
      allItems['week 2'] = documentSnapshot.data() as Map<dynamic, dynamic>;
      print(allItems.toString());
    } else {
      print('Document does not exist on the database');
    }

    print("done with getallItems");
  });
  FirebaseFirestore.instance
      .collection('week 3')
      .doc("NvUFdn08oieSPYfLQkU9")
      .get()
      .then((DocumentSnapshot documentSnapshot) {
    if (documentSnapshot.exists) {
      allItems['week 3'] = documentSnapshot.data() as Map<dynamic, dynamic>;
      print(allItems.toString());
    } else {
      print('Document does not exist on the database');
    }

    print("done with getallItems");
  });
  FirebaseFirestore.instance
      .collection('week 4')
      .doc("YToUal6YkEc8XWndizBU")
      .get()
      .then((DocumentSnapshot documentSnapshot) {
    if (documentSnapshot.exists) {
      allItems['week 4'] = documentSnapshot.data() as Map<dynamic, dynamic>;
      print(allItems.toString());
    } else {
      print('Document does not exist on the database');
    }

    print("done with getallItems");
  });
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
    return Column(
      children: [
        const SizedBox(
          height: 40,
        ),
        Align(
          alignment: Alignment.center,
          child: Container(
              height: 40,
              width: 380,
              color: Colors.white,
              alignment: Alignment.center,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    border: Border.all(color: Colors.grey, width: 2)),
                child: TextFormField(
                  textAlign: TextAlign.center,
                  controller: _search,
                  onFieldSubmitted: (_search) {
                    print(_search.toString());
                  },
                  decoration: const InputDecoration(
                    hintText: 'Search for an item',
                    labelStyle: TextStyle(color: Colors.greenAccent),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                  ),
                ),
              )),
        ),
        Expanded(
          child: ListView.builder(
            itemBuilder: _getEveryDayItems,
            itemCount: allItems['everyday'].length,
          ),
        )
      ],
    );
  }

  Widget _getMajorListViews(BuildContext context, index) {
    return MajorListView(context, index);
  }

  Widget _getEveryDayItems(BuildContext context, int index) {
    return EveryDayItems(context, index);
  }
}

class EveryDayItems extends StatefulWidget {
  BuildContext context;
  int category;

  EveryDayItems(this.context, this.category);

  @override
  State<StatefulWidget> createState() {
    return _EveryDayItems(this.context, this.category);
  }
}

class _EveryDayItems extends State<EveryDayItems> {
  BuildContext context;
  int category;

  _EveryDayItems(this.context, this.category);

  Map foods = allItems['everyday'];


  @override
  Widget build(context) {
    var format = NumberFormat.currency(symbol: "\$", decimalDigits: 2);
    Map currentCategory = foods.values.elementAt(category);
    print(currentCategory.toString());
    print("current category");

    return Container(
      height: currentCategory.length * 100,
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
              title: Text(currentCategory.keys.elementAt(index)),
              subtitle:
                  Text(format.format(currentCategory.values.elementAt(index))),
              trailing: Container(
                width: 100,
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          _editItemDialog(
                              currentCategory.keys.elementAt(index));
                        },
                        icon: Icon(Icons.edit)),
                    IconButton(
                        onPressed: () {
                          _deleteItemDialog(
                              currentCategory.keys.elementAt(index));
                        },
                        icon: Icon(Icons.delete))
                  ],
                ),
              ));
        },
        itemCount: currentCategory.length,
      ),
    );
  }

  Future<void> _deleteItemDialog(String s) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Delete item ${s}?"),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Deleting this item will remove it permanently'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Deny'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text(
                'Approve',
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () {
                print("in approve for delete");
                // Deletes item for everyday permanently from database
                // FirebaseFirestore.instance
                //     .collection('everyday')
                //     .doc('IppA94yUj2wrIzawr5Al')
                //     .update({
                //   '${foods.keys.elementAt(category)}.$s': FieldValue.delete()
                // }).whenComplete(() {
                //   print('Field Deleted');
                // });
                print("done with delete");
                setState(() {
                  Map currentFoods = allItems['everyday'].values.elementAt(category);
                  currentFoods.remove(s);
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _editItemDialog(String s) async {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    return await showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          TextEditingController _nameController = TextEditingController();
          TextEditingController _priceController = TextEditingController();
          _nameController.text = s;
          _priceController.text = allItems['everyday'].values.elementAt(category)[s].toString();
          String value = 'everyday';
          return StatefulBuilder(builder: (context, setStateDialog) {
            return AlertDialog(
              title: Text("Edit item ${s}?"),
              content: SingleChildScrollView(
                child: ListBody(
                  children: [
                    Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextFormField(
                            controller: _nameController,
                            decoration:
                                const InputDecoration(icon: Icon(Icons.abc)),
                            validator: (text) {
                              if (text == null || text.trim().isEmpty) {
                                return "Please enter a valid item name";
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            controller: _priceController,
                            decoration: const InputDecoration(
                                icon: Icon(Icons.attach_money)),
                            validator: (text) {
                              if (text == null) {
                                return "Empty field";
                              }
                              if (double.tryParse(text!.trim()) != null) {
                                return null;
                              }
                              return "Please enter a valid price";
                            },
                          ),
                        ],
                      ),
                    ),
                    DropdownButton(
                      value: value,
                      onChanged: (String? v) {
                        setStateDialog(() {
                          value = v!;
                        });
                      },
                      items:
                          collections.map<DropdownMenuItem<String>>((String v) {
                        return DropdownMenuItem<String>(
                          value: v,
                          child: Text(v),
                        );
                      }).toList(),
                    )
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text('Deny'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: const Text(
                    'Approve',
                    style: TextStyle(color: Colors.red),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      print("done");
                      if(s==_nameController.text&&  allItems['everyday'].values.elementAt(category)[s].toString()==_priceController.text&& value == 'everyday'){
                        Navigator.of(context).pop();
                      }
                      else if(allItems['everyday'].values.elementAt(category)[s].toString()!=_priceController.text){
                        CollectionReference db = FirebaseFirestore.instance.collection('everyday');
                        db
                            .doc('IppA94yUj2wrIzawr5Al')
                            .update({'${allItems['everyday'].keys.elementAt(category)}.$s': double.parse(_priceController.text)})
                            .then((value) => print("Price changed"))
                            .catchError((error) => print("Failed to change price: $error"));
                        setState(() {
                          print("in setstate");
                          allItems['everyday'].values.elementAt(category)[s] = double.parse(_priceController.text);
                          print(allItems['everyday'].values.elementAt(category)[s].toString());
                        });
                        Navigator.of(context).pop();
                      }

                      return;
                    }
                  },
                ),
              ],
            );
          });
        });
  }
}




class MajorListView extends StatefulWidget {
  //collection part of database
  BuildContext context;
  int index;

  MajorListView(this.context, this.index);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MajorListView(context, index);
  }
}

class _MajorListView extends State<MajorListView> {
  BuildContext context;
  int parent;

  _MajorListView(this.context, this.parent);

  @override
  Widget build(BuildContext context) {
    Map currentView = allItems[allItems.keys.elementAt(parent)];

    print("length " + currentView.length.toString());
    return Container(
        height: 200,
        child: ListView.builder(
          itemCount: currentView.length,
          itemBuilder: (context, index) {
            Map currentItems = currentView[currentView.keys.elementAt(index)];
            return ListView.builder(
              itemCount: currentItems.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(currentItems.keys.elementAt(index)),
                );
              },
            );
          },
        ));

  }
}
