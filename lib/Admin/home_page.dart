import 'package:flutter/material.dart';

import '../Customs/custom_drawer.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({Key? key}) : super(key: key);

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  late double height;
  late double width;
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xFFe4e4e4),
        elevation: 0,
        toolbarHeight: height*0.1,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text('ADMIN DASHBOARD',style: TextStyle(
          color: Colors.black,
          fontSize: 30,
          fontWeight: FontWeight.bold
        ),),
      ),
      drawer: const Drawer(
        child: CustomDrawerAdmin(),
      ),
    );
  }
}
