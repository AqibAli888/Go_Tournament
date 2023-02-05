import 'package:flutter/cupertino.dart';

class Tournament_home_screen extends StatefulWidget {
  const Tournament_home_screen({Key? key}) : super(key: key);

  @override
  State<Tournament_home_screen> createState() => _Tournament_home_screenState();
}

class _Tournament_home_screenState extends State<Tournament_home_screen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("TOURNAMENT"),
    );
  }
}
