import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // For loading assets
import 'dart:convert'; // For JSON decoding
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class department extends StatefulWidget {
  final String message;

  const department({Key? key, required this.message}) : super(key: key);

  @override
  State<department> createState() {
    // TODO: implement createState
    return departmentdetail();
  }
}

class departmentdetail extends State<department> {
  List<Map<String, dynamic>> _allUsers = [];
  List<Map<String, dynamic>> _filteredUsers = [];
  TextEditingController _searchController = TextEditingController();

  Future<void> _scanQRCode() async {
    try {
      String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        "#ff6666", // Màu của nút "Hủy"
        "Hủy", // Văn bản của nút "Hủy"
        true, // Hiển thị đèn flash
        ScanMode.BARCODE, // Quét mã vạch (có thể đổi thành ScanMode.QR)
      );

      if (barcodeScanRes != "-1") {
        setState(() {
          _searchController.text = barcodeScanRes;
          _filterUsers(barcodeScanRes); // Tìm kiếm dựa trên mã quét được
        });
      }
    } catch (e) {
      print("Lỗi khi quét mã: $e");
    }
  }

  // Method to load and parse the JSON data
  Future<void> _loadJsonData() async {
    // Load the data from the assets
    String jsonString = await rootBundle.loadString(
      'lib/JsonFile/Patient.json',
    );

    // Decode the JSON data into a List
    List<dynamic> jsonResponse = json.decode(jsonString);

    // Set the state with the loaded data
    setState(() {
      _allUsers =
          jsonResponse.map((item) {
            return {"id": item["id"], "Name": item["Name"], "Age": item["Age"]};
          }).toList();
      _filteredUsers = _allUsers;
    });
  }

  void _filterUsers(String query) {
    setState(() {
      _filteredUsers =
          _allUsers
              .where(
                (user) => user["id"].toString().toLowerCase().contains(
                  query.toLowerCase(),
                ),
              )
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
    // TODO: implement build
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text("khoa ${widget.message}")),
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
                padding: EdgeInsets.all(5),
                itemCount: _filteredUsers.length,
                itemBuilder:
                    (context, index) => Card(
                      key: ValueKey(_filteredUsers[index]["id"].toString()),
                      color: Colors.white,
                      elevation: 1,
                      margin: const EdgeInsets.symmetric(vertical: 1),
                      child: ListTile(
                        leading: Icon(Icons.verified_user, color: Colors.white),
                        title: ListTile(
                          leading: Icon(
                            Icons.person,
                            size: 40,
                            color: Colors.blue,
                          ),
                          // Icon ở bên trái
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            // Căn text về trái
                            children: [
                              Text("ID: ${_filteredUsers[index]["id"]}"),
                              Text("Name: ${_filteredUsers[index]["Name"]}"),
                              Text("Age: ${_filteredUsers[index]["Age"]}"),
                            ],
                          ),
                        ),
                        titleTextStyle: const TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) => department(
                                    message:
                                        _filteredUsers[index]["title"]
                                            .toString(),
                                  ),
                            ),
                          );
                        },
                      ),
                    ),
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _scanQRCode, // Gọi hàm quét mã
          backgroundColor: Colors.blue,
          child: Icon(Icons.qr_code_scanner, color: Colors.white),
        ),
      ),
    );
  }
}
