import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lottie/lottie.dart';
import 'package:pan_oceanic_sfe/Admin/SFEs_page.dart';
import 'package:pan_oceanic_sfe/Admin/announcements_page.dart';
import 'package:pan_oceanic_sfe/Admin/goals_page.dart';
import 'package:pan_oceanic_sfe/Admin/invoices_page.dart';
import 'package:pan_oceanic_sfe/Admin/myAccount_page.dart';
import 'package:pan_oceanic_sfe/Admin/progress_page.dart';
import 'package:pan_oceanic_sfe/Admin/settings_page.dart';
import 'package:pan_oceanic_sfe/Auth/auth.dart';
import 'package:pan_oceanic_sfe/Customs/custom_alert.dart';
import 'package:pan_oceanic_sfe/Providers/auth_provider.dart';
import 'package:pan_oceanic_sfe/Services/constants.dart';
import 'package:pan_oceanic_sfe/Widgets/HomePage%20Widgets/Future%20Builders.dart';
import 'package:provider/provider.dart';
import '../Providers/firestore_provider.dart';
import '../Providers/storage_provider.dart';
import '../Widgets/HomePage Widgets/Announcements.dart';
import '../Widgets/HomePage Widgets/Home Page Cards.dart';
import '../Widgets/HomePage Widgets/Home Page Quick Link.dart';
import '../Widgets/HomePage Widgets/Left Bar Column.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({Key? key}) : super(key: key);

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  late double height;
  late double width;
  late final dynamic firestoreProvider;
  late final dynamic authProvider;
  late final Future<String> getCurrentUsernameFuture;
  late final Future getSFEGoalFuture;
  late final Future getInsuranceCompletedGoalFuture;
  late final Future getInsuranceNotCompletedGoalFuture;
  late final Future getNumberOfInvoicesGoalFuture;
  late final Future getNewClientsGoalFuture;
  late final dynamic storageProvider;
  late final Future<String>getProfilePictureFuture;
  late Stream<DocumentSnapshot<Map<String, dynamic>>> getCurrentSFEStream;
  late Stream<DocumentSnapshot<Map<String, dynamic>>> getCurrentInsuranceCompletedStream;
  late Stream<DocumentSnapshot<Map<String, dynamic>>> getCurrentInsuranceNotCompletedStream;
  late Stream<DocumentSnapshot<Map<String, dynamic>>> getNewClientStream;
  late Stream<DocumentSnapshot<Map<String, dynamic>>> getCurrentNumberOfInvoicesStream;
  late Stream<QuerySnapshot> getLatestAnnouncementsStream;
  @override
  void initState(){
    super.initState();
    firestoreProvider = Provider.of<FirestoreProvider>(context, listen: false);
    authProvider = Provider.of<AuthProvider>(context, listen: false);
    getCurrentUsernameFuture = firestoreProvider.getCurrentUserName();
    storageProvider = Provider.of<StorageProvider>(context, listen: false);
    getProfilePictureFuture = storageProvider.getProfilePicture();
    getSFEGoalFuture = firestoreProvider.getCurrentSFEGoal();
    getInsuranceCompletedGoalFuture = firestoreProvider.getInsuranceCompletedGoal();
    getInsuranceNotCompletedGoalFuture = firestoreProvider.getInsuranceNotCompletedGoal();
    getNewClientsGoalFuture = firestoreProvider.getNewClientsGoals();
    getNumberOfInvoicesGoalFuture = firestoreProvider.getNumberOfInvoices();
    getCurrentSFEStream = firestoreProvider.getCurrentNumberOfSFEStream();
    getCurrentInsuranceCompletedStream = firestoreProvider.getCurrentInsuranceCompletedStream();
    getCurrentInsuranceNotCompletedStream = firestoreProvider.getCurrentInsuranceNotCompletedStream();
    getNewClientStream = firestoreProvider.getCurrentNumberOfNewClientsStream();
    getCurrentNumberOfInvoicesStream = firestoreProvider.getCurrentNumberOfInvoicesStream();
    getLatestAnnouncementsStream = firestoreProvider.getLatestAnnouncementsStream(5);
    firestoreProvider.fetchCurrentUserData();
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Row(
        children: [
          Container(
            height: height,
            width: width*0.17,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(bottomRight: Radius.circular(20),topRight: Radius.circular(20)),
              color: MyConstants.homePageLeftMenuColor,
            ),
            child: Padding(
              padding: EdgeInsets.only(left: width*0.01,right: width*0.01),
              child: Column(
                children: [
                  SizedBox(height: height*0.03,),
                  Container(
                    height: height*0.14,
                    decoration: BoxDecoration(
                      color: MyConstants.homePageLogoContainer,
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: Center(child: Image.asset('images/logos/icon.png',height: height*0.1,)),
                  ),
                  SizedBox(height: height*0.03,),
                  HomePageLeftColumnEntry(icon: Icons.home, description: 'Home', isHome: true,onTap: (){},),
                  SizedBox(height: height*0.01,),
                  HomePageLeftColumnEntry(icon: Icons.announcement, description: 'Announcements', isHome: false,onTap: (){
                    Navigator.push(context, PageRouteBuilder(pageBuilder: (context, animation, secondaryAnimation) {
                      return FadeTransition(
                        opacity: animation,
                        child: const AdminAnnouncements(),
                      );
                    },
                      transitionDuration: const Duration(milliseconds: 180),
                    ),
                    );
                  },),
                  SizedBox(height: height*0.01,),
                  HomePageLeftColumnEntry(icon: Icons.bar_chart, description: 'Progress', isHome: false,onTap: (){
                    Navigator.push(context, PageRouteBuilder(pageBuilder: (context, animation, secondaryAnimation) {
                      return FadeTransition(
                        opacity: animation,
                        child: const AdminProgressPage(),
                      );
                    },
                      transitionDuration: const Duration(milliseconds: 180),
                    ),
                    );
                  },),
                  SizedBox(height: height*0.01,),
                  HomePageLeftColumnEntry(icon: Icons.show_chart, description: 'Goals', isHome: false,onTap: (){
                    Navigator.push(context, PageRouteBuilder(pageBuilder: (context, animation, secondaryAnimation) {
                      return FadeTransition(
                        opacity: animation,
                        child: const AdminGoalsPage(),
                      );
                    },
                      transitionDuration: const Duration(milliseconds: 180),
                    ),
                    );
                  },),
                  SizedBox(height: height*0.01,),
                  HomePageLeftColumnEntry(icon: Icons.person, description: 'My Account', isHome: false,onTap: (){
                    Navigator.push(context, PageRouteBuilder(pageBuilder: (context, animation, secondaryAnimation) {
                      return FadeTransition(
                        opacity: animation,
                        child: const AdminMyAccount(),
                      );
                    },
                      transitionDuration: const Duration(milliseconds: 180),
                    ),
                    );
                  },),
                  SizedBox(height: height*0.01,),
                  HomePageLeftColumnEntry(icon: Icons.people, description: 'SFEs', isHome: false,onTap: (){
                    Navigator.push(context, PageRouteBuilder(pageBuilder: (context, animation, secondaryAnimation) {
                      return FadeTransition(
                        opacity: animation,
                        child: const AdminSFEsPage(),
                      );
                    },
                      transitionDuration: const Duration(milliseconds: 180),
                    ),
                    );
                  },),
                  SizedBox(height: height*0.01,),
                  HomePageLeftColumnEntry(icon: Icons.receipt, description: 'Invoices', isHome: false,onTap: (){
                    Navigator.push(context, PageRouteBuilder(pageBuilder: (context, animation, secondaryAnimation) {
                      return FadeTransition(
                        opacity: animation,
                        child: const AdminInvoicesPage(),
                      );
                    },
                      transitionDuration: const Duration(milliseconds: 180),
                    ),
                    );
                  },),
                  SizedBox(height: height*0.01,),
                  HomePageLeftColumnEntry(icon: Icons.settings, description: 'Settings', isHome: false,onTap: (){
                    Navigator.push(context, PageRouteBuilder(pageBuilder: (context, animation, secondaryAnimation) {
                      return FadeTransition(
                        opacity: animation,
                        child: const AdminSettingsPage(),
                      );
                    },
                      transitionDuration: const Duration(milliseconds: 180),
                    ),
                    );
                  },),
                  SizedBox(height: height*0.01,),
                  HomePageLeftColumnEntry(icon: Icons.logout, description: 'Sign Out', isHome: false,onTap: (){
                    ShowDialog.showErrorDialog(context, 'ARE YOU SURE?', 'Are you sure you wish to sign out?', 'images/lotties/log-out.json', 'Cancel', Colors.red, 'Confirm', Colors.green, () {
                      authProvider.signOut();
                      Navigator.pushReplacement(context, PageRouteBuilder(pageBuilder: (context, animation, secondaryAnimation) {
                        return FadeTransition(
                          opacity: animation,
                          child: const Authentication(),
                        );
                      },
                        transitionDuration: const Duration(milliseconds: 180),
                      ),
                      );
                    }, height, width);
                  },),
                ],
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding:EdgeInsets.only(left: width*0.03,right: width*0.03),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: height*0.03,),
                  Align(
                    alignment: Alignment.centerRight,
                    child: GetProfilePictureFutureBuilder(profilePictureFuture: getProfilePictureFuture,)
                  ),
                  HelloMessageFutureBuilder(currentUserName: getCurrentUsernameFuture,),
                  SizedBox(height: height*0.005,),
                  const Text(MyConstants.motivationalMessage),
                  SizedBox(height: height*0.03,),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Progress',style: TextStyle(color: Colors.black.withOpacity(0.5)),),
                            SizedBox(height: height*0.01,),
                            Row(
                              children: [
                                HomePageCards( description: 'Number of SFEs',typeOfCard: 2,goals: getSFEGoalFuture,stream: getCurrentSFEStream,),
                                SizedBox(width: width*0.01,),
                                HomePageCards( description: 'Number of Invoices This Month',goals: getNumberOfInvoicesGoalFuture,stream: getCurrentNumberOfInvoicesStream,),
                                SizedBox(width: width*0.01,),
                                HomePageCards( description: 'Insurance Not Completed This Month',goals: getInsuranceNotCompletedGoalFuture,stream: getCurrentInsuranceNotCompletedStream,),
                                SizedBox(width: width*0.01,),
                                HomePageCards( description: 'New Clients This Month',typeOfCard: 3,goals: getNewClientsGoalFuture,stream: getNewClientStream,),
                                SizedBox(width: width*0.01,),
                              ],
                            ),
                          ],
                        ),

                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Insurance Done',style: TextStyle(color: Colors.black.withOpacity(0.5)),),
                          SizedBox(height: height*0.01,),
                          Row(
                            children: [
                              HomePageCards( description: 'Insurance Completed this month',typeOfCard: 5,isBig: true,goals: getInsuranceCompletedGoalFuture,stream: getCurrentInsuranceCompletedStream,),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: height*0.03,),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Quick Links',style: TextStyle(color: Colors.black.withOpacity(0.5)),),
                          SizedBox(height: height*0.01,),
                          HomePageQuickLink(description: 'Create New Account', icon: Icons.add, onTap: () {
                            Navigator.push(context, PageRouteBuilder(pageBuilder: (context, animation, secondaryAnimation) {
                              return FadeTransition(
                                opacity: animation,
                                child: const AdminSFEsPage(),
                              );
                            },
                              transitionDuration: const Duration(milliseconds: 180),
                            ),
                            );
                          },),
                          SizedBox(height: height*0.02,),
                          HomePageQuickLink(description: 'View Company Performance', icon: Icons.show_chart, onTap: () {
                            Navigator.push(context, PageRouteBuilder(pageBuilder: (context, animation, secondaryAnimation) {
                              return FadeTransition(
                                opacity: animation,
                                child: const AdminProgressPage(),
                              );
                            },
                              transitionDuration: const Duration(milliseconds: 180),
                            ),
                            );
                          },),
                          SizedBox(height: height*0.02,),
                          HomePageQuickLink(description: 'Check Current SFEs', icon: Icons.people, onTap: () {
                            Navigator.push(context, PageRouteBuilder(pageBuilder: (context, animation, secondaryAnimation) {
                              return FadeTransition(
                                opacity: animation,
                                child: const AdminSFEsPage(),
                              );
                            },
                              transitionDuration: const Duration(milliseconds: 180),
                            ),
                            );
                          },),
                        ],
                      ),
                      SizedBox(width: width*0.03,),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Announcements',style: TextStyle(color: Colors.black.withOpacity(0.5)),),
                            SizedBox(height: height*0.01,),
                            Announcements(stream: getLatestAnnouncementsStream,),
                          ],
                        ),
                      )
                    ],
                  )

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}


