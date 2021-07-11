import 'package:flutter/material.dart';
import 'package:mobile_antrean_babatan/dataLayer/model/InfoPoliklinik.dart';

class DetailPoliklinikScreen extends StatefulWidget {
  InfoPoliklinik poli;
  DetailPoliklinikScreen(this.poli);

  @override
  _DetailPoliklinikScreenState createState() => _DetailPoliklinikScreenState();
}

class _DetailPoliklinikScreenState extends State<DetailPoliklinikScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.local_hospital),
        title: Text(widget.poli.namaPoli.toString()),
      ),
      body: Center(
        child: Text("Halaman Detail Poliklinik"),
      ),
    );
  }
}
