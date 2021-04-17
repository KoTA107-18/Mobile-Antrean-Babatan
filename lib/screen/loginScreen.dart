import 'package:flutter/material.dart';
import 'package:mobile_antrean_babatan/utils/color.dart';

import '../main.dart';
import 'registerScreen.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  style:
                      TextStyle(fontSize: 16.0, color: ColorTheme.greenDark)),
            ),
          ),
          Container(
              padding: EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
              child: Column(
                children: <Widget>[
                  TextField(
                    decoration: InputDecoration(
                        labelText: 'Username',
                        prefixIcon: Icon(Icons.person),
                        labelStyle: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.grey),
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
                        labelText: 'Password',
                        prefixIcon: Icon(Icons.vpn_key),
                        labelStyle: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.grey),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16.0)),
                        focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: ColorTheme.greenDark))),
                    obscureText: true,
                  ),
                  SizedBox(height: 40.0),
                  Container(
                    height: 40.0,
                    child: Material(
                      borderRadius: BorderRadius.circular(20.0),
                      color: ColorTheme.greenDark,
                      elevation: 7.0,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) => App()));
                        },
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
                  Container(
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
                            child: Text('Masuk dengan Nomor Seluler',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: ColorTheme.greenDark)),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 15.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Belum punya akun?',
                        style: TextStyle(fontFamily: 'Montserrat'),
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
    );
  }
}
