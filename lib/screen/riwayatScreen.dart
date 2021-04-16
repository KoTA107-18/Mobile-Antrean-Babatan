import 'package:flutter/material.dart';

class Riwayat extends StatefulWidget {
  @override
  _RiwayatState createState() => _RiwayatState();
}

class _RiwayatState extends State<Riwayat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Riwayat Antrean"),
      ),
      body: Center(
        child: Text("Halaman Riwayat Antrean"),
      ),
    );
  }
}
