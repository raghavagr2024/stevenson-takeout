import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
class HomePage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return EveryDayItems();
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
          try{
            return Scaffold(
              body: SingleChildScrollView(
                physics: ScrollPhysics(),
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 30),
                  const Text("Grille:", style: TextStyle(fontSize: 30),),
                       ListView.builder(
                           physics: NeverScrollableScrollPhysics(),
                         shrinkWrap: true,
                          itemCount: items["Grille"].length,
                          itemBuilder: _getItemsForGrille),
                  const Text("Panini:", style: TextStyle(fontSize: 30),),
                      ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: items["Panini"].length,
                          itemBuilder: _getItemsForPanini),
                  const Text("Slice of Life:", style: TextStyle(fontSize: 30),),
                      ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: items["Slice of Life"].length,
                          itemBuilder: _getItemsForSliceOfLife)

                ],
              ),
              )
            );
          }
          catch(NoSuchMethodError){
            print("test");

          }
          return SizedBox(height:0);
        }

    );
  }

  Widget _getItemsForGrille(BuildContext context,int index) {
    return Tile(context, items['Grille'],index);
  }
  Widget _getItemsForPanini(BuildContext context,int index) {
    return Tile(context, items['Panini'],index);
  }
  Widget _getItemsForSliceOfLife(BuildContext context,int index) {
    return Tile(context, items['Slice of Life'],index);
  }
}

class Tile extends StatefulWidget{
  Map<String, dynamic> items;
  BuildContext context;
  int index;

  Tile(this.context,this.items,this.index);

  @override
  State<StatefulWidget> createState() {
    return _Tile(context,items,this.index);
  }
}

class _Tile extends State<Tile>{
  BuildContext context;
  Map<String, dynamic> items;
  int index;
  
  _Tile(this.context,this.items,this.index);
 
  Widget build(context){
    var format = NumberFormat.currency(symbol: "\$", decimalDigits: 2);

    return Card(
      child: ListTile(
        trailing: const CounterButton(),
          title: Text(items.keys.elementAt(index)),
          subtitle: Text(format.format(items.values.elementAt(index)))
    )
    );
  }
}


class CounterButton extends StatefulWidget{
  const CounterButton({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CounterButton();
  }
}

class _CounterButton extends State<CounterButton>{
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(3),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          ),
      width: 60,
      child: Row(
        children: [
          InkWell(
              onTap: () {},
              child: const Icon(
                Icons.remove,
                color: Colors.black,
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
              '0',
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
          ),
          InkWell(
              onTap: () {},
              child: Icon(
                Icons.add,
                color: Colors.black,
                size: 16,
              )),
        ],
      ),
    );
  }

}
