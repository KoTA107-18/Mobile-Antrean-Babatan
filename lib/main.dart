import 'package:flutter/material.dart';
import 'package:mobile_antrean_babatan/screen/loginScreen.dart';
import 'package:mobile_antrean_babatan/utils/color.dart';

import 'screen/antreScreen.dart';
import 'screen/dashboardScreen.dart';
import 'screen/ticketScreen.dart';
import 'screen/profilScreen.dart';
import 'screen/riwayatScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
  int selectedIndex = 1;
  final screenList = [Dashboard(), Eticket(), Antre(), Riwayat(), Profil()];

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
                icon: Icon(Icons.card_membership), label: 'E-Ticket'),
            BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Antre'),
            BottomNavigationBarItem(
                icon: Icon(Icons.history), label: 'Riwayat'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
          ],
          selectedLabelStyle: TextStyle(fontSize: 14.0),
          selectedItemColor: ColorTheme.greenDark,
          onTap: onTappedItem,
        ));
  }
}
