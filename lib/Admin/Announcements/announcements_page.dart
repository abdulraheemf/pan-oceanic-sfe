import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pan_oceanic_sfe/Widgets/Announcements%20Widgets/Custom%20Buttons.dart';
import 'package:pan_oceanic_sfe/Widgets/General%20Widgets/back_button%20Widget.dart';
import 'package:provider/provider.dart';

import '../../Providers/firestore_provider.dart';
import '../../Widgets/Announcements Widgets/Announcements Main Page Widgets.dart';

class AdminAnnouncements extends StatefulWidget {
  const AdminAnnouncements({Key? key}) : super(key: key);

  @override
  State<AdminAnnouncements> createState() => _AdminAnnouncementsState();
}

class _AdminAnnouncementsState extends State<AdminAnnouncements> {
  late TextEditingController searchController = TextEditingController();
  late double height;
  late double width;
  late final dynamic firestoreProvider;
  late Stream<QuerySnapshot> getLatestAnnouncementsStream;
  late Stream<QuerySnapshot> getSearchAnnouncementsStream;

  @override
  void initState() {
    super.initState();
    firestoreProvider = Provider.of<FirestoreProvider>(context, listen: false);
    getLatestAnnouncementsStream =
        firestoreProvider.getLatestAnnouncementsStream(100);
    searchController.addListener(() {
      getSearchAnnouncementsStream = firestoreProvider.getSearchNewsStream(searchController.text);
    });

  }

  @override
  void dispose() {
    super.dispose();
    firestoreProvider.UpdateNewsWithoutNotifying(
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        ''
    );
    searchController.dispose();

  }

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
              heading: 'ANNOUNCEMENTS',
            ),
            Expanded(
                child: Row(
              children: [
                Consumer<FirestoreProvider>(
                    builder: (context, firestore, child) {
                  return Column(
                    children: [
                      SearchBarWidget(
                        control: searchController,
                      ),
                      SizedBox(
                        height: height * 0.013,
                      ),
                      Expanded(
                          child: (firestore.searchValue ==
                                  '')
                              ? LeftBarAnouncementWidget(
                                  stream: getLatestAnnouncementsStream,
                                )
                              : LeftBarAnouncementWidget(
                                  stream:getSearchAnnouncementsStream)),
                    ],
                  );
                }),
                SizedBox(
                  width: width * 0.01,
                ),
                Expanded(
                    child: Column(
                  children: [
                    TopRightSideBar(),
                    SizedBox(
                      height: height * 0.013,
                    ),
                    Expanded(child: RightAnnouncementDisplay()),
                  ],
                )),
              ],
            )),
            SizedBox(
              height: height * 0.019,
            ),
          ],
        ),
      ),
    );
  }
}
