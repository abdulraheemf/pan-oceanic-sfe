import 'package:flutter/material.dart';
import 'package:pan_oceanic_sfe/Widgets/General%20Widgets/back_button%20Widget.dart';

class AdminSFEsPage extends StatefulWidget {
  const AdminSFEsPage({Key? key}) : super(key: key);

  @override
  State<AdminSFEsPage> createState() => _AdminSFEsPageState();
}

class _AdminSFEsPageState extends State<AdminSFEsPage> {
  late double height;
  late double width;
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(left: width*0.01,right: width*0.01),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomBackButton(heading: 'SFEs',),
          ],
        ),
      ),
    );
  }
}
