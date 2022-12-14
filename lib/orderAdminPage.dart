import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'adminHome.dart';

class OrderPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("in order page");

    print(data.length);
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemBuilder: _getOrders,
            itemCount: data.length,
          ),
        )
      ],
    );
  }

  Widget _getOrders(BuildContext context, int index) {
    print("in get orders");
    return OrderTile(context, index);
  }
}

class OrderTile extends StatefulWidget {
  BuildContext context;
  int index;

  OrderTile(this.context, this.index);

  @override
  State<StatefulWidget> createState() {
    return _OrderTile(context, index);
  }
}

class _OrderTile extends State<OrderTile> {
  BuildContext context;

  int index;

  _OrderTile(this.context, this.index);

  Widget build(context) {
    print("in order tile");
    String current = "";
    Map values = data.values.elementAt(index);
    for (var i = 0; i < values.length - 1; i++) {
      current += values.keys.elementAt(i) +
          ":    " +
          values.values.elementAt(i) +
          "\n";
    }
    current += "items: \n";
    Map items = values.values.elementAt(values.length - 1);
    var format = NumberFormat.currency(symbol: "\$", decimalDigits: 2);
    for(int i = 0; i<items.length;i++){
      current += "${items.values.elementAt(i)[0]}   ${items.keys.elementAt(i)}:   ${format.format(items.values.elementAt(i)[0]*items.values.elementAt(i)[1])}\n";
    }
    return Card(
        child: Align(
          alignment: Alignment.centerLeft,
          child: Column(
            children: [
              Text(
                'Student id: ${data.keys.elementAt(index)}',
                style: const TextStyle(fontSize: 25),
              ),
              const SizedBox(height: 20),
              Text(current)
            ],
          ),
        ));
  }
}