import 'package:cloud_firestore/cloud_firestore.dart';
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
        if (data.isNotEmpty)
          Expanded(
          child: ListView.builder(
            itemBuilder: _getOrders,
            itemCount: data.length,
          ),
        ),
        if (data.isEmpty)
          SizedBox(height: 40),
          Text("No orders", style: TextStyle(fontSize: 30),),
          const SizedBox()


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
    Map values = data.values.elementAt(index);
    Map foods = values['foods'];
    Map soups = values['soups'];
    values.remove('foods');
    values.remove('soups');
    String current = "";

    for (var i = 0; i < values.length - 1; i++) {
      current += values.keys.elementAt(i) +
          ":    " +
          values.values.elementAt(i) +
          "\n";
    }
    var format = NumberFormat.currency(symbol: "\$", decimalDigits: 2);
    if(foods==null){
      current +="";
    }
    else{
      current += "foods: \n";
      for(int i = 0; i<foods.length;i++){
        current += "${foods.values.elementAt(i)[0]}   ${foods.keys.elementAt(i)}:   ${format.format(foods.values.elementAt(i)[0]*foods.values.elementAt(i)[1])}\n";
      }
    }
    if(soups==null){
      current+="";
    }
    else{
      current += "Soups: \n";
      for(int i = 0; i<soups.length;i++){
        if(soups.values.elementAt(i)[0]!=0){
          current += "${soups.values.elementAt(i)[0]}   12 oz. ${soups.keys.elementAt(i)}: ${format.format(soups.values.elementAt(i)[0]*2)}\n";
        }
        if(soups.values.elementAt(i)[1]!=0){
          current += "${soups.values.elementAt(i)[1]}   8 oz. ${soups.keys.elementAt(i)}: ${format.format(soups.values.elementAt(i)[1]*1.5)}\n";
        }
      }
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
              ListTile(
                title: Text(current),
                trailing: IconButton(
                  onPressed: (){
                    deleteOrderDialog(index);
                  },
                  icon: Icon(Icons.highlight_remove_outlined),
                ),
              )

            ],
          ),
        ));
  }

  Future<void> deleteOrderDialog(int i) async {

    return await showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, s) {
            return Container(
              height: 300,
              width: 300,
              child: AlertDialog(
                title: Text("Deleting order for student ID :${data.keys.elementAt(index)}"),
                content: SingleChildScrollView(
                  child: ListBody(
                    children: <Widget>[
                      Text("Deleting this order will clear it from the list")
                    ],
                  ),
                ),
                actions: <Widget>[
                    TextButton(
                        onPressed: (){
                          Navigator.of(context).pop();
                        },
                        child: Text("Cancel")
                    ),
                  TextButton(
                      onPressed: () async {
                        await FirebaseFirestore.instance
                            .collection('users')
                            .doc('SxHI0lmZHaO8r2BnwtuH')
                            .update({
                          '${data.keys.elementAt(index)}': FieldValue.delete()
                        }).whenComplete(() {
                          print('Field Deleted');
                        });
                        print("done with delete");
                        Navigator.of(context).pop();
                        setState(() {
                          data.remove(data.keys.elementAt(index));
                        });
                      },
                      child: Text("Confirm")
                  ),

                ],
              ),
            );
          });
        });
  }

}