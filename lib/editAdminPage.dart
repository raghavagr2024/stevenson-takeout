import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

Map foodItems = {};
var _search = TextEditingController();

Future<void> getFoodItems() async {
  FirebaseFirestore.instance
      .collection('everyday')
      .doc("IppA94yUj2wrIzawr5Al")
      .get()
      .then((DocumentSnapshot documentSnapshot) {
    if (documentSnapshot.exists) {
      foodItems['everyday'] = documentSnapshot.data() as Map<dynamic, dynamic>;
      print(foodItems.toString());
    } else {
      print('Document does not exist on the database');
    }

    print("done with getFoodItems");
  });
  FirebaseFirestore.instance
      .collection('week 1')
      .doc("GoeTLas8A4sj29bRuyw2")
      .get()
      .then((DocumentSnapshot documentSnapshot) {
    if (documentSnapshot.exists) {
      foodItems['week 1'] = documentSnapshot.data() as Map<dynamic, dynamic>;
      print(foodItems.toString());
    } else {
      print('Document does not exist on the database');
    }

    print("done with getFoodItems");
  });
  FirebaseFirestore.instance
      .collection('week 2')
      .doc("JypyeLKmIyhEXlLebvHk")
      .get()
      .then((DocumentSnapshot documentSnapshot) {
    if (documentSnapshot.exists) {
      foodItems['week 2'] = documentSnapshot.data() as Map<dynamic, dynamic>;
      print(foodItems.toString());
    } else {
      print('Document does not exist on the database');
    }

    print("done with getFoodItems");
  });
  FirebaseFirestore.instance
      .collection('week 3')
      .doc("NvUFdn08oieSPYfLQkU9")
      .get()
      .then((DocumentSnapshot documentSnapshot) {
    if (documentSnapshot.exists) {
      foodItems['week 3'] = documentSnapshot.data() as Map<dynamic, dynamic>;
      print(foodItems.toString());
    } else {
      print('Document does not exist on the database');
    }

    print("done with getFoodItems");
  });
  FirebaseFirestore.instance
      .collection('week 4')
      .doc("YToUal6YkEc8XWndizBU")
      .get()
      .then((DocumentSnapshot documentSnapshot) {
    if (documentSnapshot.exists) {
      foodItems['week 4'] = documentSnapshot.data() as Map<dynamic, dynamic>;
      print(foodItems.toString());
    } else {
      print('Document does not exist on the database');
    }

    print("done with getFoodItems");
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
          itemBuilder: _getMajorListViews,
          itemCount: foodItems.length,
        ))
      ],
    );
  }

  Widget _getMajorListViews(BuildContext context, index) {
    return MajorListView(context, index);
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
    Map currentView = foodItems[foodItems.keys.elementAt(parent)];

    print("length " + currentView.length.toString());
    return Container(
        height: 200,
        child: ListView.builder(
          itemCount: currentView.length,
          itemBuilder: (context, index) {
            Map currentItems = currentView[currentView.keys.elementAt(index)];
            return ListView.builder(
                itemCount: currentItems.length,
                itemBuilder: (context,index){
                  return ListTile(
                    title: Text(currentItems.keys.elementAt(index)),
                  );
                },
                
            );
          },
        )
    );
    return Text(currentView.length.toString());
  }
}
