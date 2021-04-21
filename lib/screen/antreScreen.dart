import 'package:flutter/material.dart';
import 'package:mobile_antrean_babatan/utils/color.dart';

class Antre extends StatefulWidget {
  @override
  _AntreState createState() => _AntreState();
}

class _AntreState extends State<Antre> with SingleTickerProviderStateMixin {
  TabController controller;

  @override
  void initState() {
    super.initState();
    controller = TabController(vsync: this, length: 2);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.add),
        title: Text("Pendaftaran Antrean"),
        bottom: TabBar(
          controller: controller,
          tabs: <Widget>[
            Tab(
              text: 'Hari Ini',
            ),
            Tab(
              text: 'Hari Lain',
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: controller,
        children: <Widget>[
          HariIni(controller),
          HariLain(),
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class HariIni extends StatefulWidget {
  TabController controller;
  HariIni(this.controller);
  @override
  _HariIniState createState() => _HariIniState();
}

class _HariIniState extends State<HariIni> {
  int _radioValue = 0;
  final List Poli = [
    "Poliklinik Gigi",
    "Poliklinik Anak",
    "Poliklinik THT",
    "Poliklinik Lansia",
    "Poliklinik Umum"
  ];

  void _handleRadioValueChange(int value) {
    setState(() {
      _radioValue = value;

      switch (_radioValue) {
        case 0:
          break;
        case 1:
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
            child: DropdownButtonFormField(
              decoration: InputDecoration(
                  labelText: "Poli Tujuan",
                  prefixIcon: Icon(Icons.local_hospital),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.0))),
              //value: atasan,
              items: Poli.map((value) {
                return DropdownMenuItem(
                  child: Text(value),
                  value: value,
                );
              }).toList(),
              onChanged: (value) {
                //kata.atasan = value;
              },
            ),
          ),
          new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              new Radio(
                value: 0,
                groupValue: _radioValue,
                onChanged: _handleRadioValueChange,
              ),
              new Text(
                'Umum',
                style: new TextStyle(fontSize: 16.0),
              ),
              new Radio(
                value: 1,
                groupValue: _radioValue,
                onChanged: _handleRadioValueChange,
              ),
              new Text(
                'BPJS',
                style: new TextStyle(
                  fontSize: 16.0,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "Apa yang anda rasakan?",
              style: TextStyle(fontSize: 18.0),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(16.0, 0, 16.0, 0.0),
            child: TextField(
                controller: null,
                decoration: InputDecoration(
                    hintText: "Isi keluhan yang anda rasakan (Mis. Batuk)",
                    labelText: "Keluhan Anda",
                    prefixIcon: Icon(Icons.question_answer),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16.0)))),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
            child: InkWell(
              onTap: () {},
              child: Container(
                height: 40.0,
                child: Material(
                  borderRadius: BorderRadius.circular(20.0),
                  color: ColorTheme.greenDark,
                  elevation: 7.0,
                  child: Center(
                    child: Text(
                      'Daftar',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class HariLain extends StatefulWidget {
  @override
  _HariLainState createState() => _HariLainState();
}

class _HariLainState extends State<HariLain> {
  int _radioValue = 0;
  final List Poli = [
    "Poliklinik Gigi",
    "Poliklinik Anak",
    "Poliklinik THT",
    "Poliklinik Lansia",
    "Poliklinik Umum"
  ];
  final List Jam = [
    "09.00 - 10.00 WIB",
    "10.00 - 11.00 WIB",
    "11.00 - 12.00 WIB",
    "12.00 - 13.00 WIB",
    "13.00 - 14.00 WIB"
  ];

  void _handleRadioValueChange(int value) {
    setState(() {
      _radioValue = value;

      switch (_radioValue) {
        case 0:
          break;
        case 1:
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
            child: DropdownButtonFormField(
              decoration: InputDecoration(
                  labelText: "Poli Tujuan",
                  prefixIcon: Icon(Icons.local_hospital),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.0))),
              //value: atasan,
              items: Poli.map((value) {
                return DropdownMenuItem(
                  child: Text(value),
                  value: value,
                );
              }).toList(),
              onChanged: (value) {
                //kata.atasan = value;
              },
            ),
          ),
          new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              new Radio(
                value: 0,
                groupValue: _radioValue,
                onChanged: _handleRadioValueChange,
              ),
              new Text(
                'Umum',
                style: new TextStyle(fontSize: 16.0),
              ),
              new Radio(
                value: 1,
                groupValue: _radioValue,
                onChanged: _handleRadioValueChange,
              ),
              new Text(
                'BPJS',
                style: new TextStyle(
                  fontSize: 16.0,
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.fromLTRB(16.0, 0, 16.0, 16.0),
            child: TextField(
                controller: null,
                decoration: InputDecoration(
                    labelText: "Tanggal Booking",
                    prefixIcon: Icon(Icons.question_answer),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16.0)))),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
            child: DropdownButtonFormField(
              decoration: InputDecoration(
                  labelText: "Pilih Jam Booking",
                  prefixIcon: Icon(Icons.local_hospital),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.0))),
              //value: atasan,
              items: Jam.map((value) {
                return DropdownMenuItem(
                  child: Text(value),
                  value: value,
                );
              }).toList(),
              onChanged: (value) {
                //kata.atasan = value;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
            child: InkWell(
              onTap: () {},
              child: Container(
                height: 40.0,
                child: Material(
                  borderRadius: BorderRadius.circular(20.0),
                  color: ColorTheme.greenDark,
                  elevation: 7.0,
                  child: Center(
                    child: Text(
                      'Daftar',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
