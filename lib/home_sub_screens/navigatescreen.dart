
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Team_Navigator_screen/Basic_Team_info.dart';
import '../Team_Navigator_screen/Player_in_team.dart';
import '../models/team_model.dart';

class Navigatetoscreen extends StatefulWidget {
  final Team team;
  const Navigatetoscreen({Key? key,required this.team}) : super(key: key);

  @override
  State<Navigatetoscreen> createState() => _NavigatetoscreenState();
}

class _NavigatetoscreenState extends State<Navigatetoscreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(title: Text("Go Tournament"),centerTitle: true,
          bottom: TabBar(
            tabs: [
              Tab(text: "Basic Information",icon: Icon(Icons.lock),),
              Tab(text: "Players in Team",icon: Icon(Icons.app_registration),)
            ],
          ),),
        body: Container(
          color: Colors.amber,
          child: TabBarView(
            children: [
              Basic_Team_info(),
              Player_in_team(level: widget.team.level.toString(),teamname: widget.team.Name.toString() ,)
            ],
          ),
        ),
      ),
    );
  }
}

// Scaffold(
//
// appBar: AppBar(title: Text(widget.team.Name.toString())),
// body: Column(
// children: [
// Container(child: Text(widget.team.level.toString())),
// Container(child: Text(widget.team.Name.toString())),
// ],
// ),
// );