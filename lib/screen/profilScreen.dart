import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobile_antrean_babatan/bloc/profil/profil_bloc.dart';
import 'package:mobile_antrean_babatan/screen/loginScreen.dart';
import 'package:mobile_antrean_babatan/utils/color.dart';
import 'package:mobile_antrean_babatan/utils/loading.dart';

class Profil extends StatelessWidget {
  ProfilBloc _profilBloc = ProfilBloc();

  _showMaterialDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: Text("Keluar"),
              content: Text("Anda yakin keluar dari aplikasi?"),
              actions: <Widget>[
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: ColorTheme.greenDark, // background
                    onPrimary: Colors.white, // foreground
                  ),
                  child: Text(
                    'Ya',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    _profilBloc.add(ProfilEventLogout());
                    Navigator.pop(context);
                  },
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.grey, // background
                    onPrimary: Colors.white, // foreground
                  ),
                  child: Text(
                    'Tidak',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _profilBloc,
      child: BlocListener<ProfilBloc, ProfilState>(
        listener: (context, state) {
          if (state is ProfilStateLogoutLoading) {
            loading(context);
          }
          if (state is ProfilStateLogoutSuccess) {
            Navigator.pop(context);
            Fluttertoast.showToast(
                backgroundColor: ColorTheme.greenDark,
                msg: state.message,
                toastLength: Toast.LENGTH_SHORT);
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => Login()));
          }
          if (state is ProfilStateLogoutFailed) {
            Navigator.pop(context);
            Fluttertoast.showToast(
                backgroundColor: ColorTheme.greenDark,
                msg: state.errMessage,
                toastLength: Toast.LENGTH_SHORT);
          }
        },
        child: Scaffold(
          backgroundColor: Colors.teal[50],
          appBar: AppBar(
            leading: Icon(Icons.person),
            title: Text("Profil"),
          ),
          body: Column(
            children: [
              Container(
                padding: EdgeInsets.all(16.0),
                child: Image(
                  height: MediaQuery.of(context).size.width / 3,
                  image: AssetImage('asset/Avatar.png'),
                ),
              ),
              Card(
                margin: EdgeInsets.only(left: 16.0, right: 16.0),
                child: InkWell(
                  onTap: () {
                    Fluttertoast.showToast(
                        backgroundColor: ColorTheme.greenDark,
                        msg: "On Going!",
                        toastLength: Toast.LENGTH_SHORT);
                  },
                  child: ListTile(
                    leading: Icon(Icons.file_copy),
                    title: Text(
                      'Data Diri Saya',
                    ),
                    trailing: Icon(Icons.navigate_next),
                  ),
                ),
              ),
              Card(
                margin: EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0),
                child: InkWell(
                  onTap: () {
                    Fluttertoast.showToast(
                        backgroundColor: ColorTheme.greenDark,
                        msg: "On Going!",
                        toastLength: Toast.LENGTH_SHORT);
                  },
                  child: ListTile(
                    leading: Icon(Icons.help),
                    title: Text(
                      'Bantuan',
                    ),
                    trailing: Icon(Icons.navigate_next),
                  ),
                ),
              ),
              Card(
                margin: EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0),
                child: InkWell(
                  onTap: () {
                    _showMaterialDialog(context);
                  },
                  child: ListTile(
                    leading: Icon(Icons.logout),
                    title: Text(
                      'Keluar',
                    ),
                    trailing: Icon(Icons.navigate_next),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
