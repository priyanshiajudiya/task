import 'package:flutter/material.dart';

class up_date extends StatefulWidget {
  const up_date({Key? key}) : super(key: key);

  @override
  State<up_date> createState() => _up_dateState();
}

class _up_dateState extends State<up_date> {
  TextEditingController t = TextEditingController();
  TextEditingController t1 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            Container(
              margin: EdgeInsets.all(5),
              child: TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  labelStyle: TextStyle(color: Colors.black87),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 3, color: Colors.black),
                  ),
                ),
                controller: t,
              ),
            ),
            Container(
              margin: EdgeInsets.all(5),
              child: TextFormField(
                controller: t1,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  labelStyle: TextStyle(color: Colors.black87),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 3, color: Colors.black),
                  ),
                ),
              ),
            ),
            ElevatedButton(onPressed: () {

            }, child: Text("Select Photo")),
            ElevatedButton(onPressed: () {}, child: Text("submit"))
          ],
        ));
  }
}
