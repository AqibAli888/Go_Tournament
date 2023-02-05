import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sports_app/Global/global.dart';
import 'package:sports_app/main_screens/home_screen.dart';

import 'Authentication/auth_screen.dart';
class Splash_screen extends StatefulWidget {
  const Splash_screen({Key? key}) : super(key: key);

  @override
  State<Splash_screen> createState() => _Splash_screenState();
}

class _Splash_screenState extends State<Splash_screen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2), () {
      if(firebaseAuth.currentUser==null){
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Auth_screen()));
      }
      else {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Home_screen()));
      }

    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              child: Text(
                "Sports App",
                style: TextStyle(fontSize: 30, color: Colors.black),
              ),
            ),
          )
        ],
      ),
    );
  }
}
