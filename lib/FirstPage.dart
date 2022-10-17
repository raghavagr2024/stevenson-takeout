import 'package:flutter/material.dart';
import 'package:stevensontakeout/SignUpPage.dart';

import 'HomePage.dart';
import 'LoginPage.dart';

class firstPage extends StatelessWidget{
  Widget build(BuildContext context){



    return Scaffold(
      body: Column(
        children: <Widget>[
          Center(
            child: Image(
                image: AssetImage('assets/images/patriot.png'),
                width: 300,
                height: 300

            ),
          ),
          SizedBox(height: 50,),
          LoginButton(),
          SizedBox(height: 50,),
          SignUpButton()

        ],
      ),
    );
  }
}

class LoginButton extends StatelessWidget{

  Widget build(BuildContext context){
      return ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF1f5d39),
            padding: EdgeInsets.fromLTRB(60, 0, 60, 0)
        ),
          onPressed: (){
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()));
          },

          child: Text("Log In")
      );
  }
}
class SignUpButton extends StatelessWidget{
  Widget build(BuildContext context){
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFc99a2c),
            padding: EdgeInsets.fromLTRB(60, 0, 60, 0)
        ),
        onPressed: (){
          //change to Sign Up
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePage()));

        },

        child: Text("Sign Up")
    );
  }
}