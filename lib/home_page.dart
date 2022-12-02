

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

import 'cart.dart';
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

String station = "";
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
            log(snapshot.error as String);
            log("got error");
          }

          if (snapshot.hasData && !snapshot.data!.exists) {
            log("no data");
          }

          if (snapshot.connectionState == ConnectionState.done) {
            log("done");
            everyDayItems = snapshot.data!.data() as Map<String, dynamic>;
          }

          try{
            return SingleChildScrollView(
                  physics: const ScrollPhysics(),
                  child: Column(
                    children: <Widget>[
                      const SizedBox(height: 50),
                      const Text("Grille:", style: TextStyle(fontSize: 30),),
                      ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: (everyDayItems["Grille"]).length,
                          itemBuilder: _getItemsForGrille),
                      const Text("Panini:", style: TextStyle(fontSize: 30),),
                      ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: (everyDayItems["Panini"]).length,
                          itemBuilder: _getItemsForPanini),
                      const Text("Slice of Life:", style: TextStyle(fontSize: 30),),
                      ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: everyDayItems["Slice of Life"].length,
                          itemBuilder: _getItemsForSliceOfLife),
                      SizedBox(height: MediaQuery.of(context).size.height*2,child: WeekItems()),


                    ],
                  ),

                );
          }
          catch(noSuchMethodError){
            log("test");
          }
          return const SizedBox(height:0);
        }

    );
  }

  Widget _getItemsForGrille(BuildContext context,int index) {
    return Tile(context, everyDayItems['Grille'],index);
  }
  Widget _getItemsForPanini(BuildContext context,int index) {
    return Tile(context, everyDayItems['Panini'],index);
  }
  Widget _getItemsForSliceOfLife(BuildContext context,int index) {
    return Tile(context, everyDayItems['Slice of Life'],index);
  }
}

class WeekItems extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    var week = getWeek()[0];
    var id = getWeek()[1];
    station = getStation();
    log("in week items");

    CollectionReference users = FirebaseFirestore.instance.collection(
        week);


    return FutureBuilder<DocumentSnapshot>(
        future: users.doc(id).get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            log("following error");
            log(snapshot.error as String);
          }

          if (snapshot.hasData && !snapshot.data!.exists) {
            log("no data");
          }

          if (snapshot.connectionState == ConnectionState.done) {
            log("done");
            weeklyItems = snapshot.data!.data() as Map<String, dynamic>;
            log(weeklyItems[getDay()].length.toString());
          }

          try{
            return Scaffold(
                body: Container(
                child: SingleChildScrollView(
                  physics: const ScrollPhysics(),
                  child: Column(
                    children: <Widget>[

                      const SizedBox(height: 50),
                      Text(getDay(), style: const TextStyle(fontSize: 30),),
                      const Text("Comfort",style: TextStyle(fontSize: 30),),

                      ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: weeklyItems[getDay()][0].length,
                          itemBuilder: _getComfort),

                      const Text("Mindful",style: TextStyle(fontSize: 30),),
                      ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: weeklyItems[getDay()][1].length,
                          itemBuilder: _getMindful),
                      const Text("Sides",style: TextStyle(fontSize: 30),),
                      ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: weeklyItems[getDay()][2].length,
                          itemBuilder: _getSides),
                      const Text("Panini:", style: TextStyle(fontSize: 30),),
                      ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: weeklyItems["Panini"].length,
                          itemBuilder: _getPanini),
                     NextButton()
                      

                    ],

                  ),
                )
                )
            );
          }
          catch(NoSuchMethodError){
            log("test");

          }


          return const Text("None");
        }

    );



  }

  Widget _getPanini(BuildContext context,int index) {
    return Tile(context, weeklyItems['Panini'],index);
  }
  Widget _getComfort(BuildContext context,int index) {
    return Tile(context, weeklyItems[getDay()][0],index);
  }
  Widget _getMindful(BuildContext context,int index) {
    return Tile(context, weeklyItems[getDay()][1],index);
  }
  Widget _getSides(BuildContext context,int index) {
    return Tile(context, weeklyItems[getDay()][2],index);
  }


  String getDay(){
    DateTime now = DateTime.now();
    switch (now.weekday){
      case DateTime.monday:
        return "Monday";
      case DateTime.tuesday:
        return "Tuesday";
      case DateTime.wednesday:
        return "Wednesday";
      case DateTime.thursday:
        return "Thursday";
      case DateTime.friday:
        return "Friday";
      default:
        return "Monday";
    }
  }
  List getWeek(){
    DateTime now = DateTime.now();
    var text = [];
    if(now.day-7<=0){
      text.add("week 1");
      text.add("GoeTLas8A4sj29bRuyw2");
    }
    else if (now.day-14<=0){
      text.add("week 2");
      text.add("JypyeLKmIyhEXlLebvHk");
    }
    else if(now.day-21<=0){
      text.add("week 3");
      text.add("NvUFdn08oieSPYfLQkU9");
    }
    else if(now.day-28<=0){
      text.add("week 4");
      text.add("YToUal6YkEc8XWndizBU");
    }
    else{
      text.add("week 1");
      text.add("GoeTLas8A4sj29bRuyw2");
    }
    return text;
  }

  String getStation(){
    String week = getWeek()[0];
    if(week == "week 1"){

      return "Mediterranean";
    }
    else if(week == "week 2"){
      return "Pasta";
    }
    else if(week == "week 3"){
      return "Burrito Bowl";
    }
    else{
      return "Macaroni and Cheese";
    }
  }
}

class Tile extends StatefulWidget{
  Map<String, dynamic> items;
  BuildContext context;
  int index;

  Tile(this.context,this.items,this.index);

  @override
  State<StatefulWidget> createState() {
    return _Tile(context,items,index);
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
        trailing: SizedBox(width: 130,child:CounterButton(index,items)),
          title: Text(items.keys.elementAt(index)),
          subtitle: Text(format.format(items.values.elementAt(index))),

    )
    );
  }
}




//var international = [];
/*
class InternationalTile extends StatefulWidget{
  Map<String, dynamic> items;
  BuildContext context;
  int index;

  InternationalTile(this.context,this.items,this.index);

  @override
  State<StatefulWidget> createState() {
    return _InternationalTile(context,items,index);
  }
}

class _InternationalTile extends State<InternationalTile>{
  @override
  BuildContext context;
  Map<String, dynamic> items;
  int index;

  _InternationalTile(this.context,this.items,this.index);

  @override
  Widget build(context){


    return Card(
        child: ListTile(
          trailing: international.contains(items.keys.elementAt(index)) ? const Icon(Icons.check_circle, color: Colors.green,) : const Icon(Icons.circle_outlined) ,
          onTap: (){
            if(international.contains(items.keys.elementAt(index))){
              removeItem();
            }
            else{
              addItem();
            }
          } ,
          title: Text(items.keys.elementAt(index)),

        )
    );
  }

  void addItem(){
    international.add(items.keys.elementAt(index));
    setState(() {

    });
  }
  void removeItem(){
    international.remove(items.keys.elementAt(index));
    setState(() {

    });
  }
}
*/
class NextButton extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    log(selected.toString());
    return ElevatedButton(
        onPressed: (){
          print(selected.toString());
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Cart()));
          },
      style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF1f5d39)),
        child: const Text("continue"),
    );

  }
  
}
class CounterButton extends StatefulWidget{

  var index;
  var items;
  CounterButton(this.index,this.items);
  @override
  State<StatefulWidget> createState() {
    return _CounterButton(index,items);
  }
}

class _CounterButton extends State<CounterButton>{
  var index;
  var items;
  _CounterButton(this.index,this.items);
  @override
  Widget build(BuildContext context) {

    var text;
    if(!selected.containsKey(items.keys.elementAt(index))){
      text = 0;
    }
    else{
      text = selected[items.keys.elementAt(index)][0];
    }

    return Container(
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
      ),

      child: Row(
        children: [
          IconButton(
            icon:   Icon(Icons.remove_circle,color: text!=0 ? const Color(0xFFc99a2c):Colors.grey,size: 20,),
            onPressed:  text!=0 ? () => subtract(items.keys.elementAt(index)) : null,

          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 3),
            padding:
            const EdgeInsets.symmetric(horizontal: 1, vertical: 2),

            child:  Text(
              text.toString(),
              style: const TextStyle(color: Colors.black, fontSize: 16),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.add_circle,color: Color(0xFFc99a2c),size: 20),
            onPressed: (){
              add(items.keys.elementAt(index),items.values.elementAt(index));
            },

          ),
        ],
      ),
    );
  }

  void subtract(String s){
    selected[s][0]--;
    if(selected[s][0]==0){
      selected.remove(s);
    }
    print(selected.toString());
    setState(() {

    });
  }
  void add(String s, var i){

    if(selected[s]!=null){
      selected[s][0]++;
    }
    else{

      selected[s] = [1,i];
    }


    setState(() {

    });
  }



}
