import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'model/model_class.dart';

class show_data extends StatefulWidget {
  TabController tabController;

  show_data(this.tabController);

  @override
  State<show_data> createState() => _show_dataState();
}

class _show_dataState extends State<show_data> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await GoogleSignIn().signOut();
            print("Logut");
            widget.tabController.animateTo(0);
          },
          child: Icon(Icons.logout)),
      body: StreamBuilder<List<UserModal>>(
        stream: readUser(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Somthing is wrong');
          } else if (snapshot.hasData) {
            final user = snapshot.data!;

            return ListView(
              children: user.map(buildUser).toList(),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Widget buildUser(UserModal userModal) => ListTile(
        title: Text(userModal.name!),
        subtitle: Text(userModal.email!),
        leading: userModal.userImage != null
            ? Image.network("${userModal.userImage}")
            : Text("Empty"),
        trailing: IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text("delete"),
                    content: Text("Are you sure you want to delete"),
                    actions: [
                      TextButton(
                          onPressed: () {
                            final docuser = FirebaseFirestore.instance
                                .collection('user')
                                .doc(userModal.uId);
                            docuser.delete();
                            Navigator.pop(context);
                          },
                          child: Text("yes")),
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text("no"))
                    ],
                  );
                },
              );
            },
            icon: Icon(Icons.delete)),
      );

  Stream<List<UserModal>> readUser() =>
      FirebaseFirestore.instance.collection('user').snapshots().map(
            (snapshot) => snapshot.docs
                .map((doc) => UserModal.fromJson(doc.data()))
                .toList(),
          );
}
