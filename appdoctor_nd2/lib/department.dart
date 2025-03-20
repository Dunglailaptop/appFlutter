import 'package:flutter/material.dart';

class department extends StatefulWidget {
  @override
  State<department> createState() {
    // TODO: implement createState
    return departmentdetail();
  }
}

class departmentdetail extends State<department> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(child: Scaffold(appBar: AppBar(title: Text("khoa khám bệnh")),body: Column(
     children: [
       Padding(padding: const EdgeInsets.all(10),child: Container(
         padding: EdgeInsets.all(20),
         decoration: BoxDecoration(
           color: Colors.green.shade100,
           borderRadius: BorderRadius.circular(10),
         ),
       ))
     ],
    )));
  }
}