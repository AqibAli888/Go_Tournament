import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Error_Dialog extends StatelessWidget {
  final String message;
  Error_Dialog({
   required this.message
});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      key: key,
      content: Text(message),
      actions: [
        ElevatedButton(onPressed: (){
          Navigator.pop(context);
        },
            child: Center(child: Text("ok")))
      ],
    );
  }
}
