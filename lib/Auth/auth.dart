import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pan_oceanic_sfe/Widgets/TextField%20Widgets/auth_widgets.dart';
import 'package:provider/provider.dart';

class Authentication extends StatefulWidget {
  const Authentication({Key? key}) : super(key: key);

  @override
  State<Authentication> createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  late double height;
  late double width;
  @override
  void initState(){
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xff5CB3D3),
        body: Row(
          children: [
            Expanded(flex: 1,
              child: Container(
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.only(left: width*0.02),
                  child: Column(
                    children: [
                      SizedBox(height: height*0.04,),
                      Align(alignment:Alignment.centerLeft,child: Image.asset('images/logos/full logo.png',height: height*0.13,)),
                      SizedBox(height: height*0.1,),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Sign In',style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold
                        ),),
                      ),
                      SizedBox(height: height*0.05,),
                      CustomTextField(description: 'E-Mail'),
                      SizedBox(height: height*0.05,),
                      CustomTextField(description: 'Password',isObscure: true,),
                      Spacer(),
                      Padding(
                        padding: EdgeInsets.only(right: width*0.02),
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: Container(height: height*0.07,
                          width: width*0.05,
                          color: Color(0xff5CB3D3),
                          child: GestureDetector(
                            onTap: (){

                            },
                            child: Icon(Icons.arrow_forward_ios,color: Colors.white,),
                          ),),
                        ),
                      ),
                      SizedBox(height: height*0.05,),

                    ],

                  ),
                ),
              ),
            ),
            Lottie.asset('images/sales.json',height: height,width: width*0.7)
          ],
        )
    );
  }
}
