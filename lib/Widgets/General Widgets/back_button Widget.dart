import 'package:flutter/material.dart';
import 'package:pan_oceanic_sfe/Services/constants.dart';

class CustomBackButton extends StatefulWidget {
  String heading;
  CustomBackButton({required this.heading});

  @override
  State<CustomBackButton> createState() => _CustomBackButtonState();
}

class _CustomBackButtonState extends State<CustomBackButton> {
  late double height;

  late double width;

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: height*0.01,),
        GestureDetector(
          onTap: (){
            Navigator.pop(context);
            setState(() {

            });

          },
          child: Stack(
            children: [
              Row(
                children: [
                  Icon(Icons.arrow_back_ios_new),
                  Container(width: width*0.002,color: MyConstants.scaffoldBackgroundColor,height: height*0.03,),
                  Text('Go Back')
                ],
              ),
              Center(
                child: Text(widget.heading,style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              )
            ],
          ),
        ),
        SizedBox(height: height*0.02,),
      ],
    );
  }
}
