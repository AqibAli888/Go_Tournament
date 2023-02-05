import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sports_app/Global/global.dart';
import '../models/team_model.dart';
import '../widgets/error_dialog.dart';
import '../widgets/loading_dialog.dart';
import 'navigatescreen.dart';

class Teams_screen extends StatefulWidget {
  const Teams_screen({Key? key}) : super(key: key);
  @override
  State<Teams_screen> createState() => _Teams_screenState();
}
class _Teams_screenState extends State<Teams_screen> {
  TextEditingController teamnamecontroller = TextEditingController();
  TextEditingController levelcontroller = TextEditingController();

  // check the validation of the text fields
  formvalidation() {
    if (teamnamecontroller.text.trim().isNotEmpty &&
        levelcontroller.text.isNotEmpty) {
      //login
      Adding_team();
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
// adding team to the firebase function
  Adding_team() async {
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
        .doc(teamnamecontroller.text)
        .set({
      "Name": teamnamecontroller.text,
      "level": levelcontroller.text
    }).then((value) async {
      await sharedpreference!.setString("Team_Name", teamnamecontroller.text.trim());
      await sharedpreference!.setString("level", levelcontroller.text.trim());
      Navigator.pop(context);
    });
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
                .snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                return Container(
                  height: MediaQuery.of(context).size.height * 0.6,
                  child: ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        Team team = Team.fromJson(snapshot.data!.docs[index]
                            .data()! as Map<String, dynamic>);
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Container(
                              height: 10,),
                              Container(
                                height: MediaQuery.of(context).size.height * 0.1,
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(10)
                                ),
                                child: ListTile(

                                  focusColor: Colors.red,
                                    title: Text(team.Name.toString()),
                                    subtitle: Text(team.level.toString()),
                                    onTap: () {
                                      Navigator.of(context).push(MaterialPageRoute(
                                          builder: (context) => Navigatetoscreen(team:team,)));
                                    }),
                              ),
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
                          title: Text('Add New Team'),
                          content: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Form(
                              child: Column(
                                children: <Widget>[
                                  TextFormField(
                                    controller: teamnamecontroller,
                                    decoration: InputDecoration(
                                      labelText: 'Name of the team',
                                      icon: Icon(Icons.account_box),
                                    ),
                                  ),
                                  TextFormField(
                                    controller: levelcontroller,
                                    decoration: InputDecoration(
                                      labelText: 'level  of the team',
                                      icon: Icon(Icons.email),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          actions: [
                            RaisedButton(
                                child: Text("Submit"),
                                onPressed: () {
                                  formvalidation();
                                  // your code
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