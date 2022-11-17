import 'package:flutter/material.dart';
import 'package:stevensontakeout/sign_up_page.dart';

import 'home_page.dart';
import 'login_page.dart';
import 'main.dart';

class FirstPage extends StatelessWidget{
  @override
  Widget build(BuildContext context){



    return Scaffold(
      body: Column(
        children: <Widget>[
          const Center(
            child: Image(
                image: AssetImage('assets/images/patriot.png'),
                width: 300,
                height: 300

            ),
          ),
          const SizedBox(height: 50,),
          LoginButton(),
          const SizedBox(height: 50,),
          SignUpButton()

        ],
      ),
    );
  }
}

class LoginButton extends StatelessWidget{
  @override
  Widget build(BuildContext context){
      return ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF1f5d39),
            padding: const EdgeInsets.fromLTRB(60, 0, 60, 0)
        ),
          onPressed: (){
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()));
          },

          child: const Text("Log In")
      );
  }
}
class SignUpButton extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFc99a2c),
            padding: const EdgeInsets.fromLTRB(60, 0, 60, 0)
        ),
        onPressed: (){
          //change to Sign Up
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePage()));

        },

        child: const Text("Sign Up")
    );
  }
}

class Tile extends StatefulWidget{

  BuildContext context;
  int index;

  Tile(this.context,this.index);

  @override
  State<StatefulWidget> createState() {
    return _Tile(context,index);
  }
}

class _Tile extends State<Tile>{
  BuildContext context;
  int index;

  _Tile(this.context,this.index);

  Widget build(context){
    

    return Card(
        child: ListTile(
          title: Text(selected.keys.elementAt(0)),
          subtitle: Text(selected.values.elementAt(0)),

        )
    );
  }
}