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
      body: ListView(
        children: [
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Card(
                  child: Container(
                      padding: EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Antrean Tersisa',
                                style: TextStyle(
                                    fontSize: 16.0),
                              ),
                              Text(
                                '125',
                                style: TextStyle(
                                    fontSize: 24.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Icon(
                            Icons.bar_chart,
                            size: 36,
                          )
                        ],
                      )),
                ),
              ),
              Expanded(
                flex: 1,
                child: Card(
                  child: Container(
                      padding: EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Antrean Saat Ini',
                                style: TextStyle(
                                    fontSize: 16.0),
                              ),
                              Text(
                                '5',
                                style: TextStyle(
                                    fontSize: 24.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Icon(
                            Icons.info_outline,
                            size: 36,
                          )
                        ],
                      )),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
