import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stevensontakeout/HomePage.dart';



TextEditingController _email = TextEditingController();
class VerificationPage extends StatefulWidget{
  var temp;
  VerificationPage(
      this.temp,
  );

  State<VerificationPage> createState() {
    _email = temp;
    return _VerificationPage();
  }
}

class _VerificationPage extends State<VerificationPage> {
  Timer scheduleTimeout([int milliseconds = 10000]) =>
      Timer(Duration(milliseconds: milliseconds), handleTimeout);
  var valid = false;

  void handleTimeout() {
    User? user = FirebaseAuth.instance.currentUser;

    if(user!=null){
      print("not verified");
      user.reload();
    }
    if (user != null && user.emailVerified) {

      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomePage()));
    }
    else{
      scheduleTimeout(5);
    }
  }
    @override
    void initState() {
      scheduleTimeout(5);
    }
    @override
    Widget build(BuildContext context) {
      print(_email.text);

      return Scaffold(
        body: Column(
          children: <Widget>[
            emailVerificationField(),
            verificationButton()
          ],
        ),
      );
    }
  }



class emailVerificationField extends StatefulWidget{
  State<emailVerificationField> createState() => _emailVerifiedField();
}

class _emailVerifiedField extends State<emailVerificationField>{
  @override
  Widget build(BuildContext context) {

    return Center (
        child: SizedBox(
          width: 250,
          child: TextFormField(
            controller: _email,
            decoration: const InputDecoration(
              labelText: 'email',
              labelStyle: TextStyle(color: const Color(0xFFc99a2c)),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: const Color(0xFFc99a2c)),
              ),
            ),
          ),
        )
    );
  }

}


class verificationButton extends StatefulWidget{
  State<verificationButton> createState() => _verificationButton();
}

class _verificationButton extends State<verificationButton>{
  Timer scheduleTimeout([int milliseconds = 10000]) =>
      Timer(Duration(milliseconds: milliseconds), handleTimeout);
  var valid = false;
  void handleTimeout() {
    print("timer over");
    setState(() {
      valid = true;
    });
  }
  @override
  void initState(){
    print("in schedule timeout");
    scheduleTimeout(60000);
  }
  @override
  Widget build(BuildContext context) {

    return ElevatedButton(
        onPressed: valid ? () => sendEmail() : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFc99a2c),
          padding: const EdgeInsets.fromLTRB(60, 0, 60, 0)
        ),
        child: const Text("Resend email")
    );

  }

  Future<void> sendEmail() async {
    User? user = FirebaseAuth.instance.currentUser;
    print("in pressed");
    if(user == null){
      print("user is null");
    }
    setState(() {
      valid = false;
    });

    if (user!= null && !user.emailVerified) {
      await user.sendEmailVerification();
      valid = false;
      scheduleTimeout(60000);
      print("sent");
    }
    else{
      print("email sending error");
    }
  }

}