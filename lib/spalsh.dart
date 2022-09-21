import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task/first.dart';
import 'package:task/model/model_class.dart';

class splash extends StatefulWidget {
  const splash({Key? key}) : super(key: key);

  @override
  State<splash> createState() => _splashState();
}

class _splashState extends State<splash> with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    splash();
    tabController = TabController(vsync: this, length: 2);
  }

  Future splash() async {
    await Future.delayed(Duration(seconds: 1));
    Navigator.pushReplacement(context, MaterialPageRoute(
      builder: (context) {
        return login(tabController);
      },
    ));
    share_pref.pref = await SharedPreferences.getInstance();
    if (share_pref.pref!.containsKey('login')) {
      tabController.animateTo(1);
    } else {
      tabController.animateTo(0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(),
    );
  }
}
