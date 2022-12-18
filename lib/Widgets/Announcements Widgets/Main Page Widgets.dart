import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pan_oceanic_sfe/Providers/firestore_provider.dart';
import 'package:provider/provider.dart';

class LeftBarAnouncementWidget extends StatefulWidget {
  Stream<QuerySnapshot> stream;
  LeftBarAnouncementWidget({required this.stream});

  @override
  State<LeftBarAnouncementWidget> createState() =>
      _LeftBarAnouncementWidgetState();
}

class _LeftBarAnouncementWidgetState extends State<LeftBarAnouncementWidget> {
  late double height;
  late double width;
  List<Color> profileColors = [
    Colors.red,
    Colors.green,
    Colors.purple,
    Colors.blue,
    Colors.black,
    Colors.orange
  ];
  late final dynamic firestoreProvider;
  @override
  void initState() {
    super.initState();
    firestoreProvider = Provider.of<FirestoreProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Container(
      width: width * 0.3,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: StreamBuilder<QuerySnapshot>(
          stream: widget.stream,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: SpinKitCircle(
                  color: Colors.black,
                ),
              );
            } else if (snapshot.data!.docs.isEmpty) {
              return const Center(
                child: Text(
                    'Could not load the latest announcements, Please try again'),
              );
            } else {
              return ListView.separated(
                  itemCount: snapshot.data?.docs.length ?? 0,
                  separatorBuilder: (BuildContext context, int index) =>
                      Padding(
                        padding: EdgeInsets.only(
                            left: width * 0.005, right: width * 0.005),
                        child: Container(
                          color: Colors.black.withOpacity(0.5),
                          height: 0.25,
                          width: width * 0.5,
                        ),
                      ),
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    var data = snapshot.data!.docs[index].data()
                        as Map<String, dynamic>;
                    //firestoreProvider.UpdateCurrentChosenNews(snapshot.data!.docs[0].id);
                    String publisherFirstName = data['byFirstName'];
                    String publisherLastName = data['byLastName'];
                    return GestureDetector(
                      onTap: () {
                        firestoreProvider.UpdateCurrentChosenNews(data['id']);
                      },
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(width * 0.018,
                            height * 0.03, width * 0.018, height * 0.03),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor: profileColors[
                                      Random().nextInt(profileColors.length)],
                                  child: Text(
                                    '${publisherFirstName[0]}${publisherLastName[0]}',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                SizedBox(
                                  width: width * 0.003,
                                ),
                                Expanded(
                                  child: Column(
                                    children: [
                                      Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            data['title'],
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          )),
                                      Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            '$publisherFirstName $publisherLastName',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.grey,
                                                fontSize: 12),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          )),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: height * 0.005,
                            ),
                            Text(
                              data['body'],
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            )
                          ],
                        ),
                      ),
                    );
                  });
            }
          }),
    );
  }
}

class RightAnnouncementDisplay extends StatefulWidget {
  const RightAnnouncementDisplay({Key? key}) : super(key: key);

  @override
  State<RightAnnouncementDisplay> createState() =>
      _RightAnnouncementDisplayState();
}

class _RightAnnouncementDisplayState extends State<RightAnnouncementDisplay> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          stream: Provider.of<FirestoreProvider>(context).getSpecificNewsStream(), builder: (context, snapshot) {
    if (snapshot.connectionState==ConnectionState.waiting) {
      return const Center(
        child: SpinKitCircle(
          color: Colors.black,
        ),
      );
    } else if(!snapshot.hasData){
      return Center(
        child:Text('An Error Occured, Please try again!'),
      );
    }  else if(!snapshot.data!.exists){
      return Center(
        child:Text('Select an announcement and a detailed view will appear here!'),
      );
    }else {
      var output = snapshot.data!.data();
      return Center(
        child:Text(output!['title']),
      );
    }
      }),
    );
  }
}
