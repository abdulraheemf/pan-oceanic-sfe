import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pan_oceanic_sfe/Providers/firestore_provider.dart';
import 'package:provider/provider.dart';

class CustomDrawerAdmin extends StatefulWidget {
  const CustomDrawerAdmin({Key? key}) : super(key: key);

  @override
  State<CustomDrawerAdmin> createState() => _CustomDrawerAdminState();
}

class _CustomDrawerAdminState extends State<CustomDrawerAdmin> {
  late final provider;
  @override
  void initState(){
    super.initState();
    provider = Provider.of<FirestoreProvider>(context, listen: false);
  }
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      stream: provider.getCurrentUserStream(),
        builder: (_, snapshot) {
    if (snapshot.connectionState==ConnectionState.waiting) {
      return const Center(
        child: SpinKitCircle(
          color: Colors.black,
        ),
      );
    } else if(!snapshot.hasData){
      return Center(
        child: Text('An error occured!'),
      );
    } else {
      var output = snapshot.data!.data();
      String firstName = output!['firstName'];
      String secondName = output['lastName'];
      return Text(firstName);
    }
      }
    );
  }
}
