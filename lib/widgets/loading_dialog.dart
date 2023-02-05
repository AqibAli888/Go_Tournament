import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sports_app/widgets/progress_bar.dart';

class Loading_Dialog extends StatelessWidget {
  final String message;
  Loading_Dialog({
    required this.message
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      key: key,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          circular_ProgressIndicator(),
          SizedBox(height: 10,),
          Text(message+"Please Wait")
        ],
      )
    );
  }
}
