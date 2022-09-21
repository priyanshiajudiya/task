import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class reset extends StatefulWidget {
  const reset({Key? key}) : super(key: key);

  @override
  State<reset> createState() => _resetState();
}

class _resetState extends State<reset> {
  TextEditingController t = TextEditingController();
  TextEditingController t1 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Reset-password"),),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            child: TextField(
              controller: t,
              decoration: InputDecoration(
                  hintText: "Enter New password",
                  labelText: "New password",
                  border: OutlineInputBorder()),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: TextField(
              controller: t1,
              decoration: InputDecoration(
                  hintText: "Confirm Password",
                  labelText: "Confirm password",
                  border: OutlineInputBorder()),
            ),
          ),
          ElevatedButton(onPressed:  () {
            if(t.text==t1.text)
              {
                  FirebaseAuth.instance
                      .sendPasswordResetEmail(email: t.text)
                      .then((value) => Navigator.pop(context));
                }
              }, child: Text("Reset"))
        ],
      ),
    );
  }
}


