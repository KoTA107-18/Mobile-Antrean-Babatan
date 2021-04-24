import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobile_antrean_babatan/screen/loginScreen.dart';
import 'package:mobile_antrean_babatan/session/sharedPref.dart';
import 'package:mobile_antrean_babatan/utils/color.dart';

class Profil extends StatefulWidget {
  @override
  _ProfilState createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorTheme.greenLight,
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
                _showMaterialDialog();
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
    );
  }

  _showMaterialDialog() {
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
                    SharedPref.deleteSharedPref().then((value){
                      Fluttertoast.showToast(
                          backgroundColor: ColorTheme.greenDark,
                          msg: "Logout berhasil!",
                          toastLength: Toast.LENGTH_SHORT);
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => Login()));
                    });

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
}
