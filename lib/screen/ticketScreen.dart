import 'package:flutter/material.dart';
import 'package:flutter_ticket_widget/flutter_ticket_widget.dart';
import 'package:mobile_antrean_babatan/utils/color.dart';

class Eticket extends StatefulWidget {
  @override
  _EticketState createState() => _EticketState();
}

class _EticketState extends State<Eticket> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[100],
      appBar: AppBar(
        leading: Icon(Icons.card_membership),
        title: Text("E-Ticket Pendaftaran"),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 8.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Container(
                  width: 60.0,
                  padding: EdgeInsets.all(8.0),
                  child: Image.asset('asset/LogoPuskesmas.png'),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Center(
                      child: Text('UPT Puskesmas Babatan.',
                          style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.teal)),
                    ),
                  ),
                  Container(
                    child: Center(
                      child: Text('Jl. Babatan No.4, Kec. Andir, Bandung.',
                          style: TextStyle(fontSize: 16.0, color: Colors.teal)),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 8.0,
          ),
          Center(
            child: FlutterTicketWidget(
              width: 350.0,
              height: 400.0,
              isCornerRounded: true,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: 120.0,
                      height: 25.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0),
                        border:
                            Border.all(width: 1.0, color: ColorTheme.greenDark),
                      ),
                      child: Center(
                        child: Text(
                          'Poliklinik Gigi',
                          style: TextStyle(color: ColorTheme.greenDark),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, left: 12.0),
                      child: Text(
                        '#24',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Column(
                        children: <Widget>[
                          ticketDetailsWidget('Nama Lengkap', 'LUTHFI ANDI',
                              'Tanggal Lahir', '15 Januari 1990'),
                          SizedBox(
                            height: 8.0,
                          ),
                          ticketDetailsWidget(
                              'Kepala Keluarga', 'YOGA SAPUTRA', '', ''),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 64.0,
                    ),
                    Center(child: Text('Tanggal Pelayanan')),
                    SizedBox(
                      height: 8.0,
                    ),
                    Center(
                        child: Text('20 April 2021',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0))),
                    Padding(
                      padding: const EdgeInsets.only(top: 24.0),
                      child: Column(
                        children: <Widget>[
                          ticketDetailsWidget('Nomor Antrean', '23',
                              'Estimasi Pelayanan', '12:05 WIB'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Text(
              "Jangan lupa membawa dokumen pendukung seperti KTP, KK, BPJS dan lain sebagainya",
              textAlign: TextAlign.center,
              style: TextStyle(color: ColorTheme.greenDark, fontSize: 14.0),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: InkWell(
              onTap: () {},
              child: Container(
                height: 40.0,
                child: Material(
                  borderRadius: BorderRadius.circular(20.0),
                  color: Colors.red,
                  elevation: 7.0,
                  child: Center(
                    child: Text(
                      'Batalkan',
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

  Widget ticketDetailsWidget(String firstTitle, String firstDesc,
      String secondTitle, String secondDesc) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                firstTitle,
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Text(
                  firstDesc,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0),
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                secondTitle,
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Text(
                  secondDesc,
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}

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
