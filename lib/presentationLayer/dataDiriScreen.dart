import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mobile_antrean_babatan/blocLayer/dataDiri/data_diri_bloc.dart';
import 'package:mobile_antrean_babatan/dataLayer/model/pasien.dart';
import 'package:mobile_antrean_babatan/presentationLayer/ubahPasswordScreen.dart';
import 'package:mobile_antrean_babatan/utils/color.dart';
import 'package:mobile_antrean_babatan/utils/textFieldModified.dart';

class DataDiriScreen extends StatefulWidget {
  @override
  _DataDiriScreenState createState() => _DataDiriScreenState();
}

class _DataDiriScreenState extends State<DataDiriScreen> {
  DataDiriBloc _dataDiriBloc = DataDiriBloc();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _namaLengkap = TextEditingController();
  TextEditingController _tglLahir = TextEditingController();
  TextEditingController _alamat = TextEditingController();
  TextEditingController _kepalaKeluarga = TextEditingController();
  TextEditingController _username = TextEditingController();
  TextEditingController _nomorHandphone = TextEditingController();
  String latitudeData = "";
  String longitudeData = "";
  bool isClickValidated = false;
  bool isVerifiedNumber = false;
  DateTime selectedDate = DateTime.now();
  bool isEnabled = false;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1945),
        lastDate: DateTime.now());
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  Future<void> getCurrentLocation() async {
    final geoposition = await Geolocator().getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high
    );

    setState(() {
      latitudeData  = geoposition.latitude.toString();
      longitudeData = geoposition.longitude.toString();
      print("https://www.google.com/maps/search/?api=1&query=$latitudeData,$longitudeData");
    });
  }

  void verifiedInput() {
    setState(() {
      isClickValidated = true;
    });
    if (_formKey.currentState.validate()) {
      Pasien pasien = Pasien(
          namaLengkap: _namaLengkap.text.toString(),
          tglLahir: _tglLahir.text.toString(),
          alamat: _alamat.text.toString(),
          latitude: latitudeData,
          longitude: longitudeData,
          kepalaKeluarga: _kepalaKeluarga.text.toString(),
          username: _username.text.toString(),
          noHandphone: _nomorHandphone.text.toString());
      _dataDiriBloc.add(DataDiriEventEditProfile(pasien: pasien));
    }
  }

  @override
  void initState() {
    _dataDiriBloc.add(DataDiriEventGetProfile());
    super.initState();
    getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _dataDiriBloc,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Data Diri Anda"),
        ),
        body: BlocConsumer<DataDiriBloc, DataDiriState>(
          cubit: _dataDiriBloc,
          listener: (context, state) {
            if (state is DataDiriStateSuccess) {
              _namaLengkap.text = state.pasien.namaLengkap;
              _tglLahir.text = state.pasien.tglLahir;
              _alamat.text = state.pasien.alamat;
              _kepalaKeluarga.text = state.pasien.kepalaKeluarga;
              _username.text = state.pasien.username;
              _nomorHandphone.text = state.pasien.noHandphone;
              isEnabled = false;
            }
          },
          builder: (context, state) {
            if (state is DataDiriStateSuccess) {
              return Container(
                child: Form(
                  autovalidateMode: (isClickValidated)
                      ? AutovalidateMode.onUserInteraction
                      : AutovalidateMode.disabled,
                  key: _formKey,
                  child: ListView(
                    children: [
                      Container(
                          padding: EdgeInsets.only(
                              top: 20.0, left: 20.0, right: 20.0),
                          child: Column(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.all(16.0),
                                child: Image(
                                  height: MediaQuery.of(context).size.width / 4,
                                  image: AssetImage('asset/Avatar.png'),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    "Edit Profil",
                                    style: TextStyle(
                                        color: ColorTheme.greenDark,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Switch(
                                    value: isEnabled,
                                    onChanged: (value) {
                                      setState(() {
                                        isEnabled = value;
                                        print(isEnabled);
                                      });
                                    },
                                    activeTrackColor: ColorTheme.greenLight,
                                    activeColor: ColorTheme.greenDark,
                                  ),
                                ],
                              ),
                              textFieldModified(
                                  label: 'Nama Lengkap',
                                  hint: 'Isi nama anda',
                                  icon: Icon(Icons.person),
                                  isEnabled: isEnabled,
                                  formatter: [
                                    FilteringTextInputFormatter.allow(
                                        RegExp('[a-zA-Z ]')),
                                  ],
                                  validatorFunc: (value) {
                                    if (value.isEmpty) {
                                      return "Harus diisi";
                                    } else {
                                      return null;
                                    }
                                  },
                                  controller: _namaLengkap),
                              SizedBox(height: 20.0),
                              Row(
                                children: [
                                  Flexible(
                                    child: textFieldModified(
                                        isEnabled: false,
                                        label: 'Tanggal Lahir',
                                        icon: Icon(Icons.date_range),
                                        controller: _tglLahir),
                                  ),
                                  SizedBox(width: 16.0),
                                  ElevatedButton(
                                      onPressed: () {
                                        if (isEnabled) {
                                          _selectDate(context).then((value) {
                                            setState(() {
                                              _tglLahir.text =
                                                  "${selectedDate.year.toString()}-${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.day.toString().padLeft(2, '0')}";
                                            });
                                          });
                                        } else {
                                          Fluttertoast.showToast(
                                              msg:
                                                  "Nyalakan Edit Profil Terlebih Dahulu.",
                                              toastLength: Toast.LENGTH_SHORT);
                                        }
                                      },
                                      child: Icon(Icons.date_range))
                                ],
                              ),
                              SizedBox(height: 20.0),
                              textFieldModified(
                                  label: 'Alamat Lengkap',
                                  hint: 'Isi alamat rumah anda',
                                  icon: Icon(Icons.map),
                                  isEnabled: isEnabled,
                                  validatorFunc: (value) {
                                    if (value.isEmpty) {
                                      return "Harus diisi";
                                    } else {
                                      return null;
                                    }
                                  },
                                  controller: _alamat),
                              SizedBox(height: 20.0),
                              textFieldModified(
                                  label: 'Nama Kepala Keluarga',
                                  hint: 'Isi nama kepala keluarga anda',
                                  icon: Icon(Icons.person),
                                  isEnabled: isEnabled,
                                  formatter: [
                                    FilteringTextInputFormatter.allow(
                                        RegExp('[a-zA-Z ]')),
                                  ],
                                  validatorFunc: (value) {
                                    if (value.isEmpty) {
                                      return "Harus diisi";
                                    } else {
                                      return null;
                                    }
                                  },
                                  controller: _kepalaKeluarga),
                              SizedBox(height: 20.0),
                              textFieldModified(
                                  label: 'Username',
                                  hint: 'Kombinasi huruf dan angka.',
                                  icon: Icon(Icons.person),
                                  isEnabled: isEnabled,
                                  formatter: [
                                    FilteringTextInputFormatter.allow(
                                        RegExp('[a-zA-Z0-9]')),
                                  ],
                                  validatorFunc: (value) {
                                    if (value.isEmpty) {
                                      return "Harus diisi";
                                    } else if (value.length < 4) {
                                      return "Minimum 4 karakter";
                                    } else {
                                      return null;
                                    }
                                  },
                                  controller: _username),
                              SizedBox(height: 20.0),
                              textFieldModified(
                                  label: 'Nomor Seluler',
                                  hint: 'Contoh : 6281122224444',
                                  icon: Icon(Icons.call),
                                  typeKeyboard: TextInputType.number,
                                  isEnabled: isEnabled,
                                  formatter: [
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'[0-9]')),
                                  ],
                                  validatorFunc: (value) {
                                    if (value.isEmpty) {
                                      return "Harus diisi";
                                    } else if (value.length < 10) {
                                      return "Minimum 10 digit";
                                    } else if (value.substring(0, 2) != "62") {
                                      return "Format tidak sesuai, awali dengan 62";
                                    } else {
                                      return null;
                                    }
                                  },
                                  controller: _nomorHandphone),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 16.0, horizontal: 4.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      'Ingin ubah Password?',
                                      style:
                                          TextStyle(fontFamily: 'Montserrat'),
                                    ),
                                    SizedBox(width: 5.0),
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    UbahPasswordScreen(pasien: state.pasien)));
                                      },
                                      child: Text(
                                        'Ubah disini',
                                        style: TextStyle(
                                            color: ColorTheme.greenDark,
                                            fontWeight: FontWeight.bold,
                                            decoration:
                                                TextDecoration.underline),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  if (isEnabled) {
                                    verifiedInput();
                                  } else {
                                    Fluttertoast.showToast(
                                        msg:
                                            "Nyalakan Edit Profil Terlebih Dahulu.",
                                        toastLength: Toast.LENGTH_SHORT);
                                  }
                                },
                                child: Container(
                                  height: 40.0,
                                  child: Material(
                                    borderRadius: BorderRadius.circular(20.0),
                                    color: (isEnabled)
                                        ? ColorTheme.greenDark
                                        : Colors.grey,
                                    elevation: 7.0,
                                    child: Center(
                                      child: Text(
                                        'Ubah Data Diri',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 24.0),
                            ],
                          )),
                    ],
                  ),
                ),
              );
            } else if (state is DataDiriStateFailed) {
              return Container(
                child: Center(
                  child: Text(state.messageFailed.toString()),
                ),
              );
            } else {
              return Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
