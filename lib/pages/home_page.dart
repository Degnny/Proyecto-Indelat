import 'package:flutter/material.dart';
import 'package:flutter_indelatv11/pages/list_proyect.dart';
import 'package:flutter_indelatv11/widgets/navBar.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBar(),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Image.asset(
          'assets/logo-indelat.png',
          width: 120,
          height: 40.0,
          ),
      ),
    body: ListProyectPage(),

    );
  }
}

