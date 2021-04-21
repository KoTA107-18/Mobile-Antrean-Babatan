import 'package:flutter/material.dart';
import 'package:mobile_antrean_babatan/utils/color.dart';

class Riwayat extends StatefulWidget {
  @override
  _RiwayatState createState() => _RiwayatState();
}

class _RiwayatState extends State<Riwayat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorTheme.greenLight,
      appBar: AppBar(
        leading: Icon(Icons.history),
        title: Text("Riwayat Antrean"),
      ),
      body: Center(
        child: Text("Halaman Riwayat Antrean"),
      ),
    );
  }
}
