import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobile_antrean_babatan/dataLayer/api/api.dart';
import 'package:mobile_antrean_babatan/dataLayer/model/apiResponse.dart';
import 'package:mobile_antrean_babatan/dataLayer/model/pasien.dart';
import 'package:mobile_antrean_babatan/dataLayer/model/responseLogin.dart';
import 'package:mobile_antrean_babatan/dataLayer/session/sharedPref.dart';
import 'package:mobile_antrean_babatan/presentationLayer/verificationScreen.dart';
import 'package:mobile_antrean_babatan/utils/color.dart';
import 'package:mobile_antrean_babatan/utils/loading.dart';
import 'package:mobile_antrean_babatan/utils/textFieldModified.dart';

import '../main.dart';
import 'registerScreen.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _username = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _nomorSeluler = TextEditingController();
  bool isLoginByUsername = true;
  bool isClickValidated = false;

  void verifiedInputRegister() {
    setState(() {
      isClickValidated = true;
    });
    if (_formKey.currentState.validate()) {
      loading(context);
      RequestApi.loginPasienUsername(_username.text, _password.text)
          .then((value) {
        Navigator.pop(context);
        if (value != null) {
          ResponseLogin resultSnapshot = ResponseLogin.fromJson(value);
          SharedPref.saveLoginInfo(
                  resultSnapshot.data.apiToken,
                  resultSnapshot.data.pasien.username,
                  resultSnapshot.data.pasien.idPasien)
              .then((value) {
            Fluttertoast.showToast(
                backgroundColor: ColorTheme.greenDark,
                msg: "Login berhasil!",
                toastLength: Toast.LENGTH_LONG);
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => App()));
          });
        } else {
          Fluttertoast.showToast(
              backgroundColor: ColorTheme.greenDark,
              msg: "Login gagal!",
              toastLength: Toast.LENGTH_LONG);
        }
      }).catchError((e) {
        Navigator.pop(context);
        Fluttertoast.showToast(
            backgroundColor: ColorTheme.greenDark,
            msg: e.toString(),
            toastLength: Toast.LENGTH_LONG);
      });
    }
  }

  void verifiedInputLogin() {
    setState(() {
      isClickValidated = true;
    });
    if (_formKey.currentState.validate()) {
      loading(context);
      Pasien pasien = Pasien(noHandphone: _nomorSeluler.text.toString());
      RequestApi.validasiPasien(pasien).then((value){
        var response = ApiResponse.fromJson(value);
        if(response.success){
          Navigator.pop(context);
          Fluttertoast.showToast(
              msg: "Nomor ini tidak terdaftar pada Aplikasi.",
              toastLength: Toast.LENGTH_LONG);
        } else {
          Navigator.pop(context);
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Verification(pasien, false)));
        }
      }).catchError((e) {
        Navigator.pop(context);
        Fluttertoast.showToast(
            msg: e.toString(),
            toastLength: Toast.LENGTH_LONG);
      });
    }
  }

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
                  child: Text('Selamat Datang',
                      style: TextStyle(
                          fontSize: 32.0,
                          fontWeight: FontWeight.bold,
                          color: ColorTheme.greenDark)),
                ),
              ),
              Container(
                child: Center(
                  child: Text('Antrean Online Puskesmas Babatan',
                      style: TextStyle(
                          fontSize: 16.0, color: ColorTheme.greenDark)),
                ),
              ),
              Form(
                autovalidateMode: (isClickValidated)
                    ? AutovalidateMode.onUserInteraction
                    : AutovalidateMode.disabled,
                key: _formKey,
                child: Container(
                    padding:
                        EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
                    child: Column(
                      children: <Widget>[
                        isLoginByUsername == true
                            ? textFieldModified(
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
                                controller: _username)
                            : textFieldModified(
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
                                  } else if (value.substring(0, 2) != "62") {
                                    return "Format tidak sesuai, awali dengan 62";
                                  } else {
                                    return null;
                                  }
                                },
                                controller: _nomorSeluler),
                        SizedBox(height: 20.0),
                        isLoginByUsername == true
                            ? textFieldModified(
                                label: 'Password',
                                hint: 'Isi password anda',
                                icon: Icon(Icons.vpn_key),
                                formatter: [
                                  FilteringTextInputFormatter.deny(
                                      RegExp('[ ]')),
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
                                controller: _password)
                            : SizedBox.shrink(),
                        SizedBox(height: 40.0),
                        InkWell(
                          onTap: () {
                            if (isLoginByUsername) {
                              verifiedInputRegister();
                            } else {
                              verifiedInputLogin();
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
