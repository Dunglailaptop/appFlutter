import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: SafeArea(child: Scaffold(body: MyWidget())),
      debugShowCheckedModeBanner: false,
    ),
  );
}

class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Text(
      "nhưng bạn công ty vô cùng vui vẻ hòa đồng,"
      "nhưng bạn công ty vô cùng vui vẻ hòa đồng,nhưng bạn công ty vô cùng vui vẻ hòa đồng",
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.justify,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}

//
// class MyWidget extends StatefulWidget {
//   final bool loading;
//
//   MyWidget(this.loading);
//
//   @override
//   State<StatefulWidget> createState() {
//     // TODO: implement build
//     return MyWight2State();
//   }
// }
//
// class MyWight2State extends State<MyWidget> {
//   late bool _localloading;
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     _localloading = widget.loading;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return _localloading
//         ? CircularProgressIndicator()
//         : FloatingActionButton(onPressed: onClickButton);
//   }
//
//   void onClickButton() {
//     setState(() {
//       _localloading = true;
//     });
//   }
// }
