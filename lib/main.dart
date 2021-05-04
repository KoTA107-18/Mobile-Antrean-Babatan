import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_antrean_babatan/bloc/navbar/navbar_bloc.dart';
import 'package:mobile_antrean_babatan/screen/splashScreen.dart';
import 'package:mobile_antrean_babatan/utils/color.dart';

import 'screen/antreScreen.dart';
import 'screen/dashboardScreen.dart';
import 'screen/kartuAntreanScreen.dart';
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
      title: 'Antrean Puskesmas Babatan',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: SplashScreen(),
    );
  }
}

class App extends StatelessWidget {
  final screenList = [Dashboard(), KartuAntreanScreen(), Antre(), Riwayat(), Profil()];
  final NavbarBloc navbarBloc = NavbarBloc(0);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => navbarBloc,
      child: BlocBuilder<NavbarBloc, int>(
        builder: (context, index) {
          return Scaffold(
              body: screenList.elementAt(index),
              bottomNavigationBar: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                currentIndex: index,
                items: [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.home), label: 'Beranda'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.card_membership), label: 'Kartu Antre'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.add), label: 'Antre'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.history), label: 'Riwayat'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.person), label: 'Profil'),
                ],
                selectedLabelStyle: TextStyle(fontSize: 14.0),
                selectedItemColor: ColorTheme.greenDark,
                onTap: (index) {
                  if (index == 0) navbarBloc.add(NavbarEvent.goDashboard);
                  if (index == 1) navbarBloc.add(NavbarEvent.goTicket);
                  if (index == 2) navbarBloc.add(NavbarEvent.goAntre);
                  if (index == 3) navbarBloc.add(NavbarEvent.goRiwayat);
                  if (index == 4) navbarBloc.add(NavbarEvent.goProfil);
                },
              ));
        },
      ),
    );
  }
}
