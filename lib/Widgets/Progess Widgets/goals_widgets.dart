import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pan_oceanic_sfe/Services/Number%20Altering%20Functions.dart';
import 'package:pan_oceanic_sfe/Services/constants.dart';

class GoalsPageCards extends StatefulWidget {
  String description;
  String summary;
  Future goals;
  int typeOfCard;
  bool isBig;
  TextEditingController control;
  GoalsPageCards({required this.description,this.typeOfCard = 1,this.isBig = false,required this.goals,required this.control, required this.summary});
  //type of card
  //1 is white
  //2 is blue / good
  //3 is red / bad

  @override
  State<GoalsPageCards> createState() => _GoalsPageCardsState();
}

class _GoalsPageCardsState extends State<GoalsPageCards> {
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
              widget.control.text = snapshot.data.toString();
              return Padding(
                padding: EdgeInsets.only(
                    left: width * 0.005, right: width * 0.005),
                child: Column(
                  children: [
                    Spacer(),

                    Align(alignment: Alignment.center,
                        child: Text(widget.description,
                          style: TextStyle(color: getTextColor(),fontSize : 20,),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,)),
                    SizedBox(height: height * 0.02,),
                    Align(alignment: Alignment.center,
                        child: Text(widget.summary,
                          style: TextStyle(color: getTextColor()),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,)),
                    SizedBox(height: height * 0.02,),
                    Align(alignment: Alignment.center,
                        child: TextFormField(
                          controller: widget.control,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Don\'t forget to fill this!';
                            }
                            final n = num.tryParse(value);
                            if (n == null) {
                              return 'This value should be a number';
                            }
                            return null;
                          },
                          cursorColor: getTextColor(),
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: getTextColor()
                              ),

                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: getTextColor()
                              ),
                            ),
                            errorBorder:OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.red
                              ),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.red
                              ),
                            ),

                          ),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: getTextColor(),
                            fontSize: 30
                          ),

                        )),
                    Spacer()

                  ],
                ),
              );
            }
          }
      ),
    );
  }
}