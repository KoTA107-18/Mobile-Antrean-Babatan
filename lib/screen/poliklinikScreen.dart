import 'package:flutter/material.dart';

class Poliklinik extends StatefulWidget {
  @override
  _PoliklinikState createState() => _PoliklinikState();
}

class _PoliklinikState extends State<Poliklinik> {
  final List daftarPoli = [
    [
      Icon(Icons.alarm),
      "Poliklinik Umum.",
    ],
    [
      Icon(Icons.question_answer),
      "Poliklinik Ibu dan Anak.",
    ],
    [
      Icon(Icons.chat),
      "Poliklinik Gigi.",
    ],
    [
      Icon(Icons.check),
      "Poliklinik THT.",
    ],
    [
      Icon(Icons.mark_chat_read_rounded),
      "Poliklinik Gigi.",
    ],
    [
      Icon(Icons.message),
      "Poliklinik Lansia.",
    ],
    [
      Icon(Icons.account_circle),
      "Poliklinik Konsultasi Gizi.",
    ],
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Daftar Poliklinik"),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.all(16.0),
              width: MediaQuery.of(context).size.width,
              child: GridView.builder(
                itemCount: daftarPoli.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 4.0,
                    mainAxisSpacing: 4.0),
                itemBuilder: (context, index) {
                  return optionList(daftarPoli[index]);
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  Padding optionList(List data) {
    return Padding(
      padding: const EdgeInsets.only(right: 4.0),
      child: InkWell(
        child: Card(
          child: Container(
            margin: EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                data[0],
                Text(
                  data[1],
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          ),
        ),
        onTap: () {},
      ),
    );
  }
}
