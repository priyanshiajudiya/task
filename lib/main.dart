import 'package:flutter/material.dart';
import 'package:task/screen/api_screen/api_scr.dart';
import 'package:task/tabbar_design.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:task/screen/splash_screen/spalsh_scr.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(

  );
  runApp(MaterialApp(home: apiscrren(),debugShowCheckedModeBanner: false,));
}
