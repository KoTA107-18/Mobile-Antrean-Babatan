import 'package:flutter/material.dart';
import 'package:mobile_antrean_babatan/utils/color.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
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
      appBar: AppBar(
        leading: Icon(Icons.home),
        title: Text("Daftar Poliklinik"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(left: 20.0, top: 20.0),
            child: Text('Bagaimana Kabar Anda?',
                style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: ColorTheme.greenDark)),
          ),
          Container(
            padding: EdgeInsets.only(left: 20.0, bottom: 20.0),
            child: Text(
                'Untuk melakukan pendaftaran di Puskesmas Babatan, silahkan tekan tombol Daftar',
                style: TextStyle(fontSize: 16.0, color: ColorTheme.greenDark)),
          ),
          Expanded(
            child: Container(
              color: ColorTheme.greenLight,
              child: ListView.builder(
                  itemCount: names.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        margin:
                            EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Poliklinik Umum",
                                    style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text("Nomor Antrian saat ini : 4",
                                      style: TextStyle(fontSize: 16.0)),
                                ],
                              ),
                            ),
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
                                    Text("Saat Ini"),
                                    Text("20",
                                        style: TextStyle(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ));
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
