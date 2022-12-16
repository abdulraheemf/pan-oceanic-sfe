import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../Services/constants.dart';

class GetProfilePictureFutureBuilder extends StatefulWidget {
  Future<String> profilePictureFuture;
  GetProfilePictureFutureBuilder({super.key, required this.profilePictureFuture});

  @override
  State<GetProfilePictureFutureBuilder> createState() => _GetProfilePictureFutureBuilderState();
}

class _GetProfilePictureFutureBuilderState extends State<GetProfilePictureFutureBuilder> {
  late double height;
  late double width;
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return FutureBuilder(
        future: widget.profilePictureFuture,
        builder: (context, AsyncSnapshot<String> snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting){
            return CircleAvatar(
              backgroundColor: MyConstants.scaffoldBackgroundColor,
              radius: height*0.03,
              child: const SpinKitCircle(
                color: Colors.black,
                size: 30,
              ),
            );
          } else if(!snapshot.hasData){
            return CircleAvatar(
              backgroundColor: MyConstants.scaffoldBackgroundColor,
              radius: height*0.03,
              child: const Text('ERROR!',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 10),),
            );
          }else{
            return GestureDetector(
              onTap: (){

              },
              child: CircleAvatar(
                backgroundColor: MyConstants.scaffoldBackgroundColor,
                radius: height*0.03,
                child: ClipOval(
                  child: FadeInImage(
                    image: NetworkImage(snapshot.data!), placeholder: const AssetImage('images/logos/icon.png'),

                  ),
                ),
              ),
            );
          }
        }
    );
  }
}

class HelloMessageFutureBuilder extends StatefulWidget {
  Future<String> currentUserName;
  HelloMessageFutureBuilder({required this.currentUserName});

  @override
  State<HelloMessageFutureBuilder> createState() => _HelloMessageFutureBuilderState();
}

class _HelloMessageFutureBuilderState extends State<HelloMessageFutureBuilder> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: widget.currentUserName,
        builder: (context, AsyncSnapshot<String> snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Text('Hello!',style: helloMessageStyle,);
          } else if(!snapshot.hasData){
            return const Text('Hello!',style: helloMessageStyle,);
          }else{
            return Text('Hello ${snapshot.data}!',style: helloMessageStyle,);
          }
        }
    );
  }
}

const helloMessageStyle = TextStyle(
    fontSize: 25,
    fontWeight: FontWeight.bold
);