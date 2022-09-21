import 'package:flutter/material.dart';
import 'package:task/model/login_scr.dart';
import 'package:task/show_data.dart';

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
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              controller: widget.tabController,
              tabs: [
                Tab(
                  text: "login",
                ),
                Tab(text: "user"),
              ],
            ),
            title: Text('Authentication'),
          ),
          body: TabBarView(
              physics: NeverScrollableScrollPhysics(),
              controller: widget.tabController,
              children: [
                login_scr(
                  widget.tabController,"signup"
                ),
                show_data(widget.tabController),
              ]),
        ),
      ),
    );
  }
}
