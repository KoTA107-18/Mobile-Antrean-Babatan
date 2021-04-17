import 'package:flutter/material.dart';

import 'screen/antreScreen.dart';
import 'screen/dashboardScreen.dart';
import 'screen/loginScreen.dart';
import 'screen/poliklinikScreen.dart';
import 'screen/profilScreen.dart';
import 'screen/riwayatScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: Login(),
    );
  }
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  int selectedIndex = 0;
  final screenList = [Dashboard(), Poliklinik(), Antre(), Riwayat(), Profil()];

  void onTappedItem(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: screenList.elementAt(selectedIndex),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: selectedIndex,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Beranda'),
            BottomNavigationBarItem(
                icon: Icon(Icons.local_hospital), label: 'Poliklinik'),
            BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Antre'),
            BottomNavigationBarItem(
                icon: Icon(Icons.history), label: 'Riwayat'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
          ],
          selectedLabelStyle: TextStyle(fontSize: 14.0),
          selectedItemColor: Colors.green,
          onTap: onTappedItem,
        ));
  }
}
