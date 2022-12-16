import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lottie/lottie.dart';
import 'package:pan_oceanic_sfe/Services/constants.dart';
import 'package:pan_oceanic_sfe/Widgets/HomePage%20Widgets/Future%20Builders.dart';
import 'package:provider/provider.dart';
import '../Providers/firestore_provider.dart';
import '../Providers/storage_provider.dart';
import '../Widgets/HomePage Widgets/Home Page Cards.dart';
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
  late final Future<String> getCurrentUsernameFuture;
  late final Future getSFEGoalFuture;
  late final Future getInsuranceCompletedGoalFuture;
  late final Future getInsuranceNotCompletedGoalFuture;
  late final Future getNumberOfInvoicesGoalFuture;
  late final Future getNewClientsGoalFuture;
  late final dynamic storageProvider;
  late final Future<String>getProfilePictureFuture;
  @override
  void initState(){
    super.initState();
    firestoreProvider = Provider.of<FirestoreProvider>(context, listen: false);
    getCurrentUsernameFuture = firestoreProvider.getCurrentUserName();
    storageProvider = Provider.of<StorageProvider>(context, listen: false);
    getProfilePictureFuture = storageProvider.getProfilePicture();
    getSFEGoalFuture = firestoreProvider.getCurrentSFEGoal();
    getInsuranceCompletedGoalFuture = firestoreProvider.getInsuranceCompletedGoal();
    getInsuranceNotCompletedGoalFuture = firestoreProvider.getInsuranceNotCompletedGoal();
    getNewClientsGoalFuture = firestoreProvider.getNewClientsGoals();
    getNumberOfInvoicesGoalFuture = firestoreProvider.getNumberOfInvoices();


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
                  HomePageLeftColumnEntry(icon: Icons.announcement, description: 'Announcements', isHome: false,onTap: (){},),
                  SizedBox(height: height*0.01,),
                  HomePageLeftColumnEntry(icon: Icons.bar_chart, description: 'Progress', isHome: false,onTap: (){},),
                  SizedBox(height: height*0.01,),
                  HomePageLeftColumnEntry(icon: Icons.show_chart, description: 'Goals', isHome: false,onTap: (){},),
                  SizedBox(height: height*0.01,),
                  HomePageLeftColumnEntry(icon: Icons.person, description: 'My Account', isHome: false,onTap: (){},),
                  SizedBox(height: height*0.01,),
                  HomePageLeftColumnEntry(icon: Icons.people, description: 'SFEs', isHome: false,onTap: (){},),
                  SizedBox(height: height*0.01,),
                  HomePageLeftColumnEntry(icon: Icons.receipt, description: 'Invoices', isHome: false,onTap: (){},),
                  SizedBox(height: height*0.01,),
                  HomePageLeftColumnEntry(icon: Icons.settings, description: 'Settings', isHome: false,onTap: (){},),
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
                                HomePageCards( description: 'Number of SFEs',typeOfCard: 2,goals: getSFEGoalFuture),
                                SizedBox(width: width*0.01,),
                                HomePageCards( description: 'Number of Invoices',goals: getNumberOfInvoicesGoalFuture,),
                                SizedBox(width: width*0.01,),
                                HomePageCards( description: 'Insurance Not Completed',goals: getInsuranceNotCompletedGoalFuture,),
                                SizedBox(width: width*0.01,),
                                HomePageCards( description: 'New Clients',typeOfCard: 3,goals: getNewClientsGoalFuture,),
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
                              HomePageCards( description: 'Insurance Completed this month',typeOfCard: 5,isBig: true,goals: getInsuranceCompletedGoalFuture,),
                            ],
                          ),
                        ],
                      ),
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


