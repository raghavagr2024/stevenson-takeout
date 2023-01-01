import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:flutter/foundation.dart';
import 'cart.dart';
import 'main.dart';

import 'package:dropdown_button2/dropdown_button2.dart';
void createCount(){
  for(int i = 0; i<101;i++){
    count.add(i.toString());
  }
}
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: EveryDayItems(),
    );
  }
}

String station = "";
var soup1 = [0,0];
var soup2 = [0,0];

var count = [];

class EveryDayItems extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    CollectionReference users =
        FirebaseFirestore.instance.collection('everyday');

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

          try {
            print("size of screen");
            print(MediaQuery.of(context).size.height);
            return SingleChildScrollView(
              physics: const ScrollPhysics(),
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 50),
                  const Text(
                    "Grille:",
                    style: TextStyle(fontSize: 30),
                  ),
                  ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: (everyDayItems["Grille"]).length,
                      itemBuilder: _getItemsForGrille),
                  const Text(
                    "Panini:",
                    style: TextStyle(fontSize: 30),
                  ),
                  ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: (everyDayItems["Panini"]).length,
                      itemBuilder: _getItemsForPanini),
                  const Text(
                    "Slice of Life:",
                    style: TextStyle(fontSize: 30),
                  ),
                  ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: everyDayItems["Slice of Life"].length,
                      itemBuilder: _getItemsForSliceOfLife),
                  SizedBox(height: 890, child: WeekItems()),
                ],
              ),
            );
          } catch (noSuchMethodError) {
            log("test");
          }
          return const SizedBox(height: 0);
        });
  }

  Widget _getItemsForGrille(BuildContext context, int index) {
    return Tile(context, everyDayItems['Grille'], index);
  }

  Widget _getItemsForPanini(BuildContext context, int index) {
    return Tile(context, everyDayItems['Panini'], index);
  }

  Widget _getItemsForSliceOfLife(BuildContext context, int index) {
    return Tile(context, everyDayItems['Slice of Life'], index);
  }
}

class WeekItems extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    var week = getWeek()[0];
    var id = getWeek()[1];
    station = getStation();
    log("in week items");

    CollectionReference users = FirebaseFirestore.instance.collection(week);

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
            log(weeklyItems['Soup'].toString());
          }

          try {
            return Scaffold(
                body: SingleChildScrollView(
              physics: const ScrollPhysics(),
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 50),
                  Text(
                    getDay(),
                    style: const TextStyle(fontSize: 30),
                  ),
                  const Text(
                    "Comfort",
                    style: TextStyle(fontSize: 30),
                  ),
                  ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: weeklyItems[getDay()][0].length,
                      itemBuilder: _getComfort),
                  const Text(
                    "Mindful",
                    style: TextStyle(fontSize: 30),
                  ),
                  ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: weeklyItems[getDay()][1].length,
                      itemBuilder: _getMindful),
                  const Text(
                    "Sides",
                    style: TextStyle(fontSize: 30),
                  ),
                  ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: weeklyItems[getDay()][2].length,
                      itemBuilder: _getSides),
                  const Text(
                    "Panini:",
                    style: TextStyle(fontSize: 30),
                  ),
                  ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: weeklyItems["Panini"].length,
                      itemBuilder: _getPanini),
                  const Text(
                    "Soups: ",
                    style: TextStyle(fontSize: 30),
                  ),
                  ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: weeklyItems["Soup"].length,
                      itemBuilder: (BuildContext context, int index) {
                        Map soups = weeklyItems['Soup'];
                        return Card(
                            child: ListTile(
                                title: Text(soups.keys.elementAt(index)),
                                trailing: SoupTrailer(index, soups)));
                      }),
                  NextButton()
                ],
              ),
            ));
          } catch (NoSuchMethodError) {
            log("test");
          }

          return const Text("None");
        });
  }

  Widget _getPanini(BuildContext context, int index) {
    return Tile(context, weeklyItems['Panini'], index);
  }

  Widget _getComfort(BuildContext context, int index) {
    return Tile(context, weeklyItems[getDay()][0], index);
  }

  Widget _getMindful(BuildContext context, int index) {
    return Tile(context, weeklyItems[getDay()][1], index);
  }

  Widget _getSides(BuildContext context, int index) {
    return Tile(context, weeklyItems[getDay()][2], index);
  }

  String getDay() {
    DateTime now = DateTime.now();
    switch (now.weekday + 1) {
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

  List getWeek() {
    DateTime now = DateTime.now();
    var text = [];
    if (now.day - 7 <= 0) {
      text.add("week 1");
      text.add("GoeTLas8A4sj29bRuyw2");
    } else if (now.day - 14 <= 0) {
      text.add("week 2");
      text.add("JypyeLKmIyhEXlLebvHk");
    } else if (now.day - 21 <= 0) {
      text.add("week 3");
      text.add("NvUFdn08oieSPYfLQkU9");
    } else if (now.day - 28 <= 0) {
      text.add("week 4");
      text.add("YToUal6YkEc8XWndizBU");
    } else {
      text.add("week 1");
      text.add("GoeTLas8A4sj29bRuyw2");
    }
    return text;
  }

  String getStation() {
    String week = getWeek()[0];
    if (week == "week 1") {
      return "Mediterranean";
    } else if (week == "week 2") {
      return "Pasta";
    } else if (week == "week 3") {
      return "Burrito Bowl";
    } else {
      return "Macaroni and Cheese";
    }
  }
}

class Tile extends StatefulWidget {
  Map<String, dynamic> items;
  BuildContext context;
  int index;


  Tile(this.context, this.items, this.index);

  @override
  State<StatefulWidget> createState() {
    return _Tile(context, items, index);
  }
}

class _Tile extends State<Tile> {
  BuildContext context;
  Map<String, dynamic> items;
  int index;

  _Tile(this.context, this.items, this.index);

  Widget build(context) {
    var format = NumberFormat.currency(symbol: "\$", decimalDigits: 2);

    return Card(
        child: ListTile(
      trailing: SizedBox(width: 130, child: CounterButton(index, items)),
      title: Text(items.keys.elementAt(index)),
      subtitle: Text(format.format(items.values.elementAt(index))),
    ));
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
class NextButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    log(selected.toString());
    return ElevatedButton(
      onPressed: () {
        if(selectedSoups.containsKey(weeklyItems['Soup'].keys.elementAt(1))){
          selectedSoups.remove(weeklyItems['Soup'].keys.elementAt(1));
        }
        if(selectedSoups.containsKey(weeklyItems['Soup'].keys.elementAt(0))){
          selectedSoups.remove(weeklyItems['Soup'].keys.elementAt(0));
        }

        if(listEquals(soup1, [0,0]) || listEquals(soup2, [0,0])){
          print("in first if");
          if(listEquals(soup1, [0,0]) && !listEquals(soup2, [0,0])){
            print("in second if");
            selectedSoups[weeklyItems['Soup'].keys.elementAt(1)] = soup2;
          }
          else if (!listEquals(soup1, [0,0]) && listEquals(soup2, [0,0])){
            print("in else if");
            selectedSoups[weeklyItems['Soup'].keys.elementAt(0)] = soup1;
          }
        }
        else{
          print("in else");
          selectedSoups[weeklyItems['Soup'].keys.elementAt(1)] = soup2;
          selectedSoups[weeklyItems['Soup'].keys.elementAt(0)] = soup1;
        }


        print(selected.toString());
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Cart()));
      },
      style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF1f5d39)),
      child: const Text("continue"),
    );
  }
}

class CounterButton extends StatefulWidget {
  var index;
  var items;

  CounterButton(this.index, this.items);

  @override
  State<StatefulWidget> createState() {
    return _CounterButton(index, items);
  }
}

class _CounterButton extends State<CounterButton> {
  var index;
  var items;

  _CounterButton(this.index, this.items);

  @override
  Widget build(BuildContext context) {
    var text;
    if (!selected.containsKey(items.keys.elementAt(index))) {
      text = 0;
    } else {
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
            icon: Icon(
              Icons.remove_circle,
              color: text != 0 ? const Color(0xFFc99a2c) : Colors.grey,
              size: 20,
            ),
            onPressed:
                text != 0 ? () => subtract(items.keys.elementAt(index)) : null,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 3),
            padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 2),
            child: Text(
              text.toString(),
              style: const TextStyle(color: Colors.black, fontSize: 16),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.add_circle,
                color: Color(0xFFc99a2c), size: 20),
            onPressed: () {
              add(items.keys.elementAt(index), items.values.elementAt(index));
            },
          ),
        ],
      ),
    );
  }

  void subtract(String s) {
    selected[s][0]--;
    if (selected[s][0] == 0) {
      selected.remove(s);
    }
    print(selected.toString());
    setState(() {});
  }

  void add(String s, var i) {
    if (selected[s] != null) {
      selected[s][0]++;
    } else {
      selected[s] = [1, i];
    }

    setState(() {});
  }
}

class SoupTrailer extends StatefulWidget{
  var index;
  var items;
  SoupTrailer(this.index, this.items);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SoupTrailer(index,items);
  }

}

class _SoupTrailer extends State<SoupTrailer> {

  var index;
  var items;
  var dropdownValue1;
  bool checkSoup(){
    //returns true if the current soup is the first soup
    if(index==0){
      return true;
    }
    return false;
  }

  _SoupTrailer(this.index, this.items);

  @override
  Widget build(BuildContext context) {

    return Container(
      width: 250,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Tooltip(
            message: "Size: 12 oz.\nPrice: \$2.00",
            child: Text("L: "),
          ),
          const SizedBox(width: 20),
          Container(
            child: DropdownButton2<String>(
              value: checkSoup() ? soup1[0].toString():soup2[0].toString(),
              dropdownMaxHeight: 250,
              onChanged: (String? value) {
                // This is called when the user selects an item.
                setState(() {
                  if (checkSoup()){
                    soup1[0] = int.parse(value!);
                  }
                  else{
                    soup2[0] = int.parse(value!);
                  }
                  print("soup 1: ${soup1.toString()}");
                  print("soup 2: ${soup2.toString()}");
                });
              },
              items: count.map<DropdownMenuItem<String>>((var value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            )
          ),
          const SizedBox(
            width: 30,
          ),
          const Tooltip(
            message: "Size: 8 oz.\nPrice: \$1.50",
            child: Text("S: "),
          ),
          Container(
              child: DropdownButton2<String>(
                dropdownMaxHeight: 250,
                value: checkSoup() ? soup1[1].toString():soup2[1].toString(),
                onChanged: (String? value) {
                  // This is called when the user selects an item.
                  setState(() {
                    if (checkSoup()){
                      soup1[1] = int.parse(value!);
                    }
                    else{
                      soup2[1] = int.parse(value!);
                    }
                    print("soup 1: ${soup1.toString()}");
                    print("soup 2: ${soup2.toString()}");
                  });
                },
                items: count.map<DropdownMenuItem<String>>((var value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              )
          ),


        ],
      ),
    );
  }
}
