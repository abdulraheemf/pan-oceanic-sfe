import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:pan_oceanic_sfe/Services/constants.dart';


class ShowDialog{
  static Future<void> showErrorDialog(BuildContext context,String title,String body,String lottieImage,String left,Color leftColor,String right,Color rightColor,VoidCallback onpressedRight,double height,double width) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context){
          return Center(
            child: Container(
              decoration: BoxDecoration(
                  color: MyConstants.scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(5)
              ),
              height: height*0.6,
              width: width*0.4,
              child: Column(
                children: [
                  const Spacer(),
                  Lottie.asset(lottieImage,height: height*0.4),
                  const Spacer(),
                  Center(
                    child: Text(title,style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 15,
                        decoration: TextDecoration.none
                    ),
                      textAlign: TextAlign.center,),
                  ),
                  SizedBox(height: height*0.01,),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: Text(body,textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                          decoration: TextDecoration.none
                      ),),
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Expanded(child: GestureDetector(
                        onTap:(){
                          HapticFeedback.lightImpact();
                          Navigator.pop(context);
                        },
                        child: Container(
                          height: height*0.065,
                          decoration: BoxDecoration(
                              color: leftColor,
                              borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(5)
                              )
                          ),
                          child: Center(
                            child: Text(left,style: const TextStyle(
                                color: Colors.white,
                                decoration: TextDecoration.none
                            ),),
                          ),
                        ),
                      )),
                      Expanded(child: GestureDetector(
                        onTap: () async {
                          HapticFeedback.lightImpact();
                          onpressedRight();
                          //Get.to(()=>const LogIn(),transition: Transition.downToUp,duration: Duration(milliseconds: 200),curve: Curves.bounceInOut);
                        },
                        child: Container(
                          height: height*0.065,
                          decoration: BoxDecoration(
                              color: rightColor,
                              borderRadius: const BorderRadius.only(
                                  bottomRight: Radius.circular(5)
                              )
                          ),
                          child: Center(
                            child: Text(right,style: const TextStyle(
                                color: Colors.white,
                                decoration: TextDecoration.none
                            ),),
                          ),
                        ),
                      ))
                    ],
                  )

                ],

              ),

            ),
          );
        }
    );
  }
}