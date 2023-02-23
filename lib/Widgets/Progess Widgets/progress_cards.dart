import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pan_oceanic_sfe/Services/Number%20Altering%20Functions.dart';
import 'package:pan_oceanic_sfe/Services/constants.dart';

class ProgressPageCards extends StatefulWidget {
  Stream<DocumentSnapshot<Map<String, dynamic>>> stream;
  String description;
  Future goals;
  int typeOfCard;
  bool isBig;
  ProgressPageCards({required this.description,this.typeOfCard = 1,this.isBig = false,required this.goals,required this.stream,});
  //type of card
  //1 is white
  //2 is blue / good
  //3 is red / bad

  @override
  State<ProgressPageCards> createState() => _ProgressPageCardsState();
}

class _ProgressPageCardsState extends State<ProgressPageCards> {
  late double height;
  late double width;
  Color getColor(){
    if(widget.typeOfCard==1){
      return Colors.white;
    } else if(widget.typeOfCard==2){
      return MyConstants.mainHomePageCardColor;
    } else if(widget.isBig){
      return MyConstants.homePageLeftMenuColor;
    } else {
      return MyConstants.badHomePageCardColor;
    }
  }
  Color getTextColor(){
    if(widget.typeOfCard==1){
      return Colors.black;
    } else if(widget.typeOfCard==2){
      return Colors.white;
    } else if(widget.isBig){
      return Colors.white;
    } else {
      return Colors.black;
    }
  }
  String getPercentage(double goalValue, double currentValue) {
    return ((currentValue/goalValue) * 100).toStringAsFixed(1);
  }

  double getNumberForProgressBar(double goalValue,double currentValue){
    double ratio  = currentValue/goalValue;
    if(ratio>=1){
      return 1;
    } else {
      return ratio;
    }
  }
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
          color: getColor(),
          borderRadius: BorderRadius.circular(5)
      ),
      height: height*0.3,
      width: (widget.isBig)?width*0.234:width*0.12,
      child: FutureBuilder(
          future: widget.goals,
          builder: (context, AsyncSnapshot snapshot) {
            if(snapshot.connectionState == ConnectionState.waiting){
              return Center(child: SpinKitCircle(
                color: getTextColor(),
              ),);
            } else if(!snapshot.hasData){
              return Center(child: Text('An Error Occurred, Please Reload!',style: TextStyle(color: getTextColor()),textAlign: TextAlign.center,));
            }else{
              return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                  stream: widget.stream,
                  builder: (_, snapshotStream) {
                    if (snapshotStream.connectionState ==
                        ConnectionState.waiting) {
                      return Center(child: SpinKitCircle(
                        color: getTextColor(),
                      ),);
                    } else if (!snapshotStream.hasData) {
                      return Center(child: Text(
                        'An Error Occurred, Please Reload!',
                        style: TextStyle(color: getTextColor()),
                        textAlign: TextAlign.center,));
                    } else {
                      var outputStream = snapshotStream.data!.data();
                      double currentNumberValue = outputStream!['valueMonthly'];
                      String percentage = getPercentage(snapshot.data, currentNumberValue);
                      double barValue = getNumberForProgressBar(snapshot.data, currentNumberValue);
                      return Padding(
                        padding: EdgeInsets.only(
                            left: width * 0.005, right: width * 0.005),
                        child: Column(
                          children: [
                            SizedBox(height: height * 0.02,),
                            Align(alignment: Alignment.centerLeft,
                                child: Text(NumberFunctions().addCommas(currentNumberValue),
                                  style: TextStyle(
                                      color: getTextColor(), fontSize: 25),
                                  maxLines: 2,
                                  textAlign: TextAlign.left,
                                  overflow: TextOverflow.ellipsis,)),
                            Align(alignment: Alignment.centerLeft,
                                child: Text(widget.description,
                                  style: TextStyle(color: getTextColor()),
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left,)),
                            Align(alignment: Alignment.centerLeft,
                                child: Text('Goal: ${NumberFunctions().addCommas(snapshot.data)}',
                                  style: TextStyle(color: getTextColor()),
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left,)),
                            const Spacer(),
                            Align(alignment: Alignment.centerLeft,
                                child: Text('Progress: $percentage%', style: TextStyle(
                                    color: getTextColor(), fontSize: 13),
                                  maxLines: 1,
                                  textAlign: TextAlign.left,
                                  overflow: TextOverflow.ellipsis,)),
                            SizedBox(height: height * 0.005,),
                            LinearProgressIndicator(
                              value: barValue,
                              backgroundColor: MyConstants.homePageProgressBarBackgroundColor,
                              valueColor: const AlwaysStoppedAnimation<Color>(MyConstants.homePageProgressBarColor),
                              minHeight: height * 0.007,
                            ),
                            SizedBox(height: height * 0.02,),
                          ],
                        ),
                      );
                    }
                  }
              );
            }
          }
      ),
    );
  }
}