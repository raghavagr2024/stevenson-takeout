import 'dart:developer';

import 'package:flutter/material.dart';

import 'main.dart';


var periods = ["4A (11:10 - 11:30)", "4B (11:37 - 11:57)","5A (12:02-12:22)", "5B (12:02 - 12:22)", "6A (12:45 - 1:14)"];
var selectedPeriod, selectedLocation;
var total = 0;
var locations = ["East Commons", "West Commons"];
class Cart extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    log("in build");
    log(selected.toString());
    return Scaffold(
      body: Column(
        children: <Widget>[
          SizedBox(height: 100,),
          Row(
            children: <Widget>[
              Text("item"),
              SizedBox(width: 50),
              Text("Price"),
              SizedBox(width: 50,),
              Text("amount"),
              SizedBox(width: 50,),
              Text("total")
            ],
          ),
          Expanded(
              child: ListView.builder(
                itemCount: selected.length-1,
                itemBuilder: _getSelectedItems,
              ),

          )
        ],
      ),
    );

  }
  Widget _getSelectedItems(BuildContext context, int index){
    return ItemTile(context, index);
  }

}

class PeriodButton extends StatefulWidget{
  @override
  State<PeriodButton> createState() => _PeriodButton();
}

class _PeriodButton extends State<PeriodButton>{
  var value = periods.first;
  @override
  Widget build(BuildContext context) {

    return DropdownButton(
      value: value,
      onChanged: (String? v){
        setState(() {
          value = v!;
          selectedPeriod = value;
        });
      },
      items: periods.map<DropdownMenuItem<String>>((String v) {
        return DropdownMenuItem<String>(
          value: v,
          child: Text(v),
        );
      }).toList(),
    );
  }

}

class LocationButton extends StatefulWidget{
  @override
  State<LocationButton> createState() => _LocationButton();
}

class _LocationButton extends State<LocationButton>{
  @override

    var value = locations.first;
    @override
    Widget build(BuildContext context) {

      return DropdownButton(
        value: value,
        onChanged: (String? v){
          setState(() {
            value = v!;
            selectedLocation = value;
          });
        },
        items: locations.map<DropdownMenuItem<String>>((String v) {
          return DropdownMenuItem<String>(
            value: v,
            child: Text(v),
          );
        }).toList(),
      );
    }
  }


class ItemTile extends StatefulWidget{

  BuildContext context;
  int index;

  ItemTile(this.context,this.index);

  @override
  State<StatefulWidget> createState() {
    return _ItemTile(context,index);
  }
}

class _ItemTile extends State<ItemTile>{
  BuildContext context;

  int index;

  _ItemTile(this.context,this.index);

  Widget build(context){
    print("in item tile");

    return Card(
        child: ListTile(

          title: Item(index),
          shape: RoundedRectangleBorder( //<-- SEE HERE
            side: BorderSide(width: 0),
            borderRadius: BorderRadius.circular(0),
          ),

        )
    );
  }
}

class Item extends StatelessWidget{
  var index;
  Item(index);
  @override
  Widget build(BuildContext context) {
    print("in item");
    print(selected.toString());
    print(selected.keys.elementAt(index));
    return Row(
      children: <Widget>[
        Text(selected.keys.elementAt(index).toString())
      ],
    );
  }
  
}
