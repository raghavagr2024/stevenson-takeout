import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class HomePage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Column(
        children: <Widget>[
            WeekText(),
          EveryDayItems(),
          Counter()

        ],
      ),
    );
  }

}
class WeekText extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String text = "";
    if(now.day-7<0){
       text = "week 1";
    }
    else if (now.day-14<0){
      text = "week 2";
    }
    else if(now.day-21<0){
      text = "week 3";
    }
    else{
      text = "week 4";
    }
    return Text(text);
  }


}

class EveryDayItems extends StatelessWidget {

  Map<String, dynamic> items = {};

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection(
        'everyday');
    Map<String, dynamic> data = {};
    String id = "IppA94yUj2wrIzawr5Al";
    return FutureBuilder<DocumentSnapshot>(
        future: users.doc(id).get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            print(snapshot.error);
          }

          if (snapshot.hasData && !snapshot.data!.exists) {
            print("no data");
          }

          if (snapshot.connectionState == ConnectionState.done) {
            items = snapshot.data!.data() as Map<String, dynamic>;
          }
          Map name = {"hi": "hi"};
          try {
            name = items["Grille"] as Map;
          }
          catch (_CastError) {
            print("error caught");
          }
          return Expanded(
            //child: ListView.builder(itemBuilder: _getItems)
              child: Text(name.keys.toString())
          );
        }

    );
  }
  }

  Widget _getItems(BuildContext context,items){
    return Tile(context,items['Grille']['Baked Curly Fries']);
  }


class Tile extends StatefulWidget{
  Map<String, dynamic> items;
  BuildContext context;

  Tile(this.context,this.items);

  @override
  State<StatefulWidget> createState() {
    return _Tile(context,items);
  }
}

class _Tile extends State<Tile>{
  BuildContext context;
  Map<String, dynamic> items;

  _Tile(this.context,this.items);

  Widget build(context){
    return Text("hi");
    // return Card(
    //   child: ListTile(
    //       trailing:
    //   )
    // )
  }
}

class Counter extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _Counter();
  }
}

class _Counter extends State<Counter>{
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(3),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: const Color(0xFF1f5d39)),
      child: Row(
        children: [
          InkWell(
              onTap: () {},
              child: Icon(
                Icons.remove,
                color: Colors.white,
                size: 16,
              )),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 3),
            padding:
            EdgeInsets.symmetric(horizontal: 3, vertical: 2),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3),
                color: Colors.white),
            child: Text(
              '3',
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
          ),
          InkWell(
              onTap: () {},
              child: Icon(
                Icons.add,
                color: Colors.white,
                size: 16,
              )),
        ],
      ),
    );
  }

}