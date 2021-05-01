import 'package:flutter/material.dart';
import 'package:flutter_ticket_widget/flutter_ticket_widget.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobile_antrean_babatan/repositories/api/api.dart';
import 'package:mobile_antrean_babatan/repositories/model/ticket.dart';
import 'package:mobile_antrean_babatan/repositories/session/sharedPref.dart';
import 'package:mobile_antrean_babatan/utils/color.dart';
import 'package:mobile_antrean_babatan/utils/loading.dart';

class Eticket extends StatefulWidget {
  @override
  _EticketState createState() => _EticketState();
}

class _EticketState extends State<Eticket> {
  String usernameUser;
  Future getTicket() async {
    String username = await SharedPref.getUsername();
    usernameUser = username;
    return RequestApi.getTicket(username);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorTheme.greenLight,
        appBar: AppBar(
          leading: Icon(Icons.card_membership),
          title: Text("E-Ticket Pendaftaran"),
        ),
        body: FutureBuilder(
            future: getTicket(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
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
                                child: Text(
                                    'Jl. Babatan No.4, Kec. Andir, Bandung.',
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        color: ColorTheme.greenDark)),
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
                                  border: Border.all(
                                      width: 1.0, color: ColorTheme.greenDark),
                                ),
                                child: Center(
                                  child: Text(
                                    snapshot.data[0]["id_poli"].toString(),
                                    style:
                                        TextStyle(color: ColorTheme.greenDark),
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 8.0, left: 12.0),
                                child: Text(
                                  '#' +
                                      snapshot.data[0]["kode_antrean"]
                                          .toString(),
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
                                    ticketDetailsWidget('Nama Lengkap',
                                        'Unknown', 'Tanggal Lahir', 'Unknown'),
                                    SizedBox(
                                      height: 8.0,
                                    ),
                                    ticketDetailsWidget(
                                        'Kepala Keluarga', 'Unknown', '', ''),
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
                                  child: Text(
                                      snapshot.data[0]["tgl_pelayanan"]
                                          .toString(),
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18.0))),
                              Padding(
                                padding: const EdgeInsets.only(top: 24.0),
                                child: Column(
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 12.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                "Nomor Antrean",
                                                style: TextStyle(
                                                  color: Colors.grey,
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 4.0),
                                                child: Text(
                                                  "-",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 24.0),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              right: 20.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                "Estimasi Pelayanan",
                                                style: TextStyle(
                                                  color: Colors.grey,
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 4.0),
                                                child: Text(
                                                  "NN:NN WIB",
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
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                      child: InkWell(
                        onTap: () {
                          Ticket ticket = Ticket(
                              username: usernameUser,
                              idJadwal: snapshot.data[0]["id_jadwal"],
                              idPoli: snapshot.data[0]["id_poli"],
                              kodeAntrean: snapshot.data[0]["kode_antrean"],
                              tipeBooking:
                                  (snapshot.data[0]["tipe_booking"] == 1)
                                      ? true
                                      : false,
                              tglPelayanan: snapshot.data[0]["tgl_pelayanan"],
                              jamMulaiDilayani: snapshot.data[0]
                                  ["jam_mulai_dilayani"],
                              jamSelesaiDilayani: snapshot.data[0]
                                  ["jam_selesai_dilayani"],
                              statusAntrean: 4);
                          _showMaterialDialog(ticket);
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
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                );
              }
              if ((snapshot.connectionState == ConnectionState.done) &&
                  (snapshot.data == null)) {
                return Center(
                  child: Text("Anda belum mengambil tiket"),
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }));
  }

  _showMaterialDialog(Ticket ticket) {
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
                    loading(context);
                    RequestApi.updateStatusTicket(ticket).then((value) {
                      Navigator.pop(context);
                      (value)
                          ? Fluttertoast.showToast(
                              backgroundColor: ColorTheme.greenDark,
                              msg: "Cancel berhasil!",
                              toastLength: Toast.LENGTH_LONG)
                          : Fluttertoast.showToast(
                              backgroundColor: ColorTheme.greenDark,
                              msg: "Cancel Gagal!",
                              toastLength: Toast.LENGTH_LONG);
                    }).catchError((e) {
                      Fluttertoast.showToast(
                          backgroundColor: ColorTheme.greenDark,
                          msg: e.toString(),
                          toastLength: Toast.LENGTH_LONG);
                    });
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
}
