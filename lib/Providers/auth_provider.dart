import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future firebaseLogin(String email,String password) async {
    try{
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } catch(e){
      throw Exception();
    } finally{
      notifyListeners();
    }
  }

}