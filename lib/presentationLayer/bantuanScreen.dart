import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class BantuanScreen extends StatefulWidget {
  @override
  _BantuanScreenState createState() => _BantuanScreenState();
}

class _BantuanScreenState extends State<BantuanScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[50],
      appBar: AppBar(
        leading: Icon(Icons.person),
        title: Text("Bantuan"),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16.0),
            child: Image(
              height: MediaQuery.of(context).size.width / 4,
              image: AssetImage('asset/LogoPuskesmas.png'),
            ),
          ),
          Card(
            margin: EdgeInsets.only(left: 16.0, right: 16.0),
            child: ListTile(
              leading: Icon(Icons.local_hospital),
              title: Text(
                'UPT Puskesmas Babatan Bandung',
              ),
            ),
          ),
          Card(
            margin: EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0),
            child: InkWell(
              onTap: () {
                launch("https://goo.gl/maps/7KV7kS1p1qUTsscG7");
              },
              child: ListTile(
                leading: Icon(Icons.location_on),
                trailing: Icon(Icons.navigate_next),
                title: Text(
                  'Jl. Babatan No.4, Kb. Jeruk, Kec. Andir, Kota Bandung, Jawa Barat 40181',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
