import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import '../../Providers/firestore_provider.dart';
import '../../Services/constants.dart';

class Announcements extends StatefulWidget {
  Stream<QuerySnapshot> stream;
  Announcements({required this.stream});

  @override
  State<Announcements> createState() => _AnnouncementsState();
}

class _AnnouncementsState extends State<Announcements> {
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
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Container(
      height: height * 0.4,
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
                    'There are no announcements!'),
              );
            }  else if (snapshot.connectionState == ConnectionState.none){
              return const Center(
                child: Text(
                    'Could not load the latest announcements, Please try again'),
              );
            }else {
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
                    String publisherFirstName = data['byFirstName'];
                    String publisherLastName = data['byLastName'];
                    List readBy = data['readBy'];
                    return Padding(
                      padding: EdgeInsets.fromLTRB(width * 0.018,
                          height * 0.03, width * 0.018, height * 0.03),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              if(!readBy.contains(Provider.of<FirestoreProvider>(context,listen: false).currentUserID))
                                CircleAvatar(
                                  radius: 4.5,
                                  backgroundColor: MyConstants.companyColor,
                                ),
                              SizedBox(
                                width: width * 0.003,
                              ),
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
                    );
                  });
            }
          }),
    );
  }
}
