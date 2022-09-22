import 'package:flutter/material.dart';
import 'package:stevensontakeout/SignUpPage.dart';

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
          signUpButton(),
          SizedBox(height: 50,),
          loginButton()

        ],
      ),
    );
  }
}

class signUpButton extends StatelessWidget{

  Widget build(BuildContext context){
      return ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF1f5d39),
            padding: EdgeInsets.fromLTRB(60, 0, 60, 0)
        ),
          onPressed: (){
            print("text");
          },

          child: Text("Log In")
      );
  }
}
class loginButton extends StatelessWidget{
  Widget build(BuildContext context){
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFc99a2c),
            padding: EdgeInsets.fromLTRB(60, 0, 60, 0)
        ),
        onPressed: (){
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => signUpPage()));

        },

        child: Text("Sign Up")
    );
  }
}