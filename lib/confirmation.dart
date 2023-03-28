import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

class ConfirmationPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text("Card Form",
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 20,),
            CardFormField(
              controller: CardFormEditController(),
            ),
            TextButton(
                onPressed: (){},
                child: Text('Pay')
            )
          ],
        ),
      ),
    );
  }

}