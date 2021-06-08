import 'package:flutter/material.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';
import 'package:mobile_antrean_babatan/main.dart';
import 'package:mobile_antrean_babatan/utils/color.dart';

class Verification extends StatefulWidget {
  String noHandphone;
  Verification(this.noHandphone);

  @override
  _VerificationState createState() => _VerificationState();
}

class _VerificationState extends State<Verification> {
  bool isVerification = false;

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
                padding: EdgeInsets.only(left: 32.0, top: 32.0),
                child: Text('Verifikasi Akun Anda.',
                    style: TextStyle(
                        fontSize: 32.0,
                        fontWeight: FontWeight.bold,
                        color: ColorTheme.greenDark)),
              ),
              SizedBox(height: 16.0),
              Container(
                padding: EdgeInsets.only(left: 32.0, right: 32.0),
                child: Text(
                    'Kami mengirimkan SMS ke nomor ${widget.noHandphone} berupa kode dengan 4 digit angka ke nomor anda. Harap masukkan kode yang anda terima.',
                    textAlign: TextAlign.justify,
                    style:
                        TextStyle(fontSize: 16.0, color: ColorTheme.greenDark)),
              ),
              SizedBox(height: 32.0),
              Center(
                child: VerificationCode(
                    textStyle:
                        TextStyle(fontSize: 20.0, color: ColorTheme.greenDark),
                    underlineColor: ColorTheme.greenDark,
                    keyboardType: TextInputType.number,
                    length: 4,
                    onCompleted: (String value) {
                      setState(() {});
                    },
                    onEditing: (bool value) {
                      setState(() {});
                    }),
              ),
              SizedBox(height: 32.0),
              InkWell(
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => App(),
                      ),
                      (Route<dynamic> route) => false);
                },
                child: Container(
                  padding: EdgeInsets.only(left: 32.0, right: 32.0),
                  height: 40.0,
                  child: Material(
                    borderRadius: BorderRadius.circular(20.0),
                    color: ColorTheme.greenDark,
                    elevation: 7.0,
                    child: Center(
                      child: Text(
                        'Verifikasi',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 32.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Tidak menerima kode?',
                  ),
                  SizedBox(width: 5.0),
                  InkWell(
                    onTap: () {},
                    child: Text(
                      'Kirim ulang kode',
                      style: TextStyle(
                          color: ColorTheme.greenDark,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
