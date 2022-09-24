import 'package:flutter/material.dart';
import 'package:task/screen/admin_screeen/admin_screen.dart';
import 'package:task/screen/login_screen/login_screen.dart';
import 'package:task/screen/user_screen/user_scr.dart';

class login extends StatefulWidget {
  TabController tabController;

  login(this.tabController);

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  int curentindex = 0;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        bool willLeave = false;
        // show the confirm dialog
        await showDialog(
            context: context,
            builder: (_) => AlertDialog(
                  title: const Text('Are you sure want to leave?'),
                  actions: [
                    ElevatedButton(
                        onPressed: () {
                          willLeave = true;
                          Navigator.of(context).pop();
                        },
                        child: const Text('Yes')),
                    TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text('No'))
                  ],
                ));
        return willLeave;
      },
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.teal,
            bottom: TabBar(
              indicatorColor: Colors.white,
              controller: widget.tabController,
              tabs: [
                Tab(
                  text: "login",

                ),
                Tab(
                    text: "user"
                ),
                Tab(
                    text: "admin"
                ),

              ],
            ),
            title: Text('Authentication'),
          ),
          body: TabBarView(
              physics: NeverScrollableScrollPhysics(),
              controller: widget.tabController,
              children: [
                firstpage(
                  widget.tabController,"login"
                ),
                showdata(widget.tabController),
                admin(widget.tabController),

              ]),
        ),
      ),
    );
  }
}
