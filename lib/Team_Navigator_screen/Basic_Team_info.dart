import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Basic_Team_info extends StatefulWidget {
  const Basic_Team_info({Key? key}) : super(key: key);

  @override
  State<Basic_Team_info> createState() => _Basic_Team_infoState();
}

class _Basic_Team_infoState extends State<Basic_Team_info> {
  TextEditingController namecontroller=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Column(
          children: [
            Container(
              alignment: Alignment.topCenter,
              child: TextField(
                controller:namecontroller,
                decoration: InputDecoration(
                  hintText: "Enter Team name"
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
