import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobile_antrean_babatan/model/poliklinik.dart';
import 'package:mobile_antrean_babatan/model/ticket.dart';
import 'package:mobile_antrean_babatan/network/api.dart';
import 'package:mobile_antrean_babatan/session/sharedPref.dart';
import 'package:mobile_antrean_babatan/utils/color.dart';
import 'package:mobile_antrean_babatan/utils/loading.dart';
import 'package:mobile_antrean_babatan/utils/textFieldModified.dart';

class Antre extends StatefulWidget {
  @override
  _AntreState createState() => _AntreState();
}

class _AntreState extends State<Antre> {
  bool isBooking = false;
  int _radioValue = 0;
  DateTime selectedDate = DateTime.now();
  TextEditingController _tglBooking = TextEditingController();
  Poliklinik _poliTujuan;

  final List jam = [
    "09.00 - 10.00 WIB",
    "10.00 - 11.00 WIB",
    "11.00 - 12.00 WIB",
    "12.00 - 13.00 WIB",
    "13.00 - 14.00 WIB"
  ];

  void _handleRadioValueChange(int value) {
    setState(() {
      _radioValue = value;
      _poliTujuan = null;
      switch (_radioValue) {
        case 0:
          break;
        case 1:
          break;
      }
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: new DateTime(
            DateTime.now().year, DateTime.now().month, DateTime.now().day + 7));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.add),
        title: Text("Pendaftaran Antrean"),
      ),
      body: FutureBuilder(
        future: RequestApi.getAllPoliklinik(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var resultSnapshot = snapshot.data as List;
            List<Poliklinik> daftarPoli = resultSnapshot
                .map((aJson) => Poliklinik.fromJson(aJson))
                .toList();
            return ListView(
              children: [
                Center(
                  child: Container(
                    padding: EdgeInsets.only(left: 20.0, top: 20.0),
                    child: (isBooking)
                        ? Text('Booking Antrean',
                            style: TextStyle(
                                fontSize: 22.0,
                                fontWeight: FontWeight.bold,
                                color: ColorTheme.greenDark))
                        : Text('Antre Pendaftaran Hari Ini',
                            style: TextStyle(
                                fontSize: 22.0,
                                fontWeight: FontWeight.bold,
                                color: ColorTheme.greenDark)),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
                  child: DropdownButtonFormField(
                    decoration: InputDecoration(
                        labelText: "Poli Tujuan",
                        prefixIcon: Icon(Icons.local_hospital),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16.0))),
                    value: daftarPoli[0],
                    items: daftarPoli.map((value) {
                      return DropdownMenuItem(
                        child: Text(value.nama_poli),
                        value: value,
                      );
                    }).toList(),
                    onChanged: (value) {
                      _poliTujuan = value;
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
                (isBooking)
                    ? Container(
                        padding: EdgeInsets.fromLTRB(16.0, 0, 16.0, 16.0),
                        child: Row(
                          children: [
                            Flexible(
                              child: textFieldModified(
                                  isEnabled: false,
                                  label: 'Tanggal Lahir',
                                  icon: Icon(Icons.date_range),
                                  controller: null),
                            ),
                            SizedBox(width: 16.0),
                            ElevatedButton(
                                onPressed: () {
                                  _selectDate(context).then((value) {
                                    setState(() {
                                      _tglBooking.text =
                                          "${selectedDate.year.toString()}-${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.day.toString().padLeft(2, '0')}";
                                    });
                                  });
                                },
                                child: Icon(Icons.date_range))
                          ],
                        ),
                      )
                    : SizedBox.shrink(),
                (isBooking)
                    ? Container(
                        padding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
                        child: DropdownButtonFormField(
                          decoration: InputDecoration(
                              labelText: "Pilih Jam Booking",
                              prefixIcon: Icon(Icons.local_hospital),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16.0))),
                          //value: atasan,
                          items: jam.map((value) {
                            return DropdownMenuItem(
                              child: Text(value),
                              value: value,
                            );
                          }).toList(),
                          onChanged: (value) {
                            //kata.atasan = value;
                          },
                        ),
                      )
                    : SizedBox.shrink(),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                  child: InkWell(
                    onTap: () {
                      if (isBooking) {
                        // Jika melakukan booking.
                      } else {
                        // Jika tidak melakukan booking.
                        // Jika semua form telah diisi.
                        if (_poliTujuan != null && _radioValue != null) {
                          // Jika semua telah diisi.
                          if (_poliTujuan.status_poli == 1) {
                            // Jika poli dalam keadaan membuka pendaftaran.
                            loading(context);
                            SharedPref.getUsername().then((value) {
                              DateTime dateNow = DateTime.now();
                              String tanggal =
                                  "${dateNow.year.toString()}-${dateNow.month.toString().padLeft(2, '0')}-${dateNow.day.toString().padLeft(2, '0')}";
                              Ticket tiket = Ticket(
                                  username: value.toString(),
                                  id_jadwal: null,
                                  id_poli: _poliTujuan.id_poli,
                                  kode_antrean: null,
                                  tipe_booking: isBooking,
                                  tgl_pelayanan: tanggal.toString(),
                                  jam_mulai_dilayani: "NULL",
                                  jam_selesai_dilayani: "NULL",
                                  status_antrean: 1);
                              RequestApi.registerAntreanHariIni(tiket)
                                  .then((value) {
                                Navigator.pop(context);
                                if (value) {
                                  Fluttertoast.showToast(
                                      backgroundColor: ColorTheme.greenDark,
                                      msg:
                                          "Pendaftaran berhasil, silahkan cek E-Ticket!",
                                      toastLength: Toast.LENGTH_LONG);
                                } else {
                                  Fluttertoast.showToast(
                                      backgroundColor: ColorTheme.greenDark,
                                      msg: "Pendaftaran gagal!",
                                      toastLength: Toast.LENGTH_LONG);
                                }
                              });
                            });
                          } else {
                            // Jika poli tidak dalam keadaan membuka pendaftaran.
                            Fluttertoast.showToast(
                                backgroundColor: ColorTheme.greenDark,
                                msg:
                                    "Maaf, Poliklinik sedang tidak membuka pendaftaran",
                                toastLength: Toast.LENGTH_LONG);
                          }
                        } else {
                          // Jika form ada yang tidak diisi.
                          Fluttertoast.showToast(
                              backgroundColor: ColorTheme.greenDark,
                              msg: "Mohon isi form dengan lengkap",
                              toastLength: Toast.LENGTH_LONG);
                        }
                      }
                    },
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
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        isBooking = !isBooking;
                      });
                    },
                    child: Container(
                      height: 40.0,
                      color: Colors.transparent,
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: ColorTheme.greenDark,
                                style: BorderStyle.solid,
                                width: 1.0),
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(20.0)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(width: 10.0),
                            Center(
                                child: (isBooking)
                                    ? Text('Daftar Antrean Hari Ini',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: ColorTheme.greenDark))
                                    : Text('Booking Antrean',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: ColorTheme.greenDark)))
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
