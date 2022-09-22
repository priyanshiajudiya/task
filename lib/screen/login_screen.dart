import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task/screen/resetpass_screen.dart';

import '../auth_service/service.dart';
import '../model/model_class.dart';

class firstpage extends StatefulWidget {
  TabController tabController;
  String? method;

  firstpage(this.tabController, this.method);

  @override
  State<firstpage> createState() => _firstpageState();
}

class _firstpageState extends State<firstpage> {
  TextEditingController t = TextEditingController();
  TextEditingController t1 = TextEditingController();
  bool s = false;
  String a = "User";


  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.fromLTRB(10, 40, 10, 20),
              child: Text(
                "Log In",
                style: TextStyle(
                    color: Colors.grey, wordSpacing: 0.5, fontSize: 20),
              ),
            ),
            // email
            Container(
              padding: const EdgeInsets.fromLTRB(15, 20, 15, 10),
              child: TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                controller: t,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  labelText: 'Email',
                  labelStyle: TextStyle(color: Colors.black87),
                  hintText: 'Enter Your email',
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 3, color:Colors.black),
                  ),
                ),
              ),
            ),
            //password
            Container(
              padding: const EdgeInsets.all(15),
              child: TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                controller: t1,
                obscureText: s,

                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    suffixIcon: IconButton(
                      icon: s
                          ? Icon(
                              Icons.visibility_off,
                              color: Colors.teal,
                            )
                          : Icon(
                              Icons.visibility,
                        color: Colors.teal,
                            ),
                      onPressed: () {
                        setState(() {
                          s = !s;
                        });
                      },
                      color: Colors.black,
                    ),
                    // border: OutlineInputBorder(),
                    labelText: 'Password',
                    labelStyle: TextStyle(color: Colors.black87),
                    hintText: 'Enter your password'),
              ),
            ),

            Row(
              children: [
                SizedBox(width: 80),
                Radio(
                  value: "Admin",
                  groupValue: a,
                  onChanged: (value) {
                    setState(() {
                      a = value.toString();
                    });
                  },
                ),
                Text("Admin"),
                Radio(
                  value: "User",
                  groupValue: a,
                  onChanged: (value) {
                    setState(() {
                      a = value.toString();
                    });
                  },
                ),
                Text("User"),
              ],
            ),
            //TextButton(
            //     onPressed: () {
            //       Navigator.push(context, MaterialPageRoute(
            //         builder: (context) {
            //           return reset();
            //         },
            //       ));
            //     },
            //     child: Text(
            //       "Forgot Password???",
            //       style: TextStyle(color: Colors.black54),
            //     )),
            Container(
              margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
              child: SizedBox(
                height: 45,
                width: 200,
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.teal)),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Processing Data')),
                      );
                    }
                    try {
                      final credential = await FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                        email: t.text,
                        password: t1.text,
                      );
                      print(credential);

                      UserModal userModel = UserModal(
                        name: a,
                        phone: credential.user!.phoneNumber,
                        email: credential.user!.email,
                        userImage: credential.user!.photoURL,
                        uId: credential.user!.uid,
                      );
                      createmail(userModel);
                      widget.tabController.animateTo(2);
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      await prefs.setString("login", "Yes");
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'weak-password') {
                        print('The password provided is too weak.');
                        Fluttertoast.showToast(
                            msg: "This is Center Short Toast",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0
                        );
                      } else if (e.code == 'email-already-in-use') {
                        print('The account already exists for that email.');
                        Fluttertoast.showToast(
                            msg: "This is Center Short Toast",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0
                        );

                      }
                    } catch (e) {
                      print(e);
                    }
                    t.clear();
                    t1.clear();
                    FocusManager.instance.primaryFocus?.unfocus();
                  },
                  child: Text(
                    '${widget.method}',
                    style: TextStyle(fontSize: 15),
                  ),
                ),
              ),
            ),
            SignInButton(
              Buttons.Google,
              text: "Sign up with Google",
              onPressed: () async {
                UserCredential? login = await signInWithGoogle();
                if (login.user != null) {
                  UserModal userModal = UserModal(
                    email: login.user!.email,
                    name: a,
                    phone: login.user!.phoneNumber,
                    uId: login.user!.uid,
                    userImage: login.user!.photoURL,
                  );
                  createuser(userModal);
                  widget.tabController.animateTo(2);

                  share_pref.pref = await SharedPreferences.getInstance();
                  await share_pref.pref!.setString("login", "yes");
                }
                print("Login");
              },
            )
          ],
        ),
      ),
    );
  }
}
