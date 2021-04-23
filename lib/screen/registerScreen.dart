import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  TextEditingController _namaLengkap = TextEditingController();
  TextEditingController _tglLahir = TextEditingController();
  TextEditingController _alamat = TextEditingController();
  TextEditingController _kepalaKeluarga = TextEditingController();
  TextEditingController _username = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _passwordTwo = TextEditingController();
  TextEditingController _nomorHandphone = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorTheme.greenDark,
      child: SafeArea(
        top: true,
        child: Scaffold(
          body: ListView(
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
                    style:
                        TextStyle(fontSize: 16.0, color: ColorTheme.greenDark)),
              ),
              Container(
                  padding: EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                  child: Column(
                    children: <Widget>[
                      textFieldModified(
                          label: 'Nama Lengkap',
                          hint: 'Isi nama anda',
                          icon: Icon(Icons.person),
                          controller: _namaLengkap),
                      SizedBox(height: 20.0),
                      InkWell(
                        onTap: () {
                          print("Bingo");
                        },
                        child: textFieldModified(
                            label: 'Tanggal Lahir',
                            icon: Icon(Icons.date_range),
                            controller: _tglLahir),
                      ),
                      SizedBox(height: 20.0),
                      textFieldModified(
                          label: 'Alamat Lengkap',
                          hint: 'Isi alamat rumah anda',
                          icon: Icon(Icons.map),
                          controller: _tglLahir),
                      SizedBox(height: 20.0),
                      textFieldModified(
                          label: 'Nama Kepala Keluarga',
                          hint: 'Isi nama kepala keluarga anda',
                          icon: Icon(Icons.person),
                          controller: _kepalaKeluarga),
                      SizedBox(height: 20.0),
                      textFieldModified(
                          label: 'Nama Pengguna (Username)',
                          hint: 'Contoh : Luthfi22',
                          icon: Icon(Icons.person),
                          controller: _username),
                      SizedBox(height: 20.0),
                      textFieldModified(
                          label: 'Kata Sandi',
                          hint: 'Isi kata sandi anda',
                          icon: Icon(Icons.vpn_key),
                          controller: _password),
                      SizedBox(height: 20.0),
                      textFieldModified(
                          label: 'Konfirmasi Kata Sandi',
                          hint: 'Isi kembali kata sandi anda',
                          icon: Icon(Icons.vpn_key),
                          controller: _passwordTwo),
                      SizedBox(height: 20.0),
                      textFieldModified(
                          label: 'Nomor Seluler',
                          hint: 'Isi dengan nomor seluler anda',
                          icon: Icon(Icons.call),
                          typeKeyboard: TextInputType.number,
                          formatter: [
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                          ],
                          controller: _nomorHandphone),
                      SizedBox(height: 20.0),
                      InkWell(
                        onTap: () {
                          verifiedInput();
                          /*
                          loading(context);
                          Pasien iniBaru = Pasien(
                              username: "luthfialri21",
                              no_handphone: "081220391796",
                              kepala_keluarga: "Fahmi Widianto",
                              nama_lengkap: "Luthfi Alri",
                              password: "luthfigg123",
                              alamat: "Sindanglaya, Bandung",
                              tgl_lahir: "2000-03-10");
                          RequestApi.registerPasien(iniBaru).then((value) {
                            Navigator.pop(context); 
                          });*/
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
                      )
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }

  void verifiedInput() {}

  TextField textFieldModified(
      {String label,
      String hint,
      Icon icon,
      TextEditingController controller,
      TextInputType typeKeyboard,
      List<TextInputFormatter> formatter}) {
    return TextField(
        keyboardType: typeKeyboard,
        inputFormatters: formatter,
        controller: controller,
        decoration: InputDecoration(
            labelText: label,
            hintText: hint,
            prefixIcon: icon,
            labelStyle:
                TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(16.0)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.0),
                borderSide: BorderSide(color: ColorTheme.greenDark))));
  }
}
