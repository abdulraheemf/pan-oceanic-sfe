import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pan_oceanic_sfe/Services/Number%20Altering%20Functions.dart';
import 'package:pan_oceanic_sfe/Services/constants.dart';

class HomePageCards extends StatefulWidget {
  //Stream numberStream;
  String description;
  Future goals;
  int typeOfCard;
  bool isBig;
  HomePageCards({required this.description,this.typeOfCard = 1,this.isBig = false,required this.goals,});
  //type of card
  //1 is white
  //2 is blue / good
  //3 is red / bad
//required this.numberStream,
  @override
  State<HomePageCards> createState() => _HomePageCardsState();
}

class _HomePageCardsState extends State<HomePageCards> {
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
              return Center(child: Text('An Error Occured, Please Reload!',style: TextStyle(color: getTextColor()),textAlign: TextAlign.center,));
            }else{
              return Center(child: Text(NumberFunctions().addCommas(snapshot.data),style: TextStyle(color: getTextColor()),));
            }
          }
      ),
    );
  }
}
