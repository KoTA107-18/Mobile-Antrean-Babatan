import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ticket_widget/flutter_ticket_widget.dart';
import 'package:lottie/lottie.dart';
import 'package:mobile_antrean_babatan/blocLayer/antrean/kartuAntrean/kartu_antrean_bloc.dart';
import 'package:mobile_antrean_babatan/dataLayer/model/kartuAntrean.dart';
import 'package:mobile_antrean_babatan/utils/color.dart';

class KartuAntreanScreen extends StatefulWidget {
  @override
  _KartuAntreanScreenState createState() => _KartuAntreanScreenState();
}

class _KartuAntreanScreenState extends State<KartuAntreanScreen> {
  KartuAntreanBloc _kartuAntreanBloc = KartuAntreanBloc();

  _showMaterialDialog(KartuAntrean ticket) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: Text("Cancel"),
              content: Text("Anda yakin cancel antrean?"),
              actions: <Widget>[
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: ColorTheme.greenDark, // background
                    onPrimary: Colors.white, // foreground
                  ),
                  child: Text(
                    'Ya',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    _kartuAntreanBloc.add(KartuAntreanEventCancelAntrean());
                  },
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.grey, // background
                    onPrimary: Colors.white, // foreground
                  ),
                  child: Text(
                    'Tidak',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ));
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

  ListView kartuAntrean(KartuAntrean jadwalPasien, String estimasi) {
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
                                    "Estimasi Pelayanan",
                                    style: TextStyle(
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 4.0),
                                    child: Text(
                                      "± " + estimasi.toString() + " WIB",
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
        Padding(
          padding: const EdgeInsets.all(24.0),
          child: Text(
            "Catatan : Jangan lupa membawa dokumen pendukung seperti KTP, KK, BPJS dan lain sebagainya",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: ColorTheme.greenDark,
                fontSize: 14.0,
                fontWeight: FontWeight.bold),
          ),
        ),
        (jadwalPasien.statusAntrean != 2)
            ? Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: InkWell(
                  onTap: () {
                    _showMaterialDialog(jadwalPasien);
                  },
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
            : SizedBox.shrink()
      ],
    );
  }

  @override
  void initState() {
    _kartuAntreanBloc.add(KartuAntreanEventGetKartu());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => _kartuAntreanBloc,
      child: BlocListener<KartuAntreanBloc, KartuAntreanState>(
        cubit: _kartuAntreanBloc,
        listener: (context, state) {
          if (state is KartuAntreanStateSuccess) {
            Timer.periodic(Duration(milliseconds: 5000), (timer) {
              _kartuAntreanBloc.add(KartuAntreanEventGetKartuSilent());
            });
          }
        },
        child: Scaffold(
            backgroundColor: Colors.teal[50],
            appBar: AppBar(
              leading: Icon(Icons.card_membership),
              title: Text("Kartu Antre"),
              actions: [
                IconButton(
                    icon: Icon(Icons.refresh),
                    onPressed: () {
                      _kartuAntreanBloc.add(KartuAntreanEventGetKartu());
                    })
              ],
            ),
            body: BlocBuilder<KartuAntreanBloc, KartuAntreanState>(
              cubit: _kartuAntreanBloc,
              builder: (context, state) {
                if (state is KartuAntreanStateSuccess) {
                  return kartuAntrean(state.kartuAntre, state.estimasi);
                } else if (state is KartuAntreanStateFailed) {
                  return Center(
                    child: Text(state.errMessage),
                  );
                } else if (state is KartuAntreanStateEmpty) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height / 4,
                        child: Lottie.asset(
                          'asset/not_found.json',
                          repeat: false,
                          reverse: false,
                          animate: true,
                        ),
                      ),
                      Center(
                        child: Text(state.message,
                            style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                                color: ColorTheme.greenDark)),
                      )
                    ],
                  );
                } else {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: CircularProgressIndicator(),
                      ),
                      SizedBox(height: 8.0),
                      Center(
                        child: Text('Tuggu sebentar ...',
                            style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                                color: ColorTheme.greenDark)),
                      )
                    ],
                  );
                }
              },
            )),
      ),
    );
  }
}
