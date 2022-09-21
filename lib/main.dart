import 'package:flutter/material.dart';
import 'package:task/first.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:task/spalsh.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(

  );
  runApp(MaterialApp(home: splash(),));
}
