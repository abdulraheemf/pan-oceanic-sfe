import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pan_oceanic_sfe/Admin/Progress/goals_page.dart';
import 'package:pan_oceanic_sfe/Services/constants.dart';
import 'package:pan_oceanic_sfe/Widgets/General%20Widgets/back_button%20Widget.dart';
import 'package:provider/provider.dart';

import '../../Providers/firestore_provider.dart';
import '../../Widgets/HomePage Widgets/Home Page Cards.dart';
import '../../Widgets/Progess Widgets/progress_cards.dart';

class AdminProgressPage extends StatefulWidget {
  const AdminProgressPage({Key? key}) : super(key: key);

  @override
  State<AdminProgressPage> createState() => _AdminProgressPageState();
}

class _AdminProgressPageState extends State<AdminProgressPage> {
  late double height;
  late double width;
  late final dynamic firestoreProvider;
  late final Future getSFEGoalFuture;
  late final Future getInsuranceCompletedGoalFuture;
  late final Future getInsuranceNotCompletedGoalFuture;
  late final Future getNumberOfInvoicesGoalFuture;
  late final Future getNewClientsGoalFuture;
  late Stream<DocumentSnapshot<Map<String, dynamic>>> getCurrentSFEStream;
  late Stream<DocumentSnapshot<Map<String, dynamic>>>
      getCurrentInsuranceCompletedStream;
  late Stream<DocumentSnapshot<Map<String, dynamic>>>
      getCurrentInsuranceNotCompletedStream;
  late Stream<DocumentSnapshot<Map<String, dynamic>>> getNewClientStream;
  late Stream<DocumentSnapshot<Map<String, dynamic>>>
      getCurrentNumberOfInvoicesStream;
  @override
  void initState() {
    super.initState();
    firestoreProvider = Provider.of<FirestoreProvider>(context, listen: false);
    getSFEGoalFuture = firestoreProvider.getCurrentSFEGoal();
    getInsuranceCompletedGoalFuture =
        firestoreProvider.getInsuranceCompletedGoal();
    getInsuranceNotCompletedGoalFuture =
        firestoreProvider.getInsuranceNotCompletedGoal();
    getNewClientsGoalFuture = firestoreProvider.getNewClientsGoals();
    getNumberOfInvoicesGoalFuture = firestoreProvider.getNumberOfInvoices();
    getCurrentSFEStream = firestoreProvider.getCurrentNumberOfSFEStream();
    getCurrentInsuranceCompletedStream =
        firestoreProvider.getCurrentInsuranceCompletedStream();
    getCurrentInsuranceNotCompletedStream =
        firestoreProvider.getCurrentInsuranceNotCompletedStream();
    getNewClientStream = firestoreProvider.getCurrentNumberOfNewClientsStream();
    getCurrentNumberOfInvoicesStream =
        firestoreProvider.getCurrentNumberOfInvoicesStream();
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
              heading: 'PROGRESS',
            ),
            Container(
              height: height * 0.05,
              width: width,
              decoration: BoxDecoration(
                  color: MyConstants.homePageLeftMenuColor,
                  borderRadius: BorderRadius.circular(5)),
              child: Row(
                children: [
                  SizedBox(
                    width: width * 0.005,
                  ),
                  const Text(
                    'Goals are the road maps that guide you to your destination',
                    style: TextStyle(color: Colors.white),
                  ),
                  Spacer(),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) {
                            return FadeTransition(
                              opacity: animation,
                              child: const AdminGoalsPage(),
                            );
                          },
                          transitionDuration: const Duration(milliseconds: 180),
                        ),
                      );
                    },
                    child: Text(
                      'Set Company Goals',
                      style: TextStyle(color: Colors.black),
                    ),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: MyConstants.goodCardHomePageCardColor),
                  ),
                  SizedBox(
                    width: width * 0.005,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: height * 0.01,
            ),
            Row(
              children: [
                Expanded(
                    child: ProgressPageCards(
                  description: 'Number of SFEs',
                  typeOfCard: 2,
                  goals: getSFEGoalFuture,
                  stream: getCurrentSFEStream,
                )),
                SizedBox(
                  width: width * 0.01,
                ),
                Expanded(
                    child: ProgressPageCards(
                  description: 'Number of Invoices This Month',
                  goals: getNumberOfInvoicesGoalFuture,
                  stream: getCurrentNumberOfInvoicesStream,
                )),
                SizedBox(
                  width: width * 0.01,
                ),
                Expanded(
                    child: ProgressPageCards(
                  description: 'Insurance Not Completed This Month',
                  goals: getInsuranceNotCompletedGoalFuture,
                  stream: getCurrentInsuranceNotCompletedStream,
                )),
                SizedBox(
                  width: width * 0.01,
                ),
                Expanded(
                    child: ProgressPageCards(
                  description: 'New Clients This Month',
                  typeOfCard: 3,
                  goals: getNewClientsGoalFuture,
                  stream: getNewClientStream,
                )),
                SizedBox(
                  width: width * 0.01,
                ),
                Expanded(
                    flex: 2,
                    child: ProgressPageCards(
                      description: 'Insurance Completed this month',
                      typeOfCard: 5,
                      isBig: true,
                      goals: getInsuranceCompletedGoalFuture,
                      stream: getCurrentInsuranceCompletedStream,
                    )),
                SizedBox(
                  width: width * 0.01,
                ),
              ],
            ),
            SizedBox(
              height: height * 0.04,
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Text(
                            'TOP PERFORMING SFEs',
                            style: TextStyle(fontSize: 18),
                          ),
                          Spacer(),
                          GestureDetector(
                              onTap: () {},
                              child: Text(
                                'See all',
                                style: TextStyle(
                                    color: Colors.black.withOpacity(0.4)),
                              ))
                        ],
                      ),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      Expanded(
                          child: Padding(
                        padding: EdgeInsets.only(bottom: height * 0.01),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5)),
                          child: Center(
                            child: Text('SFEs with the most insurance sales per month will appear here'),
                          ),
                        ),
                      ))
                    ],
                  )),
                  Padding(
                    padding: EdgeInsets.fromLTRB(width * 0.005, height * 0.02,
                        width * 0.005, height * 0.01),
                    child: Container(
                      height: double.infinity,
                      width: width * 0.0001,
                      color: Colors.grey,
                    ),
                  ),
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Text(
                            'MOST USED INSURANCE COMPANIES',
                            style: TextStyle(fontSize: 18),
                          ),
                          Spacer(),
                          GestureDetector(
                              onTap: () {
                                print('YA');
                              },
                              child: Text(
                                'See all',
                                style: TextStyle(
                                    color: Colors.black.withOpacity(0.4)),
                              ))
                        ],
                      ),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      Expanded(
                          child: Padding(
                        padding: EdgeInsets.only(bottom: height * 0.01),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5)),
                          child: Center(
                            child: Text('Most used insurance companies will appear here'),
                          ),
                        ),
                      ))
                    ],
                  )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
