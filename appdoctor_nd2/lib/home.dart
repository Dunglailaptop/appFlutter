import 'dart:convert'; // For JSON decoding
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // For loading assets

class Home extends StatefulWidget {
  @override
  State<Home> createState() {
    return MyHomePageState();
  }
}

class MyHomePageState extends State<Home> {
  List<Map<String, dynamic>> _allUsers = [];

  // Method to load and parse the JSON data
  Future<void> _loadJsonData() async {
    // Load the data from the assets
    String jsonString = await rootBundle.loadString(
      'lib/JsonFile/ListKhoa.json',
    );

    // Decode the JSON data into a List
    List<dynamic> jsonResponse = json.decode(jsonString);

    // Set the state with the loaded data
    setState(() {
      _allUsers =
          jsonResponse.map((item) {
            return {"id": item["id"], "title": item["title"]};
          }).toList();
    });
  }

  @override
  void initState() {
    super.initState();
    _loadJsonData(); // Load the data when the widget is first created
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Trang chủ')),
      body: ListView.builder(
        padding: EdgeInsets.all(10.0),
        itemCount: _allUsers.length,
        itemBuilder:
            (context, index) => Card(
              key: ValueKey(_allUsers[index]["id"]),
              color: Colors.green,
              elevation: 4,
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: ListTile(
                leading: Text(
                  _allUsers[index]["id"].toString(),
                  style: const TextStyle(fontSize: 24, color: Colors.white),
                ),
                title: Text(_allUsers[index]["title"]),
                titleTextStyle: const TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ),
      ),
    );
  }
}
