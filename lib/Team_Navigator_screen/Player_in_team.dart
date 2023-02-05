import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Global/global.dart';
import '../models/player_model.dart';
import '../widgets/error_dialog.dart';
import '../widgets/loading_dialog.dart';

class Player_in_team extends StatefulWidget {
  // parameter that it require to complte its jobs
  final String teamname; //team name
  final String level; // level of the team
  const Player_in_team({Key? key, required this.teamname, required this.level})
      : super(key: key);

  @override
  State<Player_in_team> createState() => _Player_in_teamState();
}

class _Player_in_teamState extends State<Player_in_team> {
  TextEditingController player_name = TextEditingController(); //take textfield controller
  TextEditingController age = TextEditingController();
  TextEditingController shirtnumber = TextEditingController();
  formvalidation() {
    if (player_name.text.trim().isNotEmpty && age.text.isNotEmpty) {
      Adding_Player();
    } else {
      showDialog(
          context: context,
          builder: (c) {
            return Error_Dialog(
              message: 'Please Enter All textfields',
            );
          });
    }
  }

  Adding_Player() async {
    showDialog(
        context: context,
        builder: (c) {
          return Loading_Dialog(
            message: 'Adding Team please wait',
          );
        });
    FirebaseFirestore.instance
        .collection("Users")
        .doc(firebaseAuth.currentUser!.uid)
        .collection("Teams")
        .doc(widget.teamname)
        .collection("Players")
        .doc(shirtnumber.text.trim())
        .set({
      "Player_Name": player_name.text,
      "Age": age.text,
      "Shirt_Number": shirtnumber.text
    }).then((value) async {
      await sharedpreference!.setString("Player_Name", player_name.text.trim());
      await sharedpreference!.setString("Player_Age", age.text.trim());
      await sharedpreference!
          .setString("Shirt_Number", shirtnumber.text.trim());
      Navigator.pop(context);
    });
  }

  @override
  void dispose() {
    super.dispose();
    shirtnumber.dispose();
    player_name.dispose();
    age.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // for real time we use stream builder
          StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("Users")
                .doc(firebaseAuth.currentUser!.uid)
                .collection("Teams")
                .doc(widget.teamname)
                .collection("Players")
                .snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                return Container(
                  height: MediaQuery.of(context).size.height * 0.6,
                  child: ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        Player_model player = Player_model.fromJson(
                            snapshot.data!.docs[index].data()!
                                as Map<String, dynamic>);
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Container(
                                height: 10,
                              ),
                              Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.1,
                                  decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Container(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(player.Player_Name
                                                  .toString()),
                                            ),
                                            Row(
                                              children: [
                                                IconButton(
                                                    onPressed: () {
                                                      FirebaseFirestore.instance
                                                          .collection("Users")
                                                          .doc(firebaseAuth
                                                              .currentUser!.uid)
                                                          .collection("Teams")
                                                          .doc(widget.teamname)
                                                          .collection("Players")
                                                          .doc(player
                                                              .Shirt_Number)
                                                          .delete();
                                                    },
                                                    icon: Icon(Icons.update)),
                                                IconButton(
                                                    onPressed: () async {
                                                     await FirebaseFirestore.instance
                                                          .collection("Users")
                                                          .doc(firebaseAuth
                                                          .currentUser!.uid)
                                                          .collection("Teams")
                                                          .doc(widget.teamname)
                                                          .collection("Players")
                                                          .doc(player
                                                          .Shirt_Number)
                                                          .update({
                                                        "Age":"sssxsddxs",
                                                        "Player_name":"snajnj",
                                                        "Shirt_Number":10.toString()
                                                      }).then((value){
                                                        print("updaated");

                                                      }).onError((error, stackTrace){
                                                        print(error.toString());
                                                      });
                                                    },
                                                    icon: Icon(Icons.delete))
                                              ],
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  )),
                            ],
                          ),
                        );
                      }),
                );
              } else {
                return Container();
              }
            },
          ),
// floating action button to add new team to the firebase
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              alignment: Alignment.bottomRight,
              child: FloatingActionButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          scrollable: true,
                          title: Text("Player Information"),
                          content: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Form(
                              child: Column(
                                children: <Widget>[
                                  TextFormField(
                                    controller: player_name,
                                    decoration: InputDecoration(
                                      labelText: 'Player Name',
                                      icon: Icon(Icons.account_box),
                                    ),
                                  ),
                                  TextFormField(
                                    controller: age,
                                    decoration: InputDecoration(
                                      labelText: 'Age',
                                      icon: Icon(Icons.account_box),
                                    ),
                                  ),
                                  TextFormField(
                                    controller: shirtnumber,
                                    decoration: InputDecoration(
                                      labelText: 'Shirt number',
                                      icon: Icon(Icons.email),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          actions: [
                            RaisedButton(
                                child: Text("Add Player to " +
                                    widget.teamname.toString()),
                                onPressed: () {
                                  formvalidation();
                                })
                          ],
                        );
                      });
                },
                tooltip: 'Increment',
                child: const Icon(Icons.add),
              ),
            ),
          ), // This trailing comma makes auto-formatting nicer for build methods.
        ],
      ),
    );
  }
}

// ListTile(
// focusColor: Colors.red,
// title: Text(player.Player_Name.toString()),
// subtitle: Text(player.Shirt_Number.toString()),
// onTap: () {
// },
// trailing: Container(
// child: Row(
// children: [
// IconButton(
// icon: Icon(Icons.edit), onPressed: () {
//
// showDialog(
// context: context,
// builder: (BuildContext context) {
// return AlertDialog(
// scrollable: true,
// title: Text("Update Player Information"),
// content: Padding(
// padding: const EdgeInsets.all(8.0),
// child: Form(
// child: Column(
// children: <Widget>[
// TextFormField(
// controller:player_name,
// decoration: InputDecoration(
// labelText: 'Player Name',
// icon: Icon(Icons.account_box),
// ),
// ),
// TextFormField(
// controller: age,
// decoration: InputDecoration(
// labelText: 'Age',
// icon: Icon(Icons.account_box),
// ),
// ),
// TextFormField(
// controller: shirtnumber,
// decoration: InputDecoration(
// labelText: 'Shirt number',
// icon: Icon(Icons.email),
// ),
// ),
// ],
// ),
// ),
// ),
// actions: [
// RaisedButton(
// child: Text("Add Player to "+ widget.teamname.toString()),
// onPressed: () {
// formvalidation();
// })
// ],
// );
// });
// FirebaseFirestore.instance.collection("Users").
// doc(firebaseAuth.currentUser!.uid).collection("Teams").
// doc(widget.teamname).collection("Players").doc(player.Shirt_Number).update({
// "Age":age.text,
// "Player_Name":player_name.text,
// "Shirt_Number":shirtnumber.text
//
// });
//
// },
// ),
// IconButton(
// icon: Icon(Icons.delete), onPressed: () {
// FirebaseFirestore.instance.collection("Users").
// doc(firebaseAuth.currentUser!.uid).collection("Teams").
// doc(widget.teamname).collection("Players").doc(player.Shirt_Number).delete().then((value){
// print(player.Shirt_Number);
// });
//
// },
// ),
// ],
// ),
// ),),
