import 'package:flutter/material.dart';

class CustomSnack {
  SnackBar customSnackBar(String word,Color color,double height, double width){
    return SnackBar(content: Padding(
      padding: const EdgeInsets.fromLTRB(10,5,10,5),
      child: Material(
        borderRadius: BorderRadius.circular(5),
        elevation: 5,
        child: Container(
          height: height*0.1,
          width: width*0.8,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5)
          ),
          child: Row(
            children: [
              Container(
                width: 10,
                decoration: BoxDecoration(
                    color: color,
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(5),
                        topLeft: Radius.circular(5)
                    )
                ),
              ),
              const SizedBox(width: 10,),
              Image.asset('images/logos/icon.png',height: height*0.08,),
              const SizedBox(width: 10,),
              Expanded(child: Text(word,style: const TextStyle(
                  fontSize: 15
              ),))
            ],
          ),
        ),
      ),
    ),
      duration: const Duration(seconds: 2),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      elevation: 0,);
  }
}