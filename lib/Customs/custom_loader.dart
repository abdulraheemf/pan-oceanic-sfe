import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoaderDialog{
  static Future<void> showLoaderDialog(BuildContext context) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context){
          return WillPopScope(
            onWillPop: () async => false,
            child: const Dialog(
              elevation: 0,
              backgroundColor: Colors.transparent,
              child: SpinKitCircle(color: Colors.black,),
            ),
          );
        }
    );
  }
}