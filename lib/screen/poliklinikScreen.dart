import 'package:flutter/material.dart';

class Poliklinik extends StatefulWidget {
  @override
  _PoliklinikState createState() => _PoliklinikState();
}

class _PoliklinikState extends State<Poliklinik> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Poliklinik"),
      ),
      body: Center(
        child: Text("Halaman Daftar Poliklinik"),
      ),
    );
  }
}
