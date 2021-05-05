import 'package:flutter/material.dart';
import 'package:mobile_antrean_babatan/utils/color.dart';

class Riwayat extends StatefulWidget {
  @override
  _RiwayatState createState() => _RiwayatState();
}

class _RiwayatState extends State<Riwayat> {
  final List<String> names = <String>[
    'Manish',
    'Jitender',
    'Pankaj',
    'Aarti',
    'Nighat',
    'Mohit',
    'Ruchika',
    'Nighat',
    'Mohit',
    'Ruchika',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.teal[50],
        appBar: AppBar(
          leading: Icon(Icons.history),
          title: Text("Riwayat Antrean"),
        ),
        body: ListView.builder(
            itemCount: names.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  margin: EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: ColorTheme.greenLight,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          height: 75,
                          width: 75,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Kode"),
                              Text("20",
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Poliklinik Umum",
                            style: TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.bold),
                          ),
                          Text("Tanggal Pelayanan : 20 April 2021",
                              style: TextStyle(fontSize: 16.0)),
                          Text("Status : Selesai"),
                        ],
                      )
                    ],
                  ));
            }));
  }
}
