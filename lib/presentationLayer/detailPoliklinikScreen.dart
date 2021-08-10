import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_antrean_babatan/blocLayer/detailPoliklinik/detail_poliklinik_bloc.dart';
import 'package:mobile_antrean_babatan/dataLayer/model/InfoPoliklinik.dart';
import 'package:mobile_antrean_babatan/utils/color.dart';

class DetailPoliklinikScreen extends StatefulWidget {
  InfoPoliklinik poli;

  DetailPoliklinikScreen(this.poli);

  @override
  _DetailPoliklinikScreenState createState() => _DetailPoliklinikScreenState();
}

class _DetailPoliklinikScreenState extends State<DetailPoliklinikScreen> {
  DetailPoliklinikBloc _detailPoliklinikBloc = DetailPoliklinikBloc();

  @override
  void initState() {
    _detailPoliklinikBloc.add(
        DetailPoliklinikEventGetPoli(idPoli: widget.poli.idPoli.toString()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => _detailPoliklinikBloc,
      child: Scaffold(
        appBar: AppBar(
          leading: Icon(Icons.local_hospital),
          title: Text(widget.poli.namaPoli.toString()),
        ),
        body: BlocBuilder<DetailPoliklinikBloc, DetailPoliklinikState>(
          bloc: _detailPoliklinikBloc,
          builder: (context, state) {
            if (state is DetailPoliklinikStateSuccess) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 16.0,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Card(
                          child: Container(
                              padding: EdgeInsets.all(16.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Antrean Tersisa',
                                        style: TextStyle(fontSize: 16.0),
                                      ),
                                      Text(
                                        (widget.poli.totalAntrean.length == 0)
                                            ? "0"
                                            : "${widget.poli.totalAntrean[0].result}",
                                        style: TextStyle(
                                            fontSize: 24.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  Icon(
                                    Icons.bar_chart,
                                    size: 36,
                                  )
                                ],
                              )),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Card(
                          child: Container(
                              padding: EdgeInsets.all(16.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Antrean Saat Ini',
                                        style: TextStyle(fontSize: 16.0),
                                      ),
                                      Text(
                                        (widget.poli.nomorAntrean.length == 0)
                                            ? "0"
                                            : "${widget.poli.nomorAntrean[0].result}",
                                        style: TextStyle(
                                            fontSize: 24.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  Icon(
                                    Icons.info_outline,
                                    size: 36,
                                  )
                                ],
                              )),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      state.daftarPoli.descPoli,
                      textAlign: TextAlign.justify,
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Card(
                          color: ColorTheme.greenLight,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Batas Booking " +
                                  state.daftarPoli.batasBooking +
                                  " Hari",
                              style: TextStyle(fontSize: 16.0),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Card(
                          color: ColorTheme.greenLight,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: (state.daftarPoli.statusPoli == "0")
                                ? Text(
                                    "Tidak Aktif",
                                    style: TextStyle(fontSize: 16.0),
                                  )
                                : Text(
                                    "Aktif",
                                    style: TextStyle(fontSize: 16.0),
                                  ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      "Jadwal",
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 4.0,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: state.daftarPoli.jadwal.length,
                        itemBuilder: (context, index) {
                          return Text(
                              (state.daftarPoli.jadwal[index].hari == "SN") ? "Senin, " :
                              (state.daftarPoli.jadwal[index].hari == "SL") ? "Selasa, " :
                              (state.daftarPoli.jadwal[index].hari == "RB") ? "Rabu, " :
                              (state.daftarPoli.jadwal[index].hari == "KM") ? "Kamis, " :
                              (state.daftarPoli.jadwal[index].hari == "JM") ? "Jumat, " :
                              (state.daftarPoli.jadwal[index].hari == "SB") ? "Sabtu, " : "Minggu, "
                          );
                        },
                      ),
                    ),
                  ),
                ],
              );
            } else if (state is DetailPoliklinikStateFailed) {
              return Center(
                child: Text(state.errMessage),
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
    );
  }
}
