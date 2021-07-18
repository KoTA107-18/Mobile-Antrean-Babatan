import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobile_antrean_babatan/dataLayer/api/api.dart';
import 'package:mobile_antrean_babatan/dataLayer/model/apiResponse.dart';
import 'package:mobile_antrean_babatan/dataLayer/model/pasien.dart';
import 'package:mobile_antrean_babatan/dataLayer/model/responseLogin.dart';
import 'package:mobile_antrean_babatan/dataLayer/session/sharedPref.dart';
import 'package:mobile_antrean_babatan/main.dart';
import 'package:mobile_antrean_babatan/presentationLayer/loginScreen.dart';
import 'package:mobile_antrean_babatan/utils/color.dart';
import 'package:mobile_antrean_babatan/utils/loading.dart';

class Verification extends StatefulWidget {
  bool isRegister;
  Pasien pasien;
  Verification(this.pasien, this.isRegister);

  @override
  _VerificationState createState() => _VerificationState();
}

class _VerificationState extends State<Verification> {
  FirebaseAuth auth = FirebaseAuth.instance;
  String _verificationCode;
  bool _onEditing = true;
  String _code;

  @override
  void initState() {
    super.initState();
    _verifyPhone();
  }

  _verificationRegister(String code) async {
    loading(context);
    try {
      await auth
          .signInWithCredential(PhoneAuthProvider.credential(
              verificationId: _verificationCode, smsCode: code))
          .then((value) async {
        if (value.user != null) {
          print(widget.pasien.toJson().toString());
          RequestApi.registerPasien(widget.pasien).then((value) async {
            var response = ApiResponse.fromJson(value);
            if (response.success) {
              Navigator.pop(context);
              await auth.signOut();
              Fluttertoast.showToast(
                  msg: response.message.toString(),
                  toastLength: Toast.LENGTH_LONG);
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => Login()),
                  (route) => false);
            } else {
              Navigator.pop(context);
              Fluttertoast.showToast(
                  msg: response.message.toString(),
                  toastLength: Toast.LENGTH_LONG);
            }
          }).catchError((e) {
            Navigator.pop(context);
            Fluttertoast.showToast(
                msg: e.toString(), toastLength: Toast.LENGTH_LONG);
          });
        }
      });
    } catch (e) {
      Navigator.pop(context);
      Fluttertoast.showToast(
          msg: "Invalid OTP", toastLength: Toast.LENGTH_LONG);
    }
  }

  _verificationLogin(String code) async {
    loading(context);
    try {
      await auth
          .signInWithCredential(PhoneAuthProvider.credential(
              verificationId: _verificationCode, smsCode: code))
          .then((value) async {
        if (value.user != null) {
          var resultLogin =
              await RequestApi.loginPasienHandphone(widget.pasien.noHandphone);
          var resultSnapshot = ResponseLogin.fromJson(resultLogin);
          if (resultSnapshot.success) {
            await SharedPref.saveLoginInfo(
                resultSnapshot.data.apiToken,
                resultSnapshot.data.pasien.username,
                resultSnapshot.data.pasien.idPasien);
            await auth.signOut();
            Navigator.pop(context);
            Fluttertoast.showToast(
                msg: resultSnapshot.message.toString(),
                toastLength: Toast.LENGTH_LONG);
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => App()),
                (route) => false);
          } else {
            Navigator.pop(context);
            Fluttertoast.showToast(
                msg: resultSnapshot.message.toString(),
                toastLength: Toast.LENGTH_LONG);
          }
        }
      });
    } catch (e) {
      Navigator.pop(context);
      Fluttertoast.showToast(
          msg: "Invalid OTP", toastLength: Toast.LENGTH_LONG);
    }
  }

  _verifyPhone() async {
    await auth.verifyPhoneNumber(
        phoneNumber: '+${widget.pasien.noHandphone}',
        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance
              .signInWithCredential(credential)
              .then((value) async {
            if (value.user != null) {
              Fluttertoast.showToast(
                  msg: "Verifikasi Otomatis Berhasil, silahkan Login!",
                  toastLength: Toast.LENGTH_LONG);
              await auth.signOut();
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => Login()),
                  (route) => false);
            }
          });
        },
        verificationFailed: (FirebaseAuthException e) {
          print(e.message);
        },
        codeSent: (String verficationID, int resendToken) {
          setState(() {
            _verificationCode = verficationID;
          });
        },
        codeAutoRetrievalTimeout: (String verificationID) {
          setState(() {
            _verificationCode = verificationID;
          });
        },
        timeout: Duration(seconds: 120));
  }

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
                    'Kami mengirimkan SMS ke nomor anda (${widget.pasien.noHandphone}) berupa kode dengan 6 digit angka ke nomor anda. Harap masukkan kode yang anda terima.',
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
                    length: 6,
                    onCompleted: (String value) {
                      _code = value;
                      if (widget.isRegister) {
                        _verificationRegister(_code);
                      } else {
                        _verificationLogin(_code);
                      }
                    },
                    onEditing: (bool value) {
                      _onEditing = value;
                    }),
              ),
              SizedBox(height: 32.0),
              InkWell(
                onTap: () {
                  if (widget.isRegister) {
                    _verificationRegister(_code);
                  } else {
                    _verificationLogin(_code);
                  }
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
