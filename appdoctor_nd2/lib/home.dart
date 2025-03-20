import 'dart:convert'; // For JSON decoding
import 'package:appdoctor_nd2/department.dart';
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
  List<Map<String, dynamic>> _filteredUsers = [];
  TextEditingController _searchController = TextEditingController();

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
      _allUsers = jsonResponse.map((item) {
        return {"id": item["id"], "title": item["title"]};
      }).toList();
      _filteredUsers = _allUsers;
    });
  }

  void _filterUsers(String query) {
    setState(() {
      _filteredUsers = _allUsers
          .where((user) => user["title"].toString().toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  void initState() {
    super.initState();
    _loadJsonData(); // Load the data when the widget is first created
    _searchController.addListener(() {
      _filterUsers(_searchController.text);
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Tìm kiếm...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(10.0),
              itemCount: _filteredUsers.length,
              itemBuilder: (context, index) => Card(
                key: ValueKey(_filteredUsers[index]["id"].toString()),
                color: Colors.green,
                elevation: 1,
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: ListTile(
                  leading: Icon(Icons.local_hospital, color: Colors.white),
                  title: Text(_filteredUsers[index]["title"].toString()),
                  titleTextStyle: const TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => department()),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
