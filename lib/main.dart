


import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:stevensontakeout/first_page.dart';

Map<String, dynamic> everyDayItems = {};
Map selected = {};
Map<String, dynamic> weeklyItems = {};
Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0.0,),
        body: FirstPage()
      ),
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

