import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stevensontakeout/home_page.dart';

import 'checkout.dart';
import 'main.dart';

var periods = [
  "4A (11:10 - 11:30)",
  "4B (11:37 - 11:57)",
  "5A (12:02-12:22)",
  "5B (12:02 - 12:22)",
  "6A (12:45 - 1:14)"
];

var total = 0;
var locations = ["East Commons", "West Commons"];
var paymentOptions = ["Pay online", "Pay in person"];
var preferences = [periods.first,locations.first,paymentOptions.first];
List meats = [
  "Chicken",
  "Gyro",
  "Italian Sausage",
  "Meatballs",
  "Barbacoa",
  "BBQ Chicken",
  "Bacon Bits"
];

class Cart extends StatefulWidget {
  @override
  State<Cart> createState() => _Cart();
}

class _Cart extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          const SizedBox(
            height: 40,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: BackButton(),
          ),
          SizedBox(
            height: (selected.length) * 53,
            child: Align(
              alignment: Alignment.topCenter,
              child: ItemList(),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          InternationalOption(),
          TotalPrice(),
          PeriodButton(),
          SizedBox(
            height: 20,
          ),
          LocationButton(),
          SizedBox(height: 20,),
          Payment(),
          NextButton()
        ],
      ),
    );
  }
}

class ItemList extends StatefulWidget {
  @override
  State<ItemList> createState() => _ItemList();
}

class _ItemList extends State<ItemList> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: selected.length - 1,
        itemBuilder: _getSelectedItems,
        separatorBuilder: (BuildContext context, int index) => const SizedBox(
              height: 0,
            ));
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

    return Row(
      children: [
        const SizedBox(
          width: 37,
        ),
        const Text(
          "Time",
          style: TextStyle(fontSize: 20),
        ),
        const SizedBox(
          width: 20,
        ),
        DropdownButton(
          value: value,
          onChanged: (String? v) {
            setState(() {
              value = v!;
              preferences[0] = value;
            });
          },
          items: periods.map<DropdownMenuItem<String>>((String v) {
            return DropdownMenuItem<String>(
              value: v,
              child: Text(v),
            );
          }).toList(),
        )
      ],
    );
  }
}

class LocationButton extends StatefulWidget {
  @override
  State<LocationButton> createState() => _LocationButton();
}

class _LocationButton extends State<LocationButton> {

  var value = locations.first;

  @override
  Widget build(BuildContext context) {

    return Row(
      children: <Widget>[
        const SizedBox(
          width: 37,
        ),
        const Text(
          "Location: ",
          style: TextStyle(fontSize: 20),
        ),
        const SizedBox(
          width: 20,
        ),
        DropdownButton(
          value: value,
          onChanged: (String? v) {
            setState(() {
              value = v!;
              preferences[1] = value;
            });
          },
          items: locations.map<DropdownMenuItem<String>>((String v) {
            return DropdownMenuItem<String>(
              value: v,
              child: Text(v),
            );
          }).toList(),
        )
      ],
    );
  }
}

class Payment extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _Payment();
  }

}

class _Payment extends State<Payment>{
  var value = paymentOptions.first;
  @override
  Widget build(BuildContext context) {

    return Row(
      children: [
        const SizedBox(width: 37,),
        const Text("Payment option: ", style: TextStyle(fontSize: 20),),
        const SizedBox(width: 20,),
        DropdownButton(
          value: value,
          onChanged: (String? v) {
            setState(() {
              value = v!;
              preferences[2] = value;
            });
          },
          items: paymentOptions.map<DropdownMenuItem<String>>((String v) {
            return DropdownMenuItem<String>(
              value: v,
              child: Text(v),
            );
          }).toList(),
        )
      ],
    );
  }

}

class ItemTile extends StatelessWidget {
  BuildContext context;

  int index;

  ItemTile(this.context, this.index);

  Widget build(context) {
    print("in item tile");

    return Container(
        height: 53,
        child: ListTile(
          title: Item(index),
        ));
  }
}

class Item extends StatefulWidget {
  var index;

  Item(this.index);

  @override
  State<StatefulWidget> createState() {
    return _Item(index);
  }
}

class _Item extends State<Item> {
  var index;

  _Item(this.index);

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
              child: Row(
                children: <Widget>[
                  Text(
                    selected.values.elementAt(index)[0].toString(),
                    style: TextStyle(fontSize: 20),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  IconButton(
                      onPressed: () {
                        selected.remove(selected.keys.elementAt(index));
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => Cart()),
                          (Route<dynamic> route) => false,
                        );
                      },
                      icon: const Icon(Icons.delete)),
                ],
              )),
        ),
        Expanded(
          child: Align(
              alignment: Alignment.center,
              child: TextButton(
                onPressed: () {
                  _displayInfo(context, index);
                },
                child: Text(selected.keys.elementAt(index),
                    style: const TextStyle(fontSize: 15)),
              )),
        ),
        Expanded(
          child: Align(
            alignment: Alignment.centerRight,
            child: Text(ans, style: const TextStyle(fontSize: 20)),
          ),
        ),
        const SizedBox(
          width: 20,
        )
      ],
    );
  }

  Future<void> _displayInfo(BuildContext context, int index) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(selected.keys.elementAt(index)),
          content: CounterButton(index),
          actions: <Widget>[
            TextButton(
                onPressed: () {
                  setState(() {});
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => Cart()),
                    (Route<dynamic> route) => false,
                  );
                },
                child: const Text("done"))
          ],
        );
      },
    );
  }
}

class CounterButton extends StatefulWidget {
  var index;

  CounterButton(
    this.index,
  );

  @override
  State<StatefulWidget> createState() {
    return _CounterButton(index);
  }
}

class _CounterButton extends State<CounterButton> {
  var index;

  _CounterButton(this.index);

  @override
  Widget build(BuildContext context) {
    var text = selected.values.elementAt(index)[0];

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
              color: text != 1 ? const Color(0xFFc99a2c) : Colors.grey,
              size: 20,
            ),
            onPressed: text != 1 ? () => subtract(index) : null,
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
              add(index);
            },
          ),
        ],
      ),
    );
  }

  void subtract(var i) {
    selected.values.elementAt(i)[0]--;

    print(selected.toString());
    setState(() {});
  }

  void add(var i) {
    print(selected.values.elementAt(i)[0]);
    selected.values.elementAt(i)[0]++;

    setState(() {});
  }
}

class BackButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => HomePage()));
        },
        icon: Icon(Icons.arrow_back_ios_new));
  }
}

class InternationalOption extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _InternationalOption();
  }
}

class _InternationalOption extends State<InternationalOption> {
  @override
  Widget build(BuildContext context) {
    if (selected.values.elementAt(selected.length - 1).length == 0) {
      return const SizedBox(
        height: 0,
        width: 0,
      );
    }
    return Container(
      height: 50,
      child: Row(
        children: <Widget>[
          const SizedBox(width: 37),
          Expanded(
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "${selected.values.elementAt(selected.length - 1).length} items",
                    style: TextStyle(fontSize: 20),
                  ))),
          Expanded(
            child: Align(
                alignment: Alignment.center,
                child: TextButton(
                  onPressed: () {
                    //_displayInfo(context);
                  },
                  child: Text(
                    selected.keys.elementAt(selected.length - 1),
                    style: const TextStyle(fontSize: 15),
                  ),
                )
                //style: TextStyle(fontSize: 20),
                ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(getPrice(), style: const TextStyle(fontSize: 20)),
            ),
          ),
          const SizedBox(
            width: 37,
          )
        ],
      ),
    );
  }
  /*
  Future<void> _displayInfo(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(selected.keys.elementAt(selected.length - 1)),
          content: Container(
            width: 300,
            height: 300,
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: weeklyItems[station].length,
                itemBuilder: _getInternational),
          ),
          actions: <Widget>[
            TextButton(
                onPressed: () {
                  setState(() {});
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => Cart()),
                    (Route<dynamic> route) => false,
                  );
                },
                child: const Text("done"))
          ],
        );
      },
    );
  }
  */
  String getPrice() {
    for (String i in selected.values.elementAt(selected.length - 1)) {
      if (meats.contains(i)) {
        return ("\$5.00");
      }
    }

    return ("\$4.00");
  }
/*
  Widget _getInternational(BuildContext context, int index) {
    return InternationalTile(context, weeklyItems[station], index);
  }
  */

}

class TotalPrice extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TotalPrice();
  }
}

class _TotalPrice extends State<TotalPrice> {
  @override
  Widget build(BuildContext context) {
    var format = NumberFormat.currency(symbol: "\$", decimalDigits: 2);
    return Container(
      height: 50,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                "total:   ${format.format(_getPrice())}",
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
          SizedBox(
            width: 34,
          )
        ],
      ),
    );
  }

  double _getPrice() {
    double total = 0;
    for (int i = 0; i < selected.length - 1; i++) {
      total +=
          selected.values.elementAt(i)[0] * selected.values.elementAt(i)[1];
    }

    for (String i in selected.values.elementAt(selected.length - 1)) {
      if (meats.contains(i)) {
        setState(() {});
        return total + 5;
      }
    }

    if (selected.values.elementAt(selected.length - 1).length == 0) {
      setState(() {});
      return total;
    }
    setState(() {});
    return total + 4;
  }
}

class NextButton extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement firebase calls
    return TextButton(
        onPressed: (){
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => CheckoutPage()));
        },
        child: Text("Continue")
    );
  }

}
