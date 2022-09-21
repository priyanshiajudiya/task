import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task/reset_password.dart';

import 'model_class.dart';

class login_scr extends StatefulWidget {
  TabController tabController;
  String method;
  login_scr(this.tabController ,this.method);

  @override
  State<login_scr> createState() => _login_scrState();
}

class _login_scrState extends State<login_scr> {
  TextEditingController t = TextEditingController();
  TextEditingController t1 = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            child: TextField(
              controller: t,
              decoration: InputDecoration(
                  hintText: "Enter Email ID",
                  labelText: "Email ID",
                  border: OutlineInputBorder()),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: TextField(
              controller: t1,
              decoration: InputDecoration(
                  hintText: "Enter Password",
                  labelText: "Password",
                  border: OutlineInputBorder()),
            ),
          ),
          TextButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return reset();
                  },
                ));
              },
              child: Text("Forgot Password?")),
          Container(
            child: ElevatedButton(
                onPressed: () async {
                  if (widget.method == "login") {
                    try {
                      final credential = await FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                        email: t.text,
                        password: t1.text,
                      );
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'weak-password') {
                        print('The password provided is too weak.');
                      } else if (e.code == 'email-already-in-use') {
                        print('The account already exists for that email.');
                      }
                    } catch (e) {
                      print(e);
                    }
                  }else if(widget.method=="signup")
                      {
                        try {
                          final credential = await FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                              email: t.text, password: t1.text);
                          print(credential);
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'user-not-found') {
                            print('No user found for that email.');
                            Fluttertoast.showToast(
                                msg: "User not found",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.white,
                                textColor: Colors.black,
                                fontSize: 16.0
                            );
                          } else if (e.code == 'wrong-password') {
                            print('Wrong password provided for that user.');
                            Fluttertoast.showToast(
                                msg: "wrong password",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.white,
                                textColor: Colors.black,
                                fontSize: 16.0
                            );
                          }
                        }
                      }
                },
                child: Text("${widget.method}")),
          ),
          Container(
            child: ElevatedButton(
                onPressed: () async {
                  UserCredential login = await signInWithGoogle();
                  if (login.user != null) {
                    UserModal welcome = UserModal(
                      uId: login.user!.uid,
                      name: login.user!.displayName,
                      userImage: login.user!.photoURL,
                      email: login.user!.email,
                      phone: login.user!.phoneNumber,
                    );
                    createuser(welcome);
                    widget.tabController.animateTo(1);
                    share_pref.pref = await SharedPreferences.getInstance();
                   await share_pref.pref!.setString("login","yes");
                  }
                },
                child: Text("login with google")),
          )
        ],
      ),
    );
  }

}

Future<UserCredential> signInWithGoogle() async {
  // Trigger the authentication flow
  await GoogleSignIn().signOut();
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
  // Obtain the auth details from the request
  final GoogleSignInAuthentication? googleAuth =
      await googleUser?.authentication;
  // Create a new credential
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );
  // Once signed in, return the UserCredential
  return await FirebaseAuth.instance.signInWithCredential(credential);
}

Future createuser(UserModal UserModal) async {
  final firestore =
      FirebaseFirestore.instance.collection("user").doc("${UserModal.uId}");
  await firestore.set(UserModal.toJson());
}


