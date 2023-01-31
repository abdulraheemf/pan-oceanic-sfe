import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pan_oceanic_sfe/Providers/firestore_provider.dart';
import 'package:pan_oceanic_sfe/Services/constants.dart';
import 'package:provider/provider.dart';

import '../../Admin/Announcements/new_announcements_page.dart';
import '../../Customs/custom_alert.dart';

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
                    Color chosenColor = profileColors[
                    Random().nextInt(profileColors.length)];
                    var data = snapshot.data!.docs[index].data()
                        as Map<String, dynamic>;
                    String publisherFirstName = data['byFirstName'];
                    String publisherLastName = data['byLastName'];
                    return GestureDetector(
                      onTap: () {
                        firestoreProvider.UpdateNews(
                            data['body'],
                            data['title'],
                            data['byFirstName'],
                            data['byLastName'],
                            data['id'],
                            data['date'],
                            data['time'],
                            data['authorTitle']

                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(10),
                          color: Colors.white
                        ),
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(width * 0.018,
                              height * 0.03, width * 0.018, height * 0.03),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: chosenColor,
                                    child: Text(
                                      '${publisherFirstName[0]}${publisherLastName[0]}',
                                      style: const TextStyle(color: Colors.white),
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
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            )),
                                        Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              '$publisherFirstName $publisherLastName',
                                              style: const TextStyle(
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
  State<RightAnnouncementDisplay> createState() => _RightAnnouncementDisplayState();
}

class _RightAnnouncementDisplayState extends State<RightAnnouncementDisplay> {
  late double width;
  late double height;

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: (Provider.of<FirestoreProvider>(context).news['id']=='')?const Center(child: Text('Click on an announcement and a detailed view will appear here!'),)
          :Padding(
            padding: EdgeInsets.only(top: height*0.03,left: width*0.02),
            child: SingleChildScrollView(
              child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
              Row(
                children: [

                  SizedBox(width: width*0.005,),
                  Expanded(child: Padding(
                    padding: EdgeInsets.only(right: width*0.015),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: height*0.01,),
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 33,
                              backgroundColor: MyConstants.companyColor,
                              child: CircleAvatar(
                                radius: 31.5,
                                backgroundColor: Colors.white,
                                child: Text(
                                  '${Provider.of<FirestoreProvider>(context).news['firstName'][0]} ${Provider.of<FirestoreProvider>(context).news['lastName'][0]}',
                                  style: const TextStyle(color: MyConstants.companyColor,
                                    fontSize: 25,),
                                ),
                              ),
                            ),
                            SizedBox(width: width*0.005,),
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${Provider.of<FirestoreProvider>(context).news['firstName']} ${Provider.of<FirestoreProvider>(context).news['lastName']}',
                                    style: const TextStyle(color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    fontSize: 20),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    '${Provider.of<FirestoreProvider>(context).news['date']} ${Provider.of<FirestoreProvider>(context).news['time']}',
                                    style: const TextStyle(color: Colors.grey,),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: width*0.005,),
                            Container(
                              decoration: const ShapeDecoration(
                                shape: StadiumBorder(
                                  side: BorderSide(
                                    color: MyConstants.companyColor
                                  ),
                                )
                              ),
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(width*0.005, height*0.005, width*0.005, height*0.005),
                                child: Text(Provider.of<FirestoreProvider>(context).news['authorTitle'],style: const TextStyle(color: MyConstants.companyColor),),
                              ),
                            ),
                            SizedBox(width: width*0.005,),
                          ],
                        ),
                        SizedBox(height: height*0.02,),
                        Text(
                          Provider.of<FirestoreProvider>(context).news['title'],
                          style: const TextStyle(color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 30),
                          //maxLines: 1,
                          //overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: height*0.02,),
                        Text(
                          Provider.of<FirestoreProvider>(context).news['body'],
                          style: const TextStyle(color: Colors.black,fontSize: 20),
                          //maxLines: 1,
                          //overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  )),
                ],
              ),
        ],
      ),
            ),
      )
    );
  }
}

class SearchBarWidget extends StatefulWidget {
  TextEditingController control;
  SearchBarWidget({required this.control});

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  late double height;
  late double width;
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Container(
      height: height*0.05,
      width: width * 0.3,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: EdgeInsets.only(left: width * 0.008,right: width * 0.008),
        child: Row(
          children: [
            Icon(Icons.search,color: Colors.black.withOpacity(0.5),),
            SizedBox(width: width * 0.002,),
            Expanded(
              child: TextField(
                controller: widget.control,
                onChanged: (e){
                  Provider.of<FirestoreProvider>(context,listen: false).UpdateSearchValue(e);
                },
                decoration: InputDecoration.collapsed(hintText: 'Search',hintStyle: TextStyle(
                  color: Colors.black.withOpacity(0.5)
                )),
              ),
            )
          ],

        ),
      ),
    );
  }
}

class TopRightSideBar extends StatefulWidget {
  const TopRightSideBar({Key? key}) : super(key: key);

  @override
  State<TopRightSideBar> createState() => _TopRightSideBarState();
}

class _TopRightSideBarState extends State<TopRightSideBar> {
  late double height;
  late double width;
  void removeDialog(){
    Navigator.pop(context);
  }
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Container(
      height: height*0.05,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          SizedBox(
            width: width * 0.005,
          ),
          ElevatedButton(onPressed:(){
            Navigator.push(context, PageRouteBuilder(pageBuilder: (context, animation, secondaryAnimation) {
              return FadeTransition(
                opacity: animation,
                child: const NewAnnouncementsPage(),
              );
            },
              transitionDuration: const Duration(milliseconds: 180),
            ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
          ), child: const Text('Post an Announcement!'),),
          const Spacer(),
          (Provider.of<FirestoreProvider>(context).news['id'] == '')?const SizedBox():ElevatedButton(onPressed:(){
            ShowDialog.showErrorDialog(context, 'Are you sure?', 'Are you sure you wish to delete this announcement?', 'images/lotties/trash.json', 'Cancel', Colors.green, 'Delete', Colors.red, () async {
              await Provider.of<FirestoreProvider>(context,listen: false).deleteAnnouncement(Provider.of<FirestoreProvider>(context,listen: false).news['id']);
              removeDialog();
            }, height, width);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red
          ), child: const Icon(Icons.delete),),
          SizedBox(
            width: width * 0.005,
          ),
        ],

      ),
    );
  }
}


