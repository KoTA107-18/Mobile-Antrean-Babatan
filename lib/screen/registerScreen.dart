import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobile_antrean_babatan/model/pasien.dart';
import 'package:mobile_antrean_babatan/network/api.dart';
import 'package:mobile_antrean_babatan/utils/color.dart';
import 'package:mobile_antrean_babatan/utils/loading.dart';
import 'loginScreen.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _namaLengkap = TextEditingController();
  TextEditingController _tglLahir = TextEditingController();
  TextEditingController _alamat = TextEditingController();
  TextEditingController _kepalaKeluarga = TextEditingController();
  TextEditingController _username = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _passwordTwo = TextEditingController();
  TextEditingController _nomorHandphone = TextEditingController();
  bool isClickValidated = false;
  DateTime selectedDate = DateTime.now();

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

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorTheme.greenDark,
      child: SafeArea(
        top: true,
        child: Scaffold(
          body: Form(
            autovalidateMode: (isClickValidated)
                ? AutovalidateMode.onUserInteraction
                : AutovalidateMode.disabled,
            key: _formKey,
            child: ListView(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 20.0, top: 20.0),
                  child: Text('Daftar Akun.',
                      style: TextStyle(
                          fontSize: 32.0,
                          fontWeight: FontWeight.bold,
                          color: ColorTheme.greenDark)),
                ),
                Container(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Text('Antrean Online Puskesmas Babatan.',
                      style: TextStyle(
                          fontSize: 16.0, color: ColorTheme.greenDark)),
                ),
                Container(
                    padding:
                        EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                    child: Column(
                      children: <Widget>[
                        textFieldModified(
                            label: 'Nama Lengkap',
                            hint: 'Isi nama anda',
                            icon: Icon(Icons.person),
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
                                  _selectDate(context).then((value) {
                                    setState(() {
                                      _tglLahir.text =
                                          "${selectedDate.year.toString()}-${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.day.toString().padLeft(2, '0')}";
                                    });
                                  });
                                },
                                child: Icon(Icons.date_range))
                          ],
                        ),
                        SizedBox(height: 20.0),
                        textFieldModified(
                            label: 'Alamat Lengkap',
                            hint: 'Isi alamat rumah anda',
                            icon: Icon(Icons.map),
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
                            label: 'Kata Sandi',
                            hint: 'Isi kata sandi anda',
                            icon: Icon(Icons.vpn_key),
                            formatter: [
                              FilteringTextInputFormatter.deny(RegExp('[ ]')),
                            ],
                            isPasword: true,
                            validatorFunc: (value) {
                              if (value.isEmpty) {
                                return "Harus diisi";
                              } else if (value.length < 4) {
                                return "Minimum 4 karakter";
                              } else {
                                return null;
                              }
                            },
                            controller: _password),
                        SizedBox(height: 20.0),
                        textFieldModified(
                            label: 'Konfirmasi Kata Sandi',
                            hint: 'Isi kembali kata sandi anda',
                            icon: Icon(Icons.vpn_key),
                            formatter: [
                              FilteringTextInputFormatter.deny(RegExp('[ ]')),
                            ],
                            isPasword: true,
                            validatorFunc: (value) {
                              if (value.isEmpty) {
                                return "Harus diisi";
                              } else if (value.length < 4) {
                                return "Minimum 4 karakter";
                              } else if (value != _password.text) {
                                return "Konfirmasi Password tidak sesuai";
                              } else {
                                return null;
                              }
                            },
                            controller: _passwordTwo),
                        SizedBox(height: 20.0),
                        textFieldModified(
                            label: 'Nomor Seluler',
                            hint: 'Isi dengan nomor seluler anda',
                            icon: Icon(Icons.call),
                            typeKeyboard: TextInputType.number,
                            formatter: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[0-9]')),
                            ],
                            validatorFunc: (value) {
                              if (value.isEmpty) {
                                return "Harus diisi";
                              } else if (value.length < 10) {
                                return "Minimum 10 digit";
                              } else {
                                return null;
                              }
                            },
                            controller: _nomorHandphone),
                        SizedBox(height: 20.0),
                        InkWell(
                          onTap: () {
                            verifiedInput();
                          },
                          child: Container(
                            height: 40.0,
                            child: Material(
                              borderRadius: BorderRadius.circular(20.0),
                              color: ColorTheme.greenDark,
                              elevation: 7.0,
                              child: Center(
                                child: Text(
                                  'Daftar Akun',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 15.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'Sudah punya akun?',
                              style: TextStyle(fontFamily: 'Montserrat'),
                            ),
                            SizedBox(width: 5.0),
                            InkWell(
                              onTap: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Login()));
                              },
                              child: Text(
                                'Masuk disini',
                                style: TextStyle(
                                    color: ColorTheme.greenDark,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline),
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 24.0),
                      ],
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void verifiedInput() {
    setState(() {
      isClickValidated = true;
    });
    if (_formKey.currentState.validate()) {
      loading(context);
      Pasien pasien = Pasien(
          username: _username.text,
          noHandphone: _nomorHandphone.text,
          kepalaKeluarga: _kepalaKeluarga.text,
          namaLengkap: _namaLengkap.text,
          password: _password.text,
          alamat: _alamat.text,
          tglLahir: _tglLahir.text);
      RequestApi.registerPasien(pasien).then((value) {
        Navigator.pop(context);
        if(value) {
          Fluttertoast.showToast(
              gravity: ToastGravity.CENTER,
              backgroundColor: ColorTheme.greenDark,
              msg: "Registrasi berhasil!", toastLength: Toast.LENGTH_LONG);
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => Login()));
        } else {
          Fluttertoast.showToast(
              gravity: ToastGravity.CENTER,
              backgroundColor: ColorTheme.greenDark,
              msg: "Username atau Nomor Seluler anda sudah terdaftar!", toastLength: Toast.LENGTH_LONG);
        }

      }).catchError((e) {
        Navigator.pop(context);
        Fluttertoast.showToast(
            gravity: ToastGravity.CENTER,
          backgroundColor: ColorTheme.greenDark,
            msg: e.toString(), toastLength: Toast.LENGTH_LONG);
      });
    }
  }

  TextFormField textFieldModified(
      {String label,
      bool isEnabled = true,
      String hint,
      Icon icon,
      TextEditingController controller,
      TextInputType typeKeyboard,
      FormFieldValidator<String> validatorFunc,
      bool isPasword = false,
      List<TextInputFormatter> formatter}) {
    return TextFormField(
        enabled: isEnabled,
        obscureText: isPasword,
        keyboardType: typeKeyboard,
        inputFormatters: formatter,
        controller: controller,
        validator: validatorFunc,
        decoration: InputDecoration(
            labelText: label,
            hintText: hint,
            prefixIcon: icon,
            disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.0),
                borderSide: BorderSide(color: Colors.grey)),
            labelStyle:
                TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(16.0)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.0),
                borderSide: BorderSide(color: ColorTheme.greenDark))));
  }
}
