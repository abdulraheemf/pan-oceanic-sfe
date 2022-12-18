import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final usersCollection = FirebaseFirestore.instance.collection('users');
  final goalsCollection = FirebaseFirestore.instance.collection('goals');
  final currentInformationCollection = FirebaseFirestore.instance.collection('counters');
  final announcementCollection = FirebaseFirestore.instance.collection('announcements');
  String currentChosenNews = 'placeholder';

  void UpdateCurrentChosenNews(String input){
    currentChosenNews = input;
    notifyListeners();
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> getSpecificNewsStream(){
    Stream<DocumentSnapshot<Map<String, dynamic>>> stream = announcementCollection.doc(currentChosenNews).snapshots();
    return stream;
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> getCurrentUserStream(){
    Stream<DocumentSnapshot<Map<String, dynamic>>> stream = FirebaseFirestore.instance.collection('users').doc(_auth.currentUser!.uid).snapshots();
    return stream;
  }
  Stream<DocumentSnapshot<Map<String, dynamic>>> getCurrentNumberOfSFEStream(){
    Stream<DocumentSnapshot<Map<String, dynamic>>> stream = currentInformationCollection.doc('SFE').snapshots();
    return stream;
  }
  Stream<DocumentSnapshot<Map<String, dynamic>>> getCurrentNumberOfInvoicesStream(){
    Stream<DocumentSnapshot<Map<String, dynamic>>> stream = currentInformationCollection.doc('numberOfInvoices').snapshots();
    return stream;
  }
  Stream<DocumentSnapshot<Map<String, dynamic>>> getCurrentInsuranceNotCompletedStream(){
    Stream<DocumentSnapshot<Map<String, dynamic>>> stream = currentInformationCollection.doc('insuranceNotCompleted').snapshots();
    return stream;
  }
  Stream<DocumentSnapshot<Map<String, dynamic>>> getCurrentNumberOfNewClientsStream(){
    Stream<DocumentSnapshot<Map<String, dynamic>>> stream = currentInformationCollection.doc('newClients').snapshots();
    return stream;
  }
  Stream<DocumentSnapshot<Map<String, dynamic>>> getCurrentInsuranceCompletedStream(){
    Stream<DocumentSnapshot<Map<String, dynamic>>> stream = currentInformationCollection.doc('insuranceCompleted').snapshots();
    return stream;
  }
  Stream<QuerySnapshot> getLatestAnnouncementsStream(int limit){
    Stream<QuerySnapshot> stream = announcementCollection.where('isDeleted',isEqualTo: false).orderBy('timestamp',descending: true).limit(limit).snapshots();
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

  Future<bool> checkIfUserIsAdmin() async {
    Map<String, dynamic>? data;
    await usersCollection!
        .doc(_auth.currentUser!.uid)
        .get()
        .then((doc) => {data = doc.data()});
    return data!['isAdmin'];
  }

}