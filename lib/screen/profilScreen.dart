import 'package:flutter/material.dart';
import 'package:mobile_antrean_babatan/screen/loginScreen.dart';

class Profil extends StatefulWidget {
  @override
  _ProfilState createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profil"),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text(
            'Logout',
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => Login()));
          },
        ),
      ),
    );
  }
}
