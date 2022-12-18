import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pan_oceanic_sfe/Widgets/Announcements%20Widgets/Custom%20Buttons.dart';
import 'package:pan_oceanic_sfe/Widgets/General%20Widgets/back_button%20Widget.dart';
import 'package:provider/provider.dart';

import '../Providers/firestore_provider.dart';
import '../Widgets/Announcements Widgets/Main Page Widgets.dart';

class AdminAnnouncements extends StatefulWidget {
  const AdminAnnouncements({Key? key}) : super(key: key);

  @override
  State<AdminAnnouncements> createState() => _AdminAnnouncementsState();
}

class _AdminAnnouncementsState extends State<AdminAnnouncements> {
  late double height;
  late double width;
  late final dynamic firestoreProvider;
  late Stream<QuerySnapshot> getLatestAnnouncementsStream;
  @override
  void initState(){
    super.initState();
    firestoreProvider = Provider.of<FirestoreProvider>(context, listen: false);
    getLatestAnnouncementsStream = firestoreProvider.getLatestAnnouncementsStream(100);
  }
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
            CustomBackButton(heading: 'ANNOUNCEMENTS',),
            // Row(
            //   children: [
            //     Expanded(child: CustomButton(name: 'Create a new announcement', icon: Icons.add_circle_outlined, color: Colors.green, onTap: () {  },),),
            //     SizedBox(width: width*0.01,),
            //     Expanded(child: CustomButton(name: 'Search for an announcement', icon: Icons.search, color: Colors.blue, onTap: () {  },),),
            //     SizedBox(width: width*0.01,),
            //     Expanded(child: CustomButton(name: 'Delete an announcement', icon: Icons.delete, color: Colors.red, onTap: () {  },),),
            //     SizedBox(width: width*0.01,),
            //   ],
            // ),
            Expanded(child: Row(
              children: [
                LeftBarAnouncementWidget(stream: getLatestAnnouncementsStream,),
                SizedBox(width: width*0.01,),
                Expanded(child: RightAnnouncementDisplay()),
              ],
            )),
            SizedBox(height: height*0.019,),

          ],
        ),
      ),
    );
  }
}
