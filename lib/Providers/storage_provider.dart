import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class StorageProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> getProfilePicture() async {
    final ref = FirebaseStorage.instance.ref().child('${_auth.currentUser!.uid}.jpg');
    var url = await ref.getDownloadURL();
    return url;
  }

  Future<String> getFrontPictureID() async {
    final ref = FirebaseStorage.instance.ref().child('${_auth.currentUser!.uid}-frontID.jpg');
    var url = await ref.getDownloadURL();
    return url;
  }

  Future<String> getBackPictureID() async {
    final ref = FirebaseStorage.instance.ref().child('${_auth.currentUser!.uid}-backID.jpg');
    var url = await ref.getDownloadURL();
    return url;
  }

}
