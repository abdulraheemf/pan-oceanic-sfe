import 'package:flutter/material.dart';

import '../../Widgets/General Widgets/back_button Widget.dart';

class NewAnnouncementsPage extends StatefulWidget {
  const NewAnnouncementsPage({Key? key}) : super(key: key);

  @override
  State<NewAnnouncementsPage> createState() => _NewAnnouncementsPageState();
}

class _NewAnnouncementsPageState extends State<NewAnnouncementsPage> {
  late double width;
  late double height;
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(left: width * 0.01, right: width * 0.01),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomBackButton(
              heading: 'CREATE NEW ANNOUNCEMENT',
            ),
          ],
        ),
      ),
    );
  }
}
