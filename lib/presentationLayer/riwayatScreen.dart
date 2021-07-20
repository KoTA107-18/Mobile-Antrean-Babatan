import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:mobile_antrean_babatan/blocLayer/antrean/riwayat/riwayat_bloc.dart';
import 'package:mobile_antrean_babatan/dataLayer/model/JadwalPasien.dart';
import 'package:mobile_antrean_babatan/dataLayer/model/kartuAntrean.dart';
import 'package:mobile_antrean_babatan/presentationLayer/kartuRiwayatScreen.dart';
import 'package:mobile_antrean_babatan/utils/color.dart';

class Riwayat extends StatefulWidget {
  @override
  _RiwayatState createState() => _RiwayatState();
}

class _RiwayatState extends State<Riwayat> {
  RiwayatBloc _riwayatBloc = RiwayatBloc();

  @override
  void initState() {
    _riwayatBloc.add(RiwayatEventGetJadwalPasien());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _riwayatBloc,
      child: Scaffold(
          backgroundColor: Colors.teal[50],
          appBar: AppBar(
            leading: Icon(Icons.history),
            title: Text("Riwayat Antrean"),
          ),
          body: BlocBuilder<RiwayatBloc, RiwayatState>(
            builder: (context, state) {
              if (state is RiwayatStateSuccess) {
                if(state.jadwalPasien.length == 0){
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height / 4,
                        child: Lottie.asset(
                          'asset/not_found.json',
                          repeat: false,
                          reverse: false,
                          animate: true,
                        ),
                      ),
                      Center(
                        child: Text("Riwayat kosong.",
                            style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                                color: ColorTheme.greenDark)),
                      )
                    ],
                  );
                } else {
                  return elementJadwal(state.jadwalPasien);
                }
              } else if (state is RiwayatStateFailed) {
                return Center(
                  child: Text(state.errMessage),
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          )),
    );
  }

  ListView elementJadwal(List<KartuAntrean> jadwalPasien) {
    return ListView.builder(
        itemCount: jadwalPasien.length,
        itemBuilder: (BuildContext context, int index) {
          String status = (jadwalPasien[index].statusAntrean == 3.toString()) ? "Selesai Dilayani" : "Cancel";
          return InkWell(
            onTap: (){
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => KartuRiwayatScreen(jadwalPasien[index])));
            },
            child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                margin: EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: ColorTheme.greenLight,
                            borderRadius: BorderRadius.all(Radius.circular(15))),
                        height: 75,
                        width: 75,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Kode"),
                            Text(jadwalPasien[index].nomorAntrean.toString(),
                                style: TextStyle(
                                    fontSize: 18.0, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          jadwalPasien[index].poliklinik.namaPoli.toString(),
                          style: TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.bold),
                        ),
                        Text(
                            "Tanggal Pelayanan : " +
                                jadwalPasien[index].tglPelayanan.toString(),
                            style: TextStyle(fontSize: 16.0)),
                        Text("Status : " + status),
                      ],
                    )
                  ],
                )),
          );
        });
  }
}
