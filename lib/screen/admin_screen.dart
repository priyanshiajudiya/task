import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/model_class.dart';

class admin extends StatefulWidget {
  TabController tabController;

  admin(this.tabController);

  @override
  State<admin> createState() => _adminState();
}

class _adminState extends State<admin> {
  bool staus = false;
  UserModal? userModel;

  String path = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("user")
              .doc(path)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text("Something went wrong"));
            } else if (snapshot.hasData) {
              final user = snapshot.data!;
              UserModal userModel =
                  UserModal.fromJson(user.data() as Map<String, dynamic>);
              return ListView(
                children: [
                  Container(
                    margin: EdgeInsets.all(10),
                    height: 60,
                    width: 60,
                    child: (userModel.userImage != null)
                        ? Image.network("${userModel.userImage}")
                        : Image.asset("images/person.jpg"),
                  ),
                  ListTile(
                    title: Center(
                        child: Text(
                      "${userModel.email}",
                    )),
                    subtitle: Center(
                        child: Text(
                      "${userModel.name}",
                    )),
                  ),
                  Container(
                    height: 40,
                    width: 100,
                    child: (userModel.name == "Admin")
                        ? Align(
                            heightFactor: 50,
                            widthFactor: 50,
                            child: ElevatedButton(
                                onPressed: () {
                                  if (userModel.name == "Admin") {
                                    widget.tabController.animateTo(1);
                                  }
                                },
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStatePropertyAll(Colors.teal)),
                                child: Text("Admin")),
                          )
                        : Center(child: Text("You Are not Admin")),
                  ),
                ],
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
                backgroundColor: Colors.teal,
                onPressed: () async {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return admin(widget.tabController);
                    },
                  ));
                },
                child: Icon(Icons.edit)),
            Container(
              margin: EdgeInsets.all(5),
              child: FloatingActionButton(
                  backgroundColor: Colors.teal,
                  onPressed: () async {
                    await GoogleSignIn().signOut();
                    widget.tabController.animateTo(0);
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    await prefs.clear();
                  },
                  child: Icon(Icons.logout)),
            ),
          ],
        ));
  }
}
