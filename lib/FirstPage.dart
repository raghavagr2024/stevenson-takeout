import 'package:flutter/material.dart';
import 'package:stevensontakeout/SignUpPage.dart';

import 'HomePage.dart';
import 'LoginPage.dart';

class firstPage extends StatelessWidget{
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