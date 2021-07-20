import 'package:flutter/material.dart';
import 'package:flutter_ticket_widget/flutter_ticket_widget.dart';
import 'package:mobile_antrean_babatan/dataLayer/model/JadwalPasien.dart';
import 'package:mobile_antrean_babatan/dataLayer/model/kartuAntrean.dart';
import 'package:mobile_antrean_babatan/utils/color.dart';

class KartuRiwayatScreen extends StatefulWidget {
  KartuAntrean jadwalPasien;
  KartuRiwayatScreen(this.jadwalPasien);

  @override
  _KartuRiwayatScreenState createState() => _KartuRiwayatScreenState();
}

class _KartuRiwayatScreenState extends State<KartuRiwayatScreen> {
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

  ListView kartuAntrean(KartuAntrean jadwalPasien) {
    return ListView(
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
                            color: ColorTheme.greenDark)),
                  ),
                ),
                Container(
                  child: Center(
                    child: Text('Jl. Babatan No.4, Kec. Andir, Bandung.',
                        style: TextStyle(
                            fontSize: 16.0, color: ColorTheme.greenDark)),
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
                    width: 150.0,
                    height: 25.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                      border:
                          Border.all(width: 1.0, color: ColorTheme.greenDark),
                    ),
                    child: Center(
                      child: Text(
                        jadwalPasien.poliklinik.namaPoli,
                        style: TextStyle(color: ColorTheme.greenDark),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, left: 12.0),
                    child: Text(
                      '#' + jadwalPasien.idPasien.toString(),
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
                        ticketDetailsWidget(
                            'Nama Lengkap',
                            jadwalPasien.pasien.namaLengkap,
                            'Tanggal Lahir',
                            jadwalPasien.pasien.tglLahir),
                        SizedBox(
                          height: 8.0,
                        ),
                        ticketDetailsWidget('Kepala Keluarga',
                            jadwalPasien.pasien.kepalaKeluarga, '', ''),
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
                      child: Text(jadwalPasien.tglPelayanan,
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0))),
                  Padding(
                    padding: const EdgeInsets.only(top: 24.0),
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(left: 12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    "Nomor Antrean",
                                    style: TextStyle(
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 4.0),
                                    child: Text(
                                      (jadwalPasien.nomorAntrean == null)
                                          ? 0.toString()
                                          : jadwalPasien.nomorAntrean
                                              .toString(),
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 24.0),
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
                                    "Jam Pelayanan",
                                    style: TextStyle(
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 4.0),
                                    child: Text(
                                      "± " +
                                          jadwalPasien.jamBooking.toString() +
                                          " WIB",
                                      style: TextStyle(
                                        fontSize: 24.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.teal[50],
        appBar: AppBar(
          leading: Icon(Icons.card_membership),
          title: Text("Kartu Antre"),
        ),
        body: kartuAntrean(widget.jadwalPasien));
  }
}
