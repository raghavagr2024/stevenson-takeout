import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

import 'main.dart';
class HomePage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: EveryDayItems(),
    );
  }

}
Map<String, dynamic> items = {};
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



  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection(
        'everyday');

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
                  const SizedBox(height: 50),
                  const Text("Grille:", style: TextStyle(fontSize: 30),),
                       ListView.builder(
                           physics: const NeverScrollableScrollPhysics(),
                         shrinkWrap: true,
                          itemCount: (items["Grille"]).length,
                          itemBuilder: _getItemsForGrille),
                  const Text("Panini:", style: TextStyle(fontSize: 30),),
                      ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: (items["Panini"]).length,
                          itemBuilder: _getItemsForPanini),
                  const Text("Slice of Life:", style: TextStyle(fontSize: 30),),
                      ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
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
        trailing: SizedBox(width: 130,child:CounterButton(index,this.items)),
          title: Text(this.items.keys.elementAt(index)),
          subtitle: Text(format.format(this.items.values.elementAt(index))),

    )
    );
  }
}


class CounterButton extends StatefulWidget{

  var index;
  var items;
  CounterButton(this.index,this.items);
  @override
  State<StatefulWidget> createState() {
    return _CounterButton(this.index,this.items);
  }
}

class _CounterButton extends State<CounterButton>{
  var index;
  var items;
  _CounterButton(this.index,this.items);
  @override
  Widget build(BuildContext context) {

    var text;
    if(!selected.containsKey(this.items.keys.elementAt(index))){
      text = 0;
    }
    else{
      text = selected[this.items.keys.elementAt(index)];
    }

    return Container(
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          ),

      child: Row(
        children: [
          IconButton(
            icon:   Icon(Icons.remove_circle,color: text!=0 ? Color(0xFFc99a2c):Colors.grey,size: 20),
            onPressed:  text!=0 ? () => subtract(this.items.keys.elementAt(index)) : null,

          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 3),
            padding:
            const EdgeInsets.symmetric(horizontal: 1, vertical: 2),

            child:  Text(
              text.toString(),
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.add_circle,color: Color(0xFFc99a2c),size: 20),
            onPressed: (){
              add(this.items.keys.elementAt(index));
            },

          ),
        ],
      ),
    );
  }

  void subtract(String s){
    selected[s]--;
    if(selected[s]==0){
      selected.remove(s);
    }
    
    setState(() {

    });
  }
  void add(String s){
    if(selected[s]!=null){
      selected[s]++;
    }
    else{
      selected[s] = 1;
    }
    
    setState(() {

    });
  }



}
