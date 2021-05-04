import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobile_antrean_babatan/bloc/antre/booking_bloc.dart';
import 'package:mobile_antrean_babatan/bloc/antre/radio_bloc.dart';
import 'package:mobile_antrean_babatan/repositories/api/api.dart';
import 'package:mobile_antrean_babatan/repositories/model/poliklinik.dart';
import 'package:mobile_antrean_babatan/repositories/model/kartu.dart';
import 'package:mobile_antrean_babatan/repositories/session/sharedPref.dart';
import 'package:mobile_antrean_babatan/utils/color.dart';
import 'package:mobile_antrean_babatan/utils/loading.dart';
import 'package:mobile_antrean_babatan/utils/textFieldModified.dart';
import 'package:time_picker_widget/time_picker_widget.dart';

class Antre extends StatefulWidget {
  @override
  _AntreState createState() => _AntreState();
}

class _AntreState extends State<Antre> {
  final RadioBloc radioBloc = RadioBloc(0);
  final BookingBloc bookingBloc = BookingBloc(false);
  bool isBooking = false;
  int _radioValue = 0;
  DateTime selectedDate = DateTime.now();
  TextEditingController _tglBooking = TextEditingController();
  TextEditingController _timeBooking = TextEditingController();
  Poliklinik _poliTujuan;

  bool validateInput(bool isBooking) {
    if (isBooking) {
      return ((_radioValue != null) &&
          (_poliTujuan != null) &&
          (selectedDate != null) &&
          (_timeBooking != null));
    } else {
      return ((_radioValue != null) && (_poliTujuan != null));
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: new DateTime(
            DateTime.now().year, DateTime.now().month, DateTime.now().day + 7));
    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<RadioBloc>(create: (BuildContext context) => radioBloc),
          BlocProvider<BookingBloc>(
              create: (BuildContext context) => bookingBloc),
        ],
        child: Scaffold(
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
                        child: BlocBuilder<BookingBloc, bool>(
                            builder: (context, statusBooking) {
                          if (statusBooking) {
                            return Text('Booking Antrean',
                                style: TextStyle(
                                    fontSize: 22.0,
                                    fontWeight: FontWeight.bold,
                                    color: ColorTheme.greenDark));
                          } else {
                            return Text('Antre Pendaftaran Hari Ini',
                                style: TextStyle(
                                    fontSize: 22.0,
                                    fontWeight: FontWeight.bold,
                                    color: ColorTheme.greenDark));
                          }
                        }),
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
                        value: _poliTujuan,
                        items: daftarPoli.map((value) {
                          return DropdownMenuItem(
                            child: Text(value.namaPoli),
                            value: value,
                          );
                        }).toList(),
                        onChanged: (value) {
                          _poliTujuan = value;
                        },
                      ),
                    ),
                    BlocBuilder<RadioBloc, int>(
                        builder: (context, pilihanRadio) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          new Radio(
                            value: 0,
                            groupValue: pilihanRadio,
                            onChanged: (result) {
                              radioBloc.add(RadioEvent.jenisUmum);
                            },
                          ),
                          new Text(
                            'Umum',
                            style: new TextStyle(fontSize: 16.0),
                          ),
                          new Radio(
                            value: 1,
                            groupValue: pilihanRadio,
                            onChanged: (result) {
                              radioBloc.add(RadioEvent.jenisBPJS);
                            },
                          ),
                          new Text(
                            'BPJS',
                            style: new TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                        ],
                      );
                    }),
                    BlocBuilder<BookingBloc, bool>(
                        builder: (context, statusBooking) {
                      if (statusBooking) {
                        return Column(
                          children: [
                            Container(
                              padding: EdgeInsets.fromLTRB(16.0, 0, 16.0, 16.0),
                              child: Row(
                                children: [
                                  Flexible(
                                    child: textFieldModified(
                                        isEnabled: false,
                                        label: 'Tanggal Booking',
                                        icon: Icon(Icons.date_range),
                                        controller: _tglBooking),
                                  ),
                                  SizedBox(width: 16.0),
                                  ElevatedButton(
                                      onPressed: () {
                                        _selectDate(context).then((value) {
                                          _tglBooking.text =
                                              "${selectedDate.year.toString()}-${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.day.toString().padLeft(2, '0')}";
                                        });
                                      },
                                      child: Icon(Icons.date_range))
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.fromLTRB(16.0, 0, 16.0, 16.0),
                              child: Row(
                                children: [
                                  Flexible(
                                    child: textFieldModified(
                                        isEnabled: false,
                                        label: 'Pilih Jam Booking',
                                        icon: Icon(Icons.timer),
                                        controller: _timeBooking),
                                  ),
                                  SizedBox(width: 16.0),
                                  ElevatedButton(
                                      onPressed: () {
                                        showCustomTimePicker(
                                            context: context,
                                            // It is a must if you provide selectableTimePredicate
                                            onFailValidation: (context) =>
                                                print('Unavailable selection'),
                                            initialTime:
                                                TimeOfDay(hour: 11, minute: 0),
                                            selectableTimePredicate: (time) =>
                                                time.hour >= 8 &&
                                                time.hour < 15 &&
                                                time.minute % 10 ==
                                                    0).then((time) => _timeBooking
                                                .text =
                                            "${time?.hour.toString().padLeft(2, '0')}:${time?.minute.toString().padLeft(2, '0')}");
                                      },
                                      child: Icon(Icons.timer))
                                ],
                              ),
                            )
                          ],
                        );
                      } else {
                        return SizedBox.shrink();
                      }
                    }),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                      child: InkWell(
                        onTap: () {
                          String username;
                          if (validateInput(isBooking)) {
                            loading(context);
                            String daftarAntrean = "${DateTime.now().hour.toString().padLeft(2, '0')}:${DateTime.now().minute.toString().padLeft(2, '0')}";
                            if (isBooking) {
                              SharedPref.getUsername().then((value) {
                                username = value;
                                RequestApi.checkAlreadyRegisterQueue(value)
                                    .then((value) {
                                  if (value == false) {
                                    // Belum ambil antrean.
                                    KartuAntre tiket = KartuAntre(
                                        idPoli: _poliTujuan.idPoli,
                                        idHari: selectedDate.weekday,
                                        username: username.toString(),
                                        nomorAntrean: null,
                                        tipeBooking: isBooking,
                                        tglPelayanan: _tglBooking.text,
                                        jamDaftarAntrean: daftarAntrean,
                                        jamMulaiDilayani: "NULL",
                                        jamSelesaiDilayani: "NULL",
                                        statusAntrean: 1);
                                    RequestApi.registerAntreanHariIni(tiket)
                                        .then((value) {
                                      Navigator.pop(context);
                                      if (value) {
                                        Fluttertoast.showToast(
                                            backgroundColor:
                                                ColorTheme.greenDark,
                                            msg:
                                                "Pendaftaran berhasil, silahkan cek E-Ticket!",
                                            toastLength: Toast.LENGTH_LONG);
                                      } else {
                                        Fluttertoast.showToast(
                                            backgroundColor:
                                                ColorTheme.greenDark,
                                            msg:
                                                "Pendaftaran gagal, permasalahan Server!",
                                            toastLength: Toast.LENGTH_LONG);
                                      }
                                    });
                                  } else {
                                    Navigator.pop(context);
                                    Fluttertoast.showToast(
                                        backgroundColor: ColorTheme.greenDark,
                                        msg:
                                            "Anda masih memiliki Ticket yang berlangsung",
                                        toastLength: Toast.LENGTH_LONG);
                                  }
                                });
                              });
                            } else {
                              if (_poliTujuan.statusPoli == 1) {
                                // Jika poli dalam keadaan membuka pendaftaran.
                                SharedPref.getUsername().then((value) {
                                  username = value;
                                  RequestApi.checkAlreadyRegisterQueue(value)
                                      .then((value) {
                                    if (value == false) {
                                      // Belum ambil antrean.
                                      DateTime dateNow = DateTime.now();
                                      String tanggal =
                                          "${dateNow.year.toString()}-${dateNow.month.toString().padLeft(2, '0')}-${dateNow.day.toString().padLeft(2, '0')}";
                                      KartuAntre tiket = KartuAntre(
                                          idPoli: _poliTujuan.idPoli,
                                          idHari: DateTime.now().weekday,
                                          username: username.toString(),
                                          nomorAntrean: null,
                                          tipeBooking: isBooking,
                                          tglPelayanan: tanggal.toString(),
                                          jamDaftarAntrean: daftarAntrean,
                                          jamMulaiDilayani: "NULL",
                                          jamSelesaiDilayani: "NULL",
                                          statusAntrean: 1);
                                      RequestApi.registerAntreanHariIni(tiket)
                                          .then((value) {
                                        Navigator.pop(context);
                                        if (value) {
                                          Fluttertoast.showToast(
                                              backgroundColor:
                                                  ColorTheme.greenDark,
                                              msg:
                                                  "Pendaftaran berhasil, silahkan cek E-Ticket!",
                                              toastLength: Toast.LENGTH_LONG);
                                        } else {
                                          Fluttertoast.showToast(
                                              backgroundColor:
                                                  ColorTheme.greenDark,
                                              msg:
                                                  "Pendaftaran gagal, permasalahan Server!",
                                              toastLength: Toast.LENGTH_LONG);
                                        }
                                      });
                                    } else {
                                      Navigator.pop(context);
                                      Fluttertoast.showToast(
                                          backgroundColor: ColorTheme.greenDark,
                                          msg:
                                              "Anda masih memiliki Ticket yang berlangsung",
                                          toastLength: Toast.LENGTH_LONG);
                                    }
                                  });
                                });
                              } else {
                                Navigator.pop(context);
                                Fluttertoast.showToast(
                                    backgroundColor: ColorTheme.greenDark,
                                    msg:
                                        "Maaf, Poliklinik yang anda pilih tidak tersedia sekarang!",
                                    toastLength: Toast.LENGTH_LONG);
                              }
                            }
                          } else {
                            Fluttertoast.showToast(
                                backgroundColor: ColorTheme.greenDark,
                                msg: "Mohon lengkapi form yang disediakan",
                                toastLength: Toast.LENGTH_LONG);
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
                      padding: const EdgeInsets.only(
                          left: 16.0, right: 16.0, top: 16.0),
                      child: InkWell(
                        onTap: () {
                          isBooking = !isBooking;
                          (isBooking)
                              ? bookingBloc.add(BookingEvent.pilihBooking)
                              : bookingBloc.add(BookingEvent.pilihHariIni);
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
        ));
  }
}
