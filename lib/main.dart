import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:mobile_antrean_babatan/blocLayer/navbar/navbar_bloc.dart';
import 'package:mobile_antrean_babatan/presentationLayer/splashScreen.dart';
import 'package:mobile_antrean_babatan/utils/color.dart';

import 'presentationLayer/antreScreen.dart';
import 'presentationLayer/dashboardScreen.dart';
import 'presentationLayer/kartuAntreanScreen.dart';
import 'presentationLayer/profilScreen.dart';
import 'presentationLayer/riwayatScreen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
      home: FirebaseInitialization(),
    );
  }
}

class FirebaseInitialization extends StatefulWidget {
  @override
  _FirebaseInitializationState createState() => _FirebaseInitializationState();
}

class _FirebaseInitializationState extends State<FirebaseInitialization> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        // Initialize FlutterFire:
        future: _initialization,
        builder: (context, snapshot) {
          // Check for errors
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }
          // Once complete, show your application
          if (snapshot.connectionState == ConnectionState.done) {
            return SplashScreen();
          }
          // Otherwise, show something whilst waiting for initialization to complete
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  final screenList = [
    Dashboard(),
    KartuAntreanScreen(),
    Antre(),
    Riwayat(),
    Profil()
  ];
  final NavbarBloc navbarBloc = NavbarBloc(0);
  FlutterLocalNotificationsPlugin fltrNotification;

  @override
  void initState() {
    super.initState();
    var androidInitilize = new AndroidInitializationSettings('app_icon');
    var iOSinitilize = new IOSInitializationSettings();
    var initilizationsSettings =
    new InitializationSettings(android: androidInitilize, iOS: iOSinitilize);
    fltrNotification = new FlutterLocalNotificationsPlugin();
    fltrNotification.initialize(initilizationsSettings,
        onSelectNotification: notificationSelected);
  }

  Future notificationSelected(String payload) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text("Notification : $payload"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => navbarBloc,
      child: BlocBuilder<NavbarBloc, int>(
        bloc: navbarBloc,
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
