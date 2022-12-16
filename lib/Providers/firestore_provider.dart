import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final usersCollection = FirebaseFirestore.instance.collection('users');
  final goalsCollection = FirebaseFirestore.instance.collection('goals');

  Stream<DocumentSnapshot<Map<String, dynamic>>> getCurrentUserStream(){
    Stream<DocumentSnapshot<Map<String, dynamic>>> stream = FirebaseFirestore.instance.collection('users').doc(_auth.currentUser!.uid).snapshots();
    return stream;
  }


  Future<String> getCurrentUserName() async {
    Map<String, dynamic>? data;
    await usersCollection!
        .doc(_auth.currentUser!.uid)
        .get()
        .then((doc) => {data = doc.data()});
    return data!['firstName'];
  }

  Future getCurrentSFEGoal() async {
    Map<String, dynamic>? data;
    await goalsCollection!
        .doc('SFE')
        .get()
        .then((doc) => {data = doc.data()});
    return data!['numberOfSFEs'];
  }

  Future getInsuranceCompletedGoal() async {
    Map<String, dynamic>? data;
    await goalsCollection!
        .doc('insuranceCompleted')
        .get()
        .then((doc) => {data = doc.data()});
    return data!['amount'];
  }

  Future getInsuranceNotCompletedGoal() async {
    Map<String, dynamic>? data;
    await goalsCollection!
        .doc('insuranceNotCompleted')
        .get()
        .then((doc) => {data = doc.data()});
    return data!['amount'];
  }

  Future getNumberOfInvoices() async {
    Map<String, dynamic>? data;
    await goalsCollection!
        .doc('numberOfInvoices')
        .get()
        .then((doc) => {data = doc.data()});
    return data!['number'];
  }

  Future getNewClientsGoals() async {
    Map<String, dynamic>? data;
    await goalsCollection!
        .doc('newClients')
        .get()
        .then((doc) => {data = doc.data()});
    return data!['number'];
  }

}