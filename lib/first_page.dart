import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:stevensontakeout/adminLogin.dart';
import 'package:stevensontakeout/editAdminPage.dart';
import 'package:stevensontakeout/sign_up_page.dart';

import 'adminHome.dart';
import 'home_page.dart';
import 'login_page.dart';
import 'main.dart';

class FirstPage extends StatelessWidget{
  @override
  Widget build(BuildContext context){



    return Scaffold(
      body: Column(
        children: <Widget>[
          SizedBox(height: 50,),
          const Center(
            child: Image(
                image: AssetImage('assets/images/patriot.png'),
                width: 300,
                height: 300

            ),
          ),
          const SizedBox(height: 50,),
          AdminButton(),
          const SizedBox(height: 50,),
          StudentButton()

        ],
      ),
    );
  }
}

class AdminButton extends StatelessWidget{
  @override
  Widget build(BuildContext context){
      return ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF1f5d39),
            padding: const EdgeInsets.fromLTRB(60, 0, 60, 0)
        ),
          onPressed: (){
            getData();
            getAllItems();
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AdminLogin()));
          },

          child: const Text("Admin")
      );
  }
}
class StudentButton extends StatelessWidget{
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
              MaterialPageRoute(builder: (context) => LoginPage()));

        },

        child: const Text("Student")
    );
  }
}

