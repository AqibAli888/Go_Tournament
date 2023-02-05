import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sports_app/Authentication/auth_screen.dart';
import 'package:sports_app/Global/global.dart';

import '../Authentication/login.dart';
import '../Authentication/registration.dart';
import '../home_sub_screens/player_screen.dart';
import '../home_sub_screens/teams_screen.dart';
import '../home_sub_screens/tournament_showing_screen.dart';
import '../home_sub_screens/vanue_screen.dart';

class Home_screen extends StatefulWidget {
  const Home_screen({Key? key}) : super(key: key);

  @override
  State<Home_screen> createState() => _Home_screenState();
}

class _Home_screenState extends State<Home_screen> {
  User? currentuser;
  @override
  Widget build(BuildContext context) {
    return  DefaultTabController(length:4,
        child: Scaffold(
          appBar: AppBar(title: Text("Go Tournament"),centerTitle: true,
            bottom: TabBar(
              tabs: [
                Tab(text: "Tournaments",icon: Icon(Icons.celebration),),
                Tab(text: "Team",icon: Icon(Icons.group),),
                Tab(text: "Players",icon: Icon(Icons.person),),
                Tab(text: "Place",icon: Icon(Icons.place),)
              ],
            ),),
          body: Container(
            color: Colors.amber,
            child: TabBarView(
              children: [
                Tournament_home_screen(),
                Teams_screen(),
                player_screen(),
                Vanue_screen()
              ],
            ),
          ),
        ));
  }
}
