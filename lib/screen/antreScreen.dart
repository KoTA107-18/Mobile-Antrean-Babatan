import 'package:flutter/material.dart';

class Antre extends StatefulWidget {
  @override
  _AntreState createState() => _AntreState();
}

class _AntreState extends State<Antre> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Daftar Antrean"),
      ),
      body: Center(
        child: Text("Halaman Tambah Antrean"),
      ),
    );
  }
}
