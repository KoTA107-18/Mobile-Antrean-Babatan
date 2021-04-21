import 'package:flutter/material.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';
import 'package:mobile_antrean_babatan/screen/verificationScreen.dart';
import 'package:mobile_antrean_babatan/utils/color.dart';

import '../main.dart';
import 'registerScreen.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _username = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _nomorSeluler = TextEditingController();
  bool isLoginByUsername = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorTheme.greenDark,
      child: SafeArea(
        top: true,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(8.0),
                child: Image(
                  height: MediaQuery.of(context).size.width / 3,
                  image: AssetImage('asset/LogoPuskesmas.png'),
                ),
              ),
              Container(
                child: Center(
                  child: Text('Selamat Datang.',
                      style: TextStyle(
                          fontSize: 32.0,
                          fontWeight: FontWeight.bold,
                          color: ColorTheme.greenDark)),
                ),
              ),
              Container(
                child: Center(
                  child: Text('Antrean Online Puskesmas Babatan.',
                      style: TextStyle(
                          fontSize: 16.0, color: ColorTheme.greenDark)),
                ),
              ),
              Container(
                  padding: EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
                  child: Column(
                    children: <Widget>[
                      isLoginByUsername == true
                          ? TextField(
                              controller: _username,
                              decoration: InputDecoration(
                                  labelText: 'Username',
                                  prefixIcon: Icon(Icons.person),
                                  labelStyle: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey),
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(16.0)),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16.0),
                                      borderSide: BorderSide(
                                          color: ColorTheme.greenDark))),
                            )
                          : TextField(
                              controller: _nomorSeluler,
                              decoration: InputDecoration(
                                  labelText: 'Nomor Seluler',
                                  prefixIcon: Icon(Icons.phone),
                                  labelStyle: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey),
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(16.0)),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16.0),
                                      borderSide: BorderSide(
                                          color: ColorTheme.greenDark))),
                            ),
                      SizedBox(height: 20.0),
                      isLoginByUsername == true
                          ? TextField(
                              controller: _password,
                              decoration: InputDecoration(
                                  labelText: 'Password',
                                  prefixIcon: Icon(Icons.vpn_key),
                                  labelStyle: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey),
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(16.0)),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: ColorTheme.greenDark))),
                              obscureText: true,
                            )
                          : SizedBox.shrink(),
                      SizedBox(height: 40.0),
                      InkWell(
                        onTap: () {
                          if (isLoginByUsername) {
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (context) => App()));
                          } else {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Verification()));
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
                                'Masuk',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20.0),
                      InkWell(
                        onTap: () {
                          isLoginByUsername = !isLoginByUsername;
                          setState(() {});
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
                                  child: isLoginByUsername
                                      ? Text('Masuk dengan Nomor Seluler',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: ColorTheme.greenDark))
                                      : Text('Masuk dengan Username',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: ColorTheme.greenDark)),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 15.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Belum punya akun?',
                          ),
                          SizedBox(width: 5.0),
                          InkWell(
                            onTap: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Register()));
                            },
                            child: Text(
                              'Daftar disini',
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

  _showMaterialDialog() {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: Text("Kode Verifikasi"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  VerificationCode(
                      textStyle: TextStyle(
                          fontSize: 20.0, color: ColorTheme.greenDark),
                      underlineColor: ColorTheme.greenDark,
                      keyboardType: TextInputType.number,
                      length: 4,
                      onCompleted: (String value) {
                        setState(() {});
                      },
                      onEditing: (bool value) {
                        setState(() {});
                      })
                ],
              ),
              actions: <Widget>[
                ElevatedButton(
                  child: Text(
                    'Verifikasi',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => App()));
                  },
                ),
              ],
            ));
  }
}
