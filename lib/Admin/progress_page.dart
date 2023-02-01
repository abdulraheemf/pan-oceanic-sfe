import 'package:flutter/material.dart';
import 'package:pan_oceanic_sfe/Widgets/General%20Widgets/back_button%20Widget.dart';

class AdminProgressPage extends StatefulWidget {
  const AdminProgressPage({Key? key}) : super(key: key);

  @override
  State<AdminProgressPage> createState() => _AdminProgressPageState();
}

class _AdminProgressPageState extends State<AdminProgressPage> {
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
            CustomBackButton(heading: 'PROGRESS',),
            Row(
              children: [
                Expanded(child: Center(child: Text('HELLO'),)),
                Container(height: height*0.9,width: width*0.0001,color: Colors.black,),
                Expanded(child: Center(child: Text('HELLO'),)),
              ],
            )
          ],
        ),
      ),
    );
  }
}
