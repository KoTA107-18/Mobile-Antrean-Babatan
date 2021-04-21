import 'package:flutter/material.dart';

class Antre extends StatefulWidget {
  @override
  _AntreState createState() => _AntreState();
}

class _AntreState extends State<Antre> with SingleTickerProviderStateMixin {
  TabController controller;

  @override
  void initState() {
    super.initState();
    controller = TabController(vsync: this, length: 2);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.add),
        title: Text("Pendaftaran Antrean"),
        bottom: TabBar(
          controller: controller,
          tabs: <Widget>[
            Tab(
              text: 'Hari Ini',
            ),
            Tab(
              text: 'Hari Lain',
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: controller,
        children: <Widget>[
          PageSatu(controller),
          PageDua(),
        ],
      ),
    );
  }
}

class PageDua extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Halaman Dua'),
      ),
    );
  }
}

class PageSatu extends StatelessWidget {
  TabController controller;
  PageSatu(this.controller);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Halaman Satu'),
      ),
    );
  }
}
