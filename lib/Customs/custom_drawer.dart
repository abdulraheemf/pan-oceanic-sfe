import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pan_oceanic_sfe/Auth/auth.dart';
import 'package:pan_oceanic_sfe/Customs/custom_alert.dart';
import 'package:pan_oceanic_sfe/Providers/auth_provider.dart';
import 'package:pan_oceanic_sfe/Providers/firestore_provider.dart';
import 'package:pan_oceanic_sfe/Providers/storage_provider.dart';
import 'package:provider/provider.dart';

class CustomDrawerAdmin extends StatefulWidget {
  double height;
  double width;
  CustomDrawerAdmin({required this.height,required this.width});

  @override
  State<CustomDrawerAdmin> createState() => _CustomDrawerAdminState();
}

class _CustomDrawerAdminState extends State<CustomDrawerAdmin> {
  late final firestoreProvider;
  late final storageProvider;
  late final authProvider;
  @override
  void initState(){
    super.initState();
    firestoreProvider = Provider.of<FirestoreProvider>(context, listen: false);
    storageProvider = Provider.of<StorageProvider>(context, listen: false);
    authProvider = Provider.of<AuthProvider>(context, listen: false);
    
  }
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      stream: firestoreProvider.getCurrentUserStream(),
        builder: (_, snapshot) {
    if (snapshot.connectionState==ConnectionState.waiting) {
      return const Center(
        child: SpinKitCircle(
          color: Colors.black,
        ),
      );
    } else if(!snapshot.hasData){
      return const Center(
        child: Text('An error occured!'),
      );
    } else {
      var output = snapshot.data!.data();
      String firstName = output!['firstName'];
      String lastName = output['lastName'];
      return Column(
        children: [
          SizedBox(height: widget.height*0.05),
          FutureBuilder(
            future: storageProvider.getProfilePicture(),
            builder: (context, AsyncSnapshot<String> snapshot) {
              if(snapshot.connectionState == ConnectionState.waiting){
                return CircleAvatar(
                  backgroundColor: const Color(0xFFe4e4e4),
                  radius: widget.height*0.12,
                  child: const SpinKitCircle(
                    color: Colors.black,
                  ),
                );
              } else if(!snapshot.hasData){
                print(snapshot.data);
                return CircleAvatar(
                  backgroundColor: const Color(0xFFe4e4e4),
                  radius: widget.height*0.12,
                  child: const Text('ERROR!',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 30),),
                );
              }else{
                return CircleAvatar(
                  backgroundColor: const Color(0xFFe4e4e4),
                  radius: widget.height*0.12,
                  child: ClipOval(
                    child: FadeInImage(
                      image: NetworkImage(snapshot.data!), placeholder: const AssetImage('images/logos/icon.png'),

                    ),
                  ),
                );
              }
            }
          ),
          SizedBox(height: widget.height*0.03),
          Text('Hello $firstName $lastName',style: const TextStyle(fontSize: 17),),
          SizedBox(height: widget.height*0.01),
          GestureDetector(child: MenuDrawer(height: widget.height,name: 'MY ACCOUNT',icon: Icons.account_circle_rounded,)),
          SizedBox(height: widget.height*0.01),
          GestureDetector(child: MenuDrawer(height: widget.height,name: 'CREATE NEW ACCOUNT',icon: Icons.add_box_rounded,)),
          SizedBox(height: widget.height*0.01),
          GestureDetector(child: MenuDrawer(height: widget.height,name: 'MANAGE ACCOUNTS',icon: Icons.manage_accounts,)),
          SizedBox(height: widget.height*0.01),
          GestureDetector(child: MenuDrawer(height: widget.height,name: 'SETTINGS',icon: Icons.settings,)),
          SizedBox(height: widget.height*0.01),
          GestureDetector(onTap:(){
            ShowDialog.showErrorDialog(context, 'ARE YOU SURE?', 'Are you sure you wish to log out?', 'images/lotties/log-out.json', 'CANCEL', Colors.red, 'CONFIRM', Colors.green, () {
              authProvider.signOut();
            Navigator.pushReplacement(context, PageRouteBuilder(pageBuilder: (context, animation, secondaryAnimation) {
              return FadeTransition(
                opacity: animation,
                child: const Authentication(),
              );
            },
              transitionDuration: const Duration(milliseconds: 180),
            ),
            );
              }, widget.height, widget.width);
          },child: MenuDrawer(height: widget.height,name: 'SIGN OUT',icon: Icons.logout,)),
          
        ],
      );
    }
      }
    );
  }
}

class MenuDrawer extends StatelessWidget {
  double height;
  String name;
  IconData icon;
  MenuDrawer({required this.height,required this.name,required this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 7,right: 7),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFe4e4e4),
          borderRadius: BorderRadius.circular(5)
        ),
        height: height*0.06,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 5,right: 5),
              child: Icon(icon),
            ),
            Expanded(child: Text(name))
          ],
        ),
      ),
    );
  }
}
