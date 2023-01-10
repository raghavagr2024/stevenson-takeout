import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stevensontakeout/cart.dart';
import 'package:stevensontakeout/main.dart';

//TODO: add search ability
Map temp = {};
Map allItems = {};
Map displayItems = {};
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

  print("in getAllItems");
  await FirebaseFirestore.instance
      .collection('everyday')
      .doc("IppA94yUj2wrIzawr5Al")
      .get()
      .then((DocumentSnapshot documentSnapshot) {
    if (documentSnapshot.exists) {
      temp = documentSnapshot.data() as Map<dynamic, dynamic>;
      for(int i = 0; i<temp.length;i++){
        Map currentCategory = temp.values.elementAt(i);
        for(int j = 0; j<currentCategory.length;j++){

          String key = currentCategory.keys.elementAt(j);
          String collection = "everyday";
          String category = temp.keys.elementAt(i);
          var price = currentCategory.values.elementAt(j);
          var data = [collection,category,price];
          allItems[key] = data;
        }
      }
    } else {
      print('Document does not exist on the database');
    }

  });
  await FirebaseFirestore.instance
      .collection('week 1')
      .doc("GoeTLas8A4sj29bRuyw2")
      .get()
      .then((DocumentSnapshot documentSnapshot) {
    if (documentSnapshot.exists) {
      temp = documentSnapshot.data() as Map<dynamic, dynamic>;
      for(int i = 0; i<temp.length;i++){
        var currentCategory = temp.values.elementAt(i);

        if(temp.keys.elementAt(i)=='Panini'){
          String key = currentCategory.keys.elementAt(0);
          String collection = 'week 1';
          String category = 'Panini';
          var price = currentCategory.values.elementAt(0);
          allItems[key] = [collection,category,price];
        }
        else if(temp.keys.elementAt(i)=='Soup'){

          for(int j = 0; j<currentCategory.length;j++){
            Map soup = currentCategory.values.elementAt(j);
            String key = currentCategory.keys.elementAt(j);
            String collection = 'week 1';
            String category = 'Soup';
            var data = [];
            data.add(collection);
            data.add(category);
            for(int k = 0; k<soup.length;k++ ){
              data.add(soup.keys.elementAt(k));
              data.add(soup.values.elementAt(k));
            }
            allItems[key] = data;
          }
        }
        else{
          for(int j = 0; j<currentCategory.length;j++){
            String collection = 'week 1';
            String category = temp.keys.elementAt(i);
            String tag = currentCategory.keys.elementAt(j);
            for(int k = 0; k<currentCategory.values.elementAt(j).length;k++){
              String key = currentCategory.values.elementAt(j).keys.elementAt(k);
              var price = currentCategory.values.elementAt(j).values.elementAt(k);
              allItems[key] = [collection,category,tag,price];
            }
          }
        }
      }

    } else {
      print('Document does not exist on the database');
    }

    print("week 1");
  });
  await FirebaseFirestore.instance
      .collection('week 2')
      .doc("JypyeLKmIyhEXlLebvHk")
      .get()
      .then((DocumentSnapshot documentSnapshot) {
    if (documentSnapshot.exists) {
      temp = documentSnapshot.data() as Map<dynamic, dynamic>;
      for(int i = 0; i<temp.length;i++){
        var currentCategory = temp.values.elementAt(i);
        if(temp.keys.elementAt(i)=='Panini'){
          String key = currentCategory.keys.elementAt(0);
          String collection = 'week 2';
          String category = 'Panini';
          var price = currentCategory.values.elementAt(0);
          allItems[key] = [collection,category,price];
        }
        else if(temp.keys.elementAt(i)=='Soup'){

          for(int j = 0; j<currentCategory.length;j++){
            Map soup = currentCategory.values.elementAt(j);
            String key = currentCategory.keys.elementAt(j);
            String collection = 'week 2';
            String category = 'Soup';
            var data = [];
            data.add(collection);
            data.add(category);
            for(int k = 0; k<soup.length;k++ ){
              data.add(soup.keys.elementAt(k));
              data.add(soup.values.elementAt(k));
            }
            allItems[key] = data;
          }
        }
        else{
          for(int j = 0; j<currentCategory.length;j++){
            String collection = 'week 2';
            String category = temp.keys.elementAt(i);
            String tag = currentCategory.keys.elementAt(j);
            for(int k = 0; k<currentCategory.values.elementAt(j).length;k++){
              String key = currentCategory.values.elementAt(j).keys.elementAt(k);
              var price = currentCategory.values.elementAt(j).values.elementAt(k);
              allItems["$key "] = [collection,category,tag,price];
            }
          }
        }
      }


    } else {
      print('Document does not exist on the database');
    }

    print("done with 2");
  });
  await FirebaseFirestore.instance
      .collection('week 3')
      .doc("NvUFdn08oieSPYfLQkU9")
      .get()
      .then((DocumentSnapshot documentSnapshot) {
    if (documentSnapshot.exists) {
      temp = documentSnapshot.data() as Map<dynamic, dynamic>;
      for(int i = 0; i<temp.length;i++){
        var currentCategory = temp.values.elementAt(i);

        if(temp.keys.elementAt(i)=='Panini'){
          String key = currentCategory.keys.elementAt(0);
          String collection = 'week 3';
          String category = 'Panini';
          var price = currentCategory.values.elementAt(0);
          allItems[key] = [collection,category,price];
        }
        else if(temp.keys.elementAt(i)=='Soup'){

          for(int j = 0; j<currentCategory.length;j++){
            Map soup = currentCategory.values.elementAt(j);
            String key = currentCategory.keys.elementAt(j);
            String collection = 'week 3';
            String category = 'Soup';
            var data = [];
            data.add(collection);
            data.add(category);
            for(int k = 0; k<soup.length;k++ ){
              data.add(soup.keys.elementAt(k));
              data.add(soup.values.elementAt(k));
            }
            allItems[key] = data;
          }
        }
        else{
          for(int j = 0; j<currentCategory.length;j++){
            String collection = 'week 3';
            String category = temp.keys.elementAt(i);
            String tag = currentCategory.keys.elementAt(j);
            for(int k = 0; k<currentCategory.values.elementAt(j).length;k++){
              String key = currentCategory.values.elementAt(j).keys.elementAt(k);
              var price = currentCategory.values.elementAt(j).values.elementAt(k);
              allItems["$key  "] = [collection,category,tag,price];
            }
          }
        }
      }

    } else {
      print('Document does not exist on the database');
    }

    print("done with 3");
  });
  await FirebaseFirestore.instance
      .collection('week 4')
      .doc("YToUal6YkEc8XWndizBU")
      .get()
      .then((DocumentSnapshot documentSnapshot) {
    if (documentSnapshot.exists) {
      temp = documentSnapshot.data() as Map<dynamic, dynamic>;
      for(int i = 0; i<temp.length;i++){
        var currentCategory = temp.values.elementAt(i);

        if(temp.keys.elementAt(i)=='Panini'){
          String key = currentCategory.keys.elementAt(0);
          String collection = 'week 4';
          String category = 'Panini';
          var price = currentCategory.values.elementAt(0);
          allItems[key] = [collection,category,price];
        }
        else if(temp.keys.elementAt(i)=='Soup'){

          for(int j = 0; j<currentCategory.length;j++){
            Map soup = currentCategory.values.elementAt(j);
            String key = currentCategory.keys.elementAt(j);
            String collection = 'week 4';
            String category = 'Soup';
            var data = [];
            data.add(collection);
            data.add(category);
            for(int k = 0; k<soup.length;k++ ){
              data.add(soup.keys.elementAt(k));
              data.add(soup.values.elementAt(k));
            }
            allItems[key] = data;
          }
        }
        else{
          for(int j = 0; j<currentCategory.length;j++){
            String collection = 'week 4';
            String category = temp.keys.elementAt(i);
            String tag = currentCategory.keys.elementAt(j);
            for(int k = 0; k<currentCategory.values.elementAt(j).length;k++){
              String key = currentCategory.values.elementAt(j).keys.elementAt(k);
              var price = currentCategory.values.elementAt(j).values.elementAt(k);
              allItems["$key   "] = [collection,category,tag,price];
            }
          }
        }
      }
    print('week 4');
    } else {
      print('Document does not exist on the database');
    }


    displayItems = allItems;

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
                  onChanged: (_search){
                    setState(() {
                      _getSearchedList(_search);
                    });
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
              itemBuilder: getItemCard,
              itemCount: displayItems.length,
            )

        )

      ],
    );
  }

  Widget getItemCard(BuildContext context, int index){
    print("in get itemCard");
    return ItemCard(context,index);
  }



  void _getSearchedList(String s){
    displayItems = {};
    for(int i = 0; i<allItems.length;i++){
      if(allItems.keys.elementAt(i).toUpperCase().contains(s.toUpperCase())){
        displayItems[allItems.keys.elementAt(i)] = allItems.values.elementAt(i);
      }
    }

    print(displayItems.toString());



  }
}

class ItemCard extends StatefulWidget{

  BuildContext context;
  int index;


  ItemCard(this.context,this.index);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ItemCard(context, index);
  }

}

class _ItemCard extends State<ItemCard>{

  BuildContext context;
  int index;

  _ItemCard(this.context,this.index);
  @override
  Widget build(BuildContext context) {
    var format = NumberFormat.currency(symbol: "\$", decimalDigits: 2);
    List itemData = displayItems.values.elementAt(index);
      return Card(
        child: ListTile(
          title: Text(displayItems.keys.elementAt(index)),
          subtitle: Text(itemData[0]),
          trailing: Container(
            width: 100,
            child: Row(
              children: [
                IconButton(
                    onPressed: (){
                      _editItemDialog(index);
                    },
                    icon: Icon(Icons.edit)
                ),
                IconButton(
                    onPressed: (){
                      _deleteItemDialog(index);
                    },
                    icon: Icon(Icons.delete)
                )
              ],
            ),
          ),
        )
      );



  }

  Future<void> _deleteItemDialog(int i) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Delete item ${displayItems.keys.elementAt(i)}?"),
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
                List itemData = displayItems.values.elementAt(i);
                int docIndex = 0;
                for(int j = 0 ;j<collections.length;j++){
                  if(collections[j]==itemData[0]){
                    docIndex = j;
                    break;
                  }
                }
                if(itemData.length == 3){
                  FirebaseFirestore.instance
                      .collection(displayItems.values.elementAt(i)[0])
                      .doc(documents[docIndex])
                      .update({
                    '${itemData[1]}.${displayItems.keys.elementAt(i)}': FieldValue.delete()
                  }).whenComplete(() {
                    print('Field Deleted');

                  });
                  print("done with delete");
                  setState(() {
                    allItems.remove(displayItems.keys.elementAt(i));
                    displayItems.remove(displayItems.keys.elementAt(i));
                  });
                }
                else if(itemData.length == 4){
                  String key = displayItems.keys.elementAt(i).trim();
                  print("key");
                  FirebaseFirestore.instance
                      .collection(displayItems.values.elementAt(i)[0])
                      .doc(documents[docIndex])
                      .update({
                    '${itemData[1]}.${itemData[2]}.$key': FieldValue.delete()
                  }).whenComplete(() {
                    print('Field Deleted');

                  });
                  print("done with delete");
                  setState(() {
                    allItems.remove(displayItems.keys.elementAt(i));
                    displayItems.remove(displayItems.keys.elementAt(i));
                  });

                }



                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  Future<void> _editItemDialog(int index) async{

  }


}

