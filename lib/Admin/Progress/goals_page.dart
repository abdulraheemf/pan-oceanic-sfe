import 'package:flutter/material.dart';
import 'package:pan_oceanic_sfe/Services/constants.dart';
import 'package:pan_oceanic_sfe/Widgets/General%20Widgets/back_button%20Widget.dart';
import 'package:pan_oceanic_sfe/Widgets/Progess%20Widgets/goals_widgets.dart';
import 'package:provider/provider.dart';
import 'package:restart_app/restart_app.dart';

import '../../Customs/custom_alert.dart';
import '../../Customs/custom_snackbar.dart';
import '../../Providers/firestore_provider.dart';

class AdminGoalsPage extends StatefulWidget {
  const AdminGoalsPage({Key? key}) : super(key: key);

  @override
  State<AdminGoalsPage> createState() => _AdminGoalsPageState();
}

class _AdminGoalsPageState extends State<AdminGoalsPage> {
  late double height;
  late double width;
  late final dynamic firestoreProvider;
  late final Future getSFEGoalFuture;
  late final Future getInsuranceCompletedGoalFuture;
  late final Future getInsuranceNotCompletedGoalFuture;
  late final Future getNumberOfInvoicesGoalFuture;
  late final Future getNewClientsGoalFuture;
  late TextEditingController SFEGoalController;
  late TextEditingController InsuranceCompletedGoalController;
  late TextEditingController InsuranceNotCompletedGoalController;
  late TextEditingController NumberOfInvoicesGoalController;
  late TextEditingController NewClientsGoalController;
  final _formKey = GlobalKey<FormState>();

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
    SFEGoalController = TextEditingController();
    InsuranceCompletedGoalController = TextEditingController();
    InsuranceNotCompletedGoalController = TextEditingController();
    NumberOfInvoicesGoalController = TextEditingController();
    NewClientsGoalController = TextEditingController();

  }
  removeDialog(){
    Navigator.pop(context);
  }
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(left: width*0.01,right: width*0.01),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomBackButton(heading: 'GOALS',),
              Text('Please note the following:\n1. These goals are monthly goals\n2. Once you have set the goals the application will automatically update to reflect the changes so make sure everything is properly saved before changing any company goals.'),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                        child: GoalsPageCards(
                          description: 'Number of SFEs',
                          typeOfCard: 2,
                          goals: getSFEGoalFuture, control: SFEGoalController, summary: 'Set the number of SFEs goal to recruit monthly',
                        )),
                    SizedBox(
                      width: width * 0.01,
                    ),
                    Expanded(
                        child: GoalsPageCards(
                          description: 'Number of Invoices This Month',
                          goals: getNumberOfInvoicesGoalFuture, control: NumberOfInvoicesGoalController, summary: 'Set number of invoices the SFEs should do this month',
                        )),
                    SizedBox(
                      width: width * 0.01,
                    ),
                    Expanded(
                        child: GoalsPageCards(
                          description: 'Insurance Not Completed This Month',
                          goals: getInsuranceNotCompletedGoalFuture, control: InsuranceNotCompletedGoalController, summary: 'Set the maximum limit that insurance which has been given a quotation can be incomplete',
                        )),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                        child: GoalsPageCards(
                          description: 'New Clients This Month',
                          typeOfCard: 3,
                          goals: getNewClientsGoalFuture, control: NewClientsGoalController, summary: 'New clients brought in this month',
                        )),
                    SizedBox(
                      width: width * 0.01,
                    ),
                    Expanded(
                        flex: 2,
                        child: GoalsPageCards(
                          description: 'Insurance Completed this month',
                          typeOfCard: 5,
                          isBig: true,
                          goals: getInsuranceCompletedGoalFuture, control: InsuranceCompletedGoalController, summary: 'Total amount of insurance completed this month',
                        )),
                    SizedBox(
                      width: width * 0.01,
                    ),
                  ],
                ),
              ),
              Container(
                width: width,
                height: height*0.05,
                child: ElevatedButton(onPressed:() async {
                  if (_formKey.currentState!.validate()) {
                    ShowDialog.showErrorDialog(
                        context,
                        'Are you sure?',
                        'Are you sure you wish to update the company goals?\nThe Application will restart after you press \'Yes\'',
                        'images/lotties/goals.json',
                        'Cancel',
                        Colors.red,
                        'Yes',
                        Colors.green, () async {
                      try {
                        await firestoreProvider.updateGoals(SFEGoalController.text, NumberOfInvoicesGoalController.text, InsuranceNotCompletedGoalController.text,NewClientsGoalController.text, InsuranceCompletedGoalController.text);
                        removeDialog();
                        Restart.restartApp();
                      } catch (e) {
                        removeDialog();
                        ScaffoldMessenger.of(context).showSnackBar(
                            CustomSnack().customSnackBar(
                                'Could not update the company goals', Colors.red,
                                height, width));
                      }
                    },
                        height,
                        width);
                  }
                },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: MyConstants.homePageLeftMenuColor
                  ), child: Text('SET NEW GOALS',
                    style: TextStyle(color: Colors.white),),),
              ),
              SizedBox(height: 0.01*height,),
            ],
          ),
        ),
      ),
    );
  }
}
