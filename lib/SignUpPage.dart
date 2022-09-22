import 'package:flutter/material.dart';

late TextEditingController _name;
late TextEditingController _email;
late TextEditingController _password;
late TextEditingController _studentID;
class signUpPage extends StatelessWidget{
  Widget build(BuildContext context){
    return Scaffold(
      body: Column(
        children: <Widget>[
          SizedBox(height: 150),
          emailTextField(),
          SizedBox(height: 30),
          passwordTextField(),
          SizedBox(height: 30),
          studentIDTextField(),
          SizedBox(height: 30),
          nameTextField()
        ],
      )
    );
  }
}

class nameTextField extends StatefulWidget{
  State<nameTextField> createState() => _nameTextField();
}
class _nameTextField extends State<nameTextField>{

  @override
  void initState(){
    super.initState();
    _name = TextEditingController();
  }
  @override
  Widget build(BuildContext context) {
    return Center (
        child: SizedBox(
            width: 250,
            child: TextFormField(
                controller: _name,
                decoration: const InputDecoration(
                  labelText: 'Last Name',
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
class emailTextField extends StatefulWidget{
  State<emailTextField> createState() => _emailTextField();
}
class _emailTextField extends State<emailTextField>{

  @override
  void initState(){
    super.initState();
    _email = TextEditingController();
  }
  @override
  Widget build(BuildContext context) {
    return Center (
        child: SizedBox(
          width: 250,
          child: TextFormField(
            controller: _email,
            decoration: const InputDecoration(
              labelText: 'Email',
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
class passwordTextField extends StatefulWidget{
  State<passwordTextField> createState() => _passwordTextField();
}
class _passwordTextField extends State<passwordTextField>{

  @override
  void initState(){
    super.initState();
    _password = TextEditingController();
  }
  @override
  Widget build(BuildContext context) {
    return Center (
        child: SizedBox(
          width: 250,
          child: TextFormField(
            controller: _password,
            obscureText: true,
            decoration: const InputDecoration(
              labelText: 'Password',
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
class studentIDTextField extends StatefulWidget{
  State<studentIDTextField> createState() => _studentIDTextField();
}
class _studentIDTextField extends State<studentIDTextField>{

  @override
  void initState(){
    super.initState();
    _studentID = TextEditingController();
  }
  @override
  Widget build(BuildContext context) {
    return Center (
        child: SizedBox(
          width: 250,
          child: TextFormField(
            controller: _studentID,
            decoration: const InputDecoration(
              labelText: 'Student ID',
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