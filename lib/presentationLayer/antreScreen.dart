import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobile_antrean_babatan/blocLayer/antre/antre_bloc.dart';
import 'package:mobile_antrean_babatan/dataLayer/model/poliklinik.dart';
import 'package:mobile_antrean_babatan/utils/color.dart';
import 'package:mobile_antrean_babatan/utils/loading.dart';
import 'package:mobile_antrean_babatan/utils/textFieldModified.dart';
import 'package:time_picker_widget/time_picker_widget.dart';

class Antre extends StatefulWidget {
  @override
  _AntreState createState() => _AntreState();
}

class _AntreState extends State<Antre> {
  AntreBloc _antreBloc = AntreBloc();

  @override
  void initState() {
    _antreBloc.add(AntreEventGetPoliklinik());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _antreBloc,
      child: Scaffold(
        appBar: AppBar(
          leading: Icon(Icons.add),
          title: Text("Pendaftaran Antrean"),
        ),
        body: BlocConsumer<AntreBloc, AntreState>(
          bloc: _antreBloc,
          listener: (context, state){
            if(state is AntreStateRegisterLoading){
              loading(context);
            }

            if(state is AntreStateSendMessage){
              Navigator.pop(context);
              Fluttertoast.showToast(msg: state.message, toastLength: Toast.LENGTH_LONG);
            }
          },
          builder: (context, state) {
            if (state is AntreStateGetPoliSuccess) {
              return viewNonBooking(state.daftarPoli);
            } else if (state is AntreStateChooseType) {
              if (_antreBloc.isBooking) {
                return viewBooking(state.daftarPoli);
              } else {
                return viewNonBooking(state.daftarPoli);
              }
            } else if (state is AntreStateChooseRegistType) {
              if (_antreBloc.isBooking) {
                return viewBooking(state.daftarPoli);
              } else {
                return viewNonBooking(state.daftarPoli);
              }
            } else if (state is AntreStateRegisterLoading) {
              if (_antreBloc.isBooking) {
                return viewBooking(state.daftarPoli);
              } else {
                return viewNonBooking(state.daftarPoli);
              }
            } else if (state is AntreStateSendMessage) {
              if (_antreBloc.isBooking) {
                return viewBooking(state.daftarPoli);
              } else {
                return viewNonBooking(state.daftarPoli);
              }
            } else if (state is AntreStateGetPoliFailed) {
              return Center(
                child: Text(state.errMessage),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }

  Future<DateTime> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: new DateTime(
            DateTime.now().year, DateTime.now().month, DateTime.now().day + 7));
    return picked;
  }

  ListView viewNonBooking(List<Poliklinik> daftarPoli) {
    return ListView(
      children: [
        Center(
          child: Container(
            padding: EdgeInsets.only(left: 20.0, top: 20.0),
            child: Text('Antre Pendaftaran Hari Ini',
                style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                    color: ColorTheme.greenDark)),
          ),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
          child: DropdownButtonFormField(
            decoration: InputDecoration(
                labelText: "Poli Tujuan",
                prefixIcon: Icon(Icons.local_hospital),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16.0))),
            value: _antreBloc.poliklinikTujuan,
            items: daftarPoli.map((value) {
              return DropdownMenuItem(
                child: Text(value.namaPoli),
                value: value,
              );
            }).toList(),
            onChanged: (value) {
              _antreBloc.poliklinikTujuan = value;
            },
          ),
        ),
        BlocBuilder<AntreBloc, AntreState>(
          bloc: _antreBloc,
          builder: (context, state) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                new Radio(
                  value: 0,
                  groupValue: _antreBloc.jenisPasien,
                  onChanged: (result) {
                    _antreBloc.add(AntreEventChooseType());
                  },
                ),
                new Text(
                  'Umum',
                  style: new TextStyle(fontSize: 16.0),
                ),
                new Radio(
                  value: 1,
                  groupValue: _antreBloc.jenisPasien,
                  onChanged: (result) {
                    _antreBloc.add(AntreEventChooseType());
                  },
                ),
                new Text(
                  'BPJS',
                  style: new TextStyle(
                    fontSize: 16.0,
                  ),
                ),
              ],
            );
          },
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0),
          child: InkWell(
            onTap: () {
              _antreBloc.add(AntreEventRegister());
            },
            child: Container(
              height: 40.0,
              child: Material(
                borderRadius: BorderRadius.circular(20.0),
                color: ColorTheme.greenDark,
                elevation: 7.0,
                child: Center(
                  child: Text(
                    'Daftar',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
          child: InkWell(
            onTap: () {
              _antreBloc.add(AntreEventChooseRegistType());
            },
            child: Container(
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
                        child: Text('Booking Antrean',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: ColorTheme.greenDark)))
                  ],
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  ListView viewBooking(List<Poliklinik> daftarPoli) {
    return ListView(
      children: [
        Center(
          child: Container(
            padding: EdgeInsets.only(left: 20.0, top: 20.0),
            child: Text('Booking Antrean',
                style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                    color: ColorTheme.greenDark)),
          ),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
          child: DropdownButtonFormField(
            decoration: InputDecoration(
                labelText: "Poli Tujuan",
                prefixIcon: Icon(Icons.local_hospital),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16.0))),
            value: _antreBloc.poliklinikTujuan,
            items: daftarPoli.map((value) {
              return DropdownMenuItem(
                child: Text(value.namaPoli),
                value: value,
              );
            }).toList(),
            onChanged: (value) {
              _antreBloc.poliklinikTujuan = value;
            },
          ),
        ),
        BlocBuilder<AntreBloc, AntreState>(
          bloc: _antreBloc,
          builder: (context, state) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                new Radio(
                  value: 0,
                  groupValue: _antreBloc.jenisPasien,
                  onChanged: (result) {
                    _antreBloc.add(AntreEventChooseType());
                  },
                ),
                new Text(
                  'Umum',
                  style: new TextStyle(fontSize: 16.0),
                ),
                new Radio(
                  value: 1,
                  groupValue: _antreBloc.jenisPasien,
                  onChanged: (result) {
                    _antreBloc.add(AntreEventChooseType());
                  },
                ),
                new Text(
                  'BPJS',
                  style: new TextStyle(
                    fontSize: 16.0,
                  ),
                ),
              ],
            );
          },
        ),
        Column(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(16.0, 0, 16.0, 16.0),
              child: Row(
                children: [
                  Flexible(
                    child: textFieldModified(
                        isEnabled: false,
                        label: 'Tanggal Booking',
                        icon: Icon(Icons.date_range),
                        controller: _antreBloc.tanggal),
                  ),
                  SizedBox(width: 16.0),
                  ElevatedButton(
                      onPressed: () {
                        _selectDate(context).then((value) {
                          if (value != null) {
                            _antreBloc.tanggalPelayanan = value;
                            _antreBloc.tanggal.text =
                                "${value.year.toString()}-${value.month.toString().padLeft(2, '0')}-${value.day.toString().padLeft(2, '0')}";
                          }
                        });
                      },
                      child: Icon(Icons.date_range))
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(16.0, 0, 16.0, 16.0),
              child: Row(
                children: [
                  Flexible(
                    child: textFieldModified(
                        isEnabled: false,
                        label: 'Pilih Jam Booking',
                        icon: Icon(Icons.timer),
                        controller: _antreBloc.jam),
                  ),
                  SizedBox(width: 16.0),
                  ElevatedButton(
                      onPressed: () {
                        showCustomTimePicker(
                            context: context,
                            onFailValidation: (context) =>
                                print('Unavailable selection'),
                            initialTime: TimeOfDay(hour: 11, minute: 0),
                            selectableTimePredicate: (time) =>
                                time.hour >= 8 &&
                                time.hour < 15 &&
                                time.minute % 12 == 0).then((value){
                                  if(value != null){
                                    _antreBloc.jamBooking = value;
                                    _antreBloc.jam.text = "${value.hour.toString().padLeft(2, '0')}:${value.minute.toString().padLeft(2, '0')}";
                                  }
                        });
                      },
                      child: Icon(Icons.timer))
                ],
              ),
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0),
          child: InkWell(
            onTap: () {
              _antreBloc.add(AntreEventRegister());
            },
            child: Container(
              height: 40.0,
              child: Material(
                borderRadius: BorderRadius.circular(20.0),
                color: ColorTheme.greenDark,
                elevation: 7.0,
                child: Center(
                  child: Text(
                    'Daftar',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
          child: InkWell(
            onTap: () {
              _antreBloc.add(AntreEventChooseRegistType());
            },
            child: Container(
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
                        child: Text('Daftar Antrean Hari Ini',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: ColorTheme.greenDark)))
                  ],
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
