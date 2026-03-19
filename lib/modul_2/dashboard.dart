import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Dashboard(),
    );
  }
}

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard"),
        centerTitle: true,
      ),
      body: Column(
        children: [

          // ✅ CONTAINER DI DALAM COLUMN
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16),
            color: Colors.blue,
            child: Text(
              "Selamat Datang",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),

          SizedBox(height: 10),

          // ✅ ROW
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(Icons.home, size: 40),
              Icon(Icons.person, size: 40),
              Icon(Icons.settings, size: 40),
            ],
          ),

          SizedBox(height: 20),

          // ✅ STACK
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 200,
                height: 100,
                color: Colors.grey[300],
              ),
              Text("Ini Stack"),
            ],
          ),

          SizedBox(height: 20),

          // ✅ GRIDVIEW
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              children: [
                Card(child: Center(child: Text("Menu 1"))),
                Card(child: Center(child: Text("Menu 2"))),
                Card(child: Center(child: Text("Menu 3"))),
                Card(child: Center(child: Text("Menu 4"))),
              ],
            ),
          ),

          // ✅ LISTVIEW (dibuat kecil supaya tidak bentrok Expanded)
          Container(
            height: 100,
            child: ListView(
              children: [
                ListTile(title: Text("Item 1")),
                ListTile(title: Text("Item 2")),
                ListTile(title: Text("Item 3")),
              ],
            ),
          ),
        ],
      ),
    );
  }
}