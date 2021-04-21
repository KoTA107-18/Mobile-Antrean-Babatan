import 'package:flutter/material.dart';
import 'package:mobile_antrean_babatan/screen/verificationScreen.dart';
import 'package:mobile_antrean_babatan/utils/color.dart';

import 'loginScreen.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
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
                      TextField(
                        decoration: InputDecoration(
                            labelText: 'Nama Lengkap',
                            hintText: 'Isi nama anda',
                            prefixIcon: Icon(Icons.person),
                            labelStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16.0)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16.0),
                                borderSide:
                                    BorderSide(color: ColorTheme.greenDark))),
                      ),
                      SizedBox(height: 20.0),
                      TextField(
                        decoration: InputDecoration(
                            labelText: 'Tanggal Lahir',
                            prefixIcon: Icon(Icons.date_range),
                            labelStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16.0)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16.0),
                                borderSide:
                                    BorderSide(color: ColorTheme.greenDark))),
                      ),
                      SizedBox(height: 20.0),
                      TextField(
                        decoration: InputDecoration(
                            hintText: 'Isi alamat rumah anda',
                            labelText: 'Alamat Lengkap',
                            prefixIcon: Icon(Icons.map),
                            labelStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16.0)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16.0),
                                borderSide:
                                    BorderSide(color: ColorTheme.greenDark))),
                      ),
                      SizedBox(height: 20.0),
                      TextField(
                        decoration: InputDecoration(
                            hintText: 'Isi nama kepala keluarga anda',
                            labelText: 'Nama Kepala Keluarga',
                            prefixIcon: Icon(Icons.person),
                            labelStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16.0)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16.0),
                                borderSide:
                                    BorderSide(color: ColorTheme.greenDark))),
                      ),
                      SizedBox(height: 20.0),
                      TextField(
                        decoration: InputDecoration(
                            hintText: 'Contoh : Luthfi22',
                            labelText: 'Nama Pengguna (Username)',
                            prefixIcon: Icon(Icons.person),
                            labelStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16.0)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16.0),
                                borderSide:
                                    BorderSide(color: ColorTheme.greenDark))),
                      ),
                      SizedBox(height: 20.0),
                      TextField(
                        decoration: InputDecoration(
                            hintText: 'Isi kata sandi anda',
                            labelText: 'Kata Sandi',
                            prefixIcon: Icon(Icons.vpn_key),
                            labelStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16.0)),
                            focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: ColorTheme.greenDark))),
                        obscureText: true,
                      ),
                      SizedBox(height: 20.0),
                      TextField(
                        decoration: InputDecoration(
                            hintText: 'Isi kembali kata sandi anda',
                            labelText: 'Konfirmasi Kata Sandi',
                            prefixIcon: Icon(Icons.vpn_key),
                            labelStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16.0)),
                            focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: ColorTheme.greenDark))),
                        obscureText: true,
                      ),
                      SizedBox(height: 20.0),
                      TextField(
                        decoration: InputDecoration(
                            hintText: 'Isi dengan nomor seluler anda',
                            labelText: 'Nomor Seluler',
                            prefixIcon: Icon(Icons.call),
                            labelStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16.0)),
                            focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: ColorTheme.greenDark))),
                        obscureText: true,
                      ),
                      SizedBox(height: 20.0),
                      InkWell(
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Verification()));
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
}
