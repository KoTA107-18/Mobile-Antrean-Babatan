import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_antrean_babatan/bloc/dashboard/dashboard_bloc.dart';
import 'package:mobile_antrean_babatan/repositories/model/poliklinik.dart';
import 'package:mobile_antrean_babatan/utils/color.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final DashboardBloc _dashboardBloc = DashboardBloc();

  Card cardHeader() {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      margin: EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.only(left: 20.0, top: 20.0),
                  child: Text('Bagaimana Kabar Anda?',
                      style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          color: ColorTheme.greenDark)),
                ),
                Container(
                  padding: EdgeInsets.only(left: 20.0, right: 20.0),
                  child: Text(
                      'Untuk melakukan pendaftaran antrean di Puskesmas Babatan, silahkan pilih menu Antre.',
                      style: TextStyle(
                          fontSize: 16.0, color: ColorTheme.greenDark)),
                ),
                SizedBox(
                  height: 8.0,
                ),
                Container(
                  padding: EdgeInsets.only(left: 20.0, right: 20.0),
                  child: Text("Pendaftaran dapat dilakukan"),
                ),
                Container(
                  padding:
                      EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
                  child: Text(
                    "Pukul 08.00 - 10.00 WIB",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 80.0,
            padding: EdgeInsets.only(right: 20.0),
            child: Image.asset('asset/LogoPuskesmas.png'),
          )
        ],
      ),
    );
  }

  ListView daftarPoliklinik(List<Poliklinik> daftarPoli){
    return ListView.builder(
        itemCount: daftarPoli.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            color: (daftarPoli[index].statusPoli == 1) ? Colors.white : Colors.white70,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              margin: EdgeInsets.only(
                  left: 8.0, right: 8.0, top: 8.0),
              child: Row(
                mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [
                        Text(
                          daftarPoli[index].namaPoli,
                          style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold),
                        ),
                        Text("Nomor Antrian saat ini : NULL",
                            style: TextStyle(fontSize: 16.0)),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: ColorTheme.greenLight,
                          borderRadius: BorderRadius.all(
                              Radius.circular(15))),
                      height: 75,
                      width: 100,
                      child: Column(
                        mainAxisAlignment:
                        MainAxisAlignment.center,
                        children: [
                          Center(child: Text("Total Antrean")),
                          Text("-",
                              style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  )
                ],
              ));
        });
  }

  @override
  void initState() {
    _dashboardBloc.add(DashboardEventGetPoli());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => _dashboardBloc,
      child: Scaffold(
        backgroundColor: Colors.teal[50],
        appBar: AppBar(
          leading: Icon(Icons.home),
          title: Text("Daftar Poliklinik"),
          actions: [
            IconButton(icon: Icon(Icons.refresh), onPressed: (){
              _dashboardBloc.add(DashboardEventGetPoli());
            })
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            cardHeader(),
            Expanded(
              child: BlocBuilder<DashboardBloc, DashboardState>(
                bloc: _dashboardBloc,
                builder: (context, state) {
                  if (state is DashboardStateSuccess) {
                    return daftarPoliklinik(state.daftarPoli);
                  } else if (state is DashboardStateFailed) {
                    return Center(
                      child: Text(state.messageFailed),
                    );
                  } else {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: CircularProgressIndicator(),
                        ),
                        SizedBox(height: 8.0),
                        Center(
                          child: Text('Tuggu sebentar ...',
                              style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                  color: ColorTheme.greenDark)),
                        )
                      ],
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}