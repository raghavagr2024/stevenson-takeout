import 'package:flutter/material.dart';

class AdminLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 300,
          ),
          InputField(),
          SizedBox(
            height: 30,
          ),
          ConfirmButton()
        ],
      ),
    );
  }
}

TextEditingController _credential = TextEditingController();

class InputField extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _InputField();
  }
}

class _InputField extends State<InputField> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 30,
        ),
        TextFormField(
          controller: _credential,
          decoration: InputDecoration(
              labelText: "id",
              constraints: BoxConstraints.tight(Size(250, 300))),
        )
      ],
    );
  }
}

class ConfirmButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        print(_credential.text);
        if (_credential.text == "admin") {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AdminLogin()));
        }
      },
      child: Text("Confirm"),
    );
  }
}
