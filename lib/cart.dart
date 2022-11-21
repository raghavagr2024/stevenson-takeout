import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'main.dart';

var periods = [
  "4A (11:10 - 11:30)",
  "4B (11:37 - 11:57)",
  "5A (12:02-12:22)",
  "5B (12:02 - 12:22)",
  "6A (12:45 - 1:14)"
];
var selectedPeriod, selectedLocation;
var total = 0;
var locations = ["East Commons", "West Commons"];

class Cart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    log("in build");
    log(selected.toString());
    return Scaffold(
      body: Column(
        children: <Widget>[
          const SizedBox(
            height: 50,
          ),


          Expanded(
            child: ListView.separated(
              itemCount: selected.length - 1,
              itemBuilder: _getSelectedItems,
              separatorBuilder: (BuildContext context, int index) => SizedBox(
                height: 0,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _getSelectedItems(BuildContext context, int index) {
    return ItemTile(context, index);
  }
}

class PeriodButton extends StatefulWidget {
  @override
  State<PeriodButton> createState() => _PeriodButton();
}

class _PeriodButton extends State<PeriodButton> {
  var value = periods.first;

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      value: value,
      onChanged: (String? v) {
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

class LocationButton extends StatefulWidget {
  @override
  State<LocationButton> createState() => _LocationButton();
}

class _LocationButton extends State<LocationButton> {
  @override
  var value = locations.first;

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      value: value,
      onChanged: (String? v) {
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

class ItemTile extends StatefulWidget {
  BuildContext context;
  int index;

  ItemTile(this.context, this.index);

  @override
  State<StatefulWidget> createState() {
    return _ItemTile(context, index);
  }
}

class _ItemTile extends State<ItemTile> {
  BuildContext context;

  int index;

  _ItemTile(this.context, this.index);

  Widget build(context) {
    print("in item tile");

    return Container(
        child: ListTile(
      title: Item(index),
      tileColor: null,
    ));
  }
}

class Item extends StatelessWidget {
  var index;

  Item(this.index);

  var format = NumberFormat.currency(symbol: "\$", decimalDigits: 2);

  @override
  Widget build(BuildContext context) {
    String ans = format.format(selected.values.elementAt(index)[1] *
        selected.values.elementAt(index)[0]);

    return Row(
      children: <Widget>[
        SizedBox(width: 20),
        Expanded(
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              (selected.keys.elementAt(index).toString()),
              //style: TextStyle(fontSize: 20),
            ),
          ),
        ),
        Expanded(
          child: Align(
            alignment: Alignment.center,
            child: Text(selected.values.elementAt(index)[0].toString(),
            style: TextStyle(fontSize: 20)),
          ),
        ),
        Expanded(
          child: Align(
            alignment: Alignment.centerRight,
            child: Text(ans, style: TextStyle(fontSize: 20)),
          ),
        ),
        SizedBox(
          width: 20,
        )
      ],
    );
  }
}

Future<void> _displayInfo(BuildContext context, int index) async{
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: selected.values.elementAt(index),
        //content: CounterButton(index, ),
      );
    },
  );
}
