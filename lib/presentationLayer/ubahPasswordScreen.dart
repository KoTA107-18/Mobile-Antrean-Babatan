import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobile_antrean_babatan/blocLayer/ubahPassword/ubah_password_bloc.dart';
import 'package:mobile_antrean_babatan/dataLayer/model/pasien.dart';
import 'package:mobile_antrean_babatan/utils/color.dart';
import 'package:mobile_antrean_babatan/utils/loading.dart';
import 'package:mobile_antrean_babatan/utils/textFieldModified.dart';

class UbahPasswordScreen extends StatefulWidget {
  Pasien pasien;

  UbahPasswordScreen({this.pasien});

  @override
  _UbahPasswordScreenState createState() => _UbahPasswordScreenState();
}

class _UbahPasswordScreenState extends State<UbahPasswordScreen> {
  UbahPasswordBloc _ubahPasswordBloc = UbahPasswordBloc();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _password = TextEditingController();
  TextEditingController _passwordTwo = TextEditingController();
  bool isClickValidated = false;

  void verifiedInput() {
    setState(() {
      isClickValidated = true;
    });
    if (_formKey.currentState.validate()) {
      Pasien pasien = Pasien(
          idPasien: widget.pasien.idPasien,
          password: _password.text.toString());
      _ubahPasswordBloc.add(UbahPasswordEventSubmit(pasien: pasien));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _ubahPasswordBloc,
      child: BlocListener<UbahPasswordBloc, UbahPasswordState>(
        cubit: _ubahPasswordBloc,
        listener: (context, state) {
          if (state is UbahPasswordLoading) {
            loading(context);
          } else if (state is UbahPasswordFailed) {
            Navigator.pop(context);
            Fluttertoast.showToast(msg: state.errMessage.toString());
          } else if (state is UbahPasswordSuccess) {
            Navigator.pop(context);
            Fluttertoast.showToast(msg: state.successMessage.toString());
          }
        },
        child: Scaffold(
          body: Container(
            color: ColorTheme.greenDark,
            child: Scaffold(
              appBar: AppBar(
                title: Text("Ubah Password"),
              ),
              body: Form(
                autovalidateMode: (isClickValidated)
                    ? AutovalidateMode.onUserInteraction
                    : AutovalidateMode.disabled,
                key: _formKey,
                child: ListView(
                  children: [
                    Container(
                        padding:
                            EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                        child: Column(
                          children: <Widget>[
                            textFieldModified(
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
                                controller: _password),
                            SizedBox(height: 20.0),
                            textFieldModified(
                                label: 'Konfirmasi Password',
                                hint: 'Isi kembali password anda',
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
                                  } else if (value != _password.text) {
                                    return "Konfirmasi Password tidak sesuai";
                                  } else {
                                    return null;
                                  }
                                },
                                controller: _passwordTwo),
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
                                      'Ubah Password',
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
            ),
          ),
        ),
      ),
    );
  }
}
