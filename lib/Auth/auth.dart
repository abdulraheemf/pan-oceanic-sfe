import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pan_oceanic_sfe/Customs/custom_snackbar.dart';
import 'package:pan_oceanic_sfe/Services/constants.dart';
import 'package:pan_oceanic_sfe/Widgets/TextField%20Widgets/auth_widgets.dart';
import 'package:provider/provider.dart';

import '../Admin/home_page.dart';
import '../Customs/custom_loader.dart';
import '../Providers/auth_provider.dart';

class Authentication extends StatefulWidget {
  const Authentication({Key? key}) : super(key: key);

  @override
  State<Authentication> createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  late double height;
  late double width;
  late final dynamic provider;
  late TextEditingController email;
  late TextEditingController password;
  @override
  void initState(){
    super.initState();
    provider = Provider.of<AuthProvider>(context, listen: false);
    email = TextEditingController();
    password = TextEditingController();
  }
  @override
  void dispose(){
    super.dispose();
    email.dispose();
    password.dispose();
  }
  void goToAdminHomePage(){
    Navigator.pop(context);
    Navigator.pushReplacement(context, PageRouteBuilder(pageBuilder: (context, animation, secondaryAnimation) {
      return FadeTransition(
        opacity: animation,
        child: const AdminHomePage(),
      );
    },
      transitionDuration: const Duration(milliseconds: 180),
    ),
    );
  }
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    if(width<=800){
      return Scaffold(
          backgroundColor: MyConstants.companyColor,
          body: Container(
            color: Colors.white,
            child: Padding(
              padding: EdgeInsets.only(left: width * 0.02),
              child: Column(
                children: [
                  SizedBox(height: height * 0.04,),
                  Align(alignment: Alignment.centerLeft,
                      child: Image.asset('images/logos/full logo.png',
                        height: height * 0.13,)),
                  SizedBox(height: height * 0.1,),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Sign In', style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold
                    ),),
                  ),
                  SizedBox(height: height * 0.05,),
                  CustomTextField(description: 'E-Mail', control: email,),
                  SizedBox(height: height * 0.05,),
                  CustomTextField(description: 'Password',
                    isObscure: true,
                    control: password,),
                  const Spacer(),
                  Padding(
                    padding: EdgeInsets.only(right: width * 0.02),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: GestureDetector(
                        onTap: () async {
                          LoaderDialog.showLoaderDialog(context);
                          try {
                            await Provider.of<AuthProvider>(
                                context, listen: false).firebaseLogin(
                                email.text.trim(), password.text);
                            goToAdminHomePage();
                          } catch (e) {
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                                CustomSnack().customSnackBar(
                                    'Could not log in!', Colors.red,
                                    height, width));
                          }
                        },
                        child: Container(
                          height: height * 0.07,
                          width: width * 0.15,
                          color: MyConstants.companyColor,
                          child: const Icon(Icons.arrow_forward_ios,
                            color: Colors.white,),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: height * 0.05,),
                ],
              ),
            ),
          )
      );
    }else {
      return Scaffold(
          backgroundColor: MyConstants.companyColor,
          body: Row(
            children: [
              Expanded(flex: 1,
                child: Container(
                  color: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.only(left: width * 0.02),
                    child: Column(
                      children: [
                        SizedBox(height: height * 0.04,),
                        Align(alignment: Alignment.centerLeft,
                            child: Image.asset('images/logos/full logo.png',
                              height: height * 0.13,)),
                        SizedBox(height: height * 0.1,),
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Sign In', style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold
                          ),),
                        ),
                        SizedBox(height: height * 0.05,),
                        CustomTextField(description: 'E-Mail', control: email,),
                        SizedBox(height: height * 0.05,),
                        CustomTextField(description: 'Password',
                          isObscure: true,
                          control: password,),
                        const Spacer(),
                        Padding(
                          padding: EdgeInsets.only(right: width * 0.02),
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: GestureDetector(
                              onTap: () async {
                                LoaderDialog.showLoaderDialog(context);
                                try {
                                  await Provider.of<AuthProvider>(
                                      context, listen: false).firebaseLogin(
                                      email.text.trim(), password.text);
                                  goToAdminHomePage();
                                } catch (e) {
                                  Navigator.pop(context);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      CustomSnack().customSnackBar(
                                          'Could not log in!', Colors.red,
                                          height, width));
                                }
                              },
                              child: Container(
                                height: height * 0.07,
                                width: width * 0.05,
                                color: MyConstants.companyColor,
                                child: const Icon(Icons.arrow_forward_ios,
                                  color: Colors.white,),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: height * 0.05,),
                      ],
                    ),
                  ),
                ),
              ),
              Lottie.asset('images/lotties/sales.json', height: height,
                  width: width * 0.7)
            ],
          )
      );
    }
  }
}
