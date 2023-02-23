import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


// announcementCollection.get().then((value) => value.docs.forEach((element) {
// element.reference.update({'readBy':FieldValue.arrayUnion([currentUserID])});
// }));
// When creating a new user
class FirestoreProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final usersCollection = FirebaseFirestore.instance.collection('users');
  final goalsCollection = FirebaseFirestore.instance.collection('goals');
  final currentInformationCollection = FirebaseFirestore.instance.collection('counters');
  final announcementCollection = FirebaseFirestore.instance.collection('announcements');
  String searchValue = '';
  String currentUserFirstName = '';
  String currentUserLastName = '';
  String currentUserEmail = '';
  String currentUserTitle = '';
  String currentUserID = '';
  bool currentUserIsAdmin = false;
  bool currentUserAllProductsAllowed = false;
  List currentUserProducts = [];
  List currentUserQualifications = [];
  Map news = {
    'body':'',
    'title':'',
    'firstName':'',
    "lastName":'',
    "id":'',
    "date":'',
    "time":''
  };

  Future<void> fetchCurrentUserData() async {
    Map<String, dynamic>? data;
    await usersCollection!
        .doc(_auth.currentUser!.uid)
        .get()
        .then((doc) => {data = doc.data()});
    currentUserFirstName = data!['firstName'];
    currentUserLastName = data!['lastName'];
    currentUserEmail = data!['email'];
    currentUserTitle = data!['title'];
    currentUserID = data!['uid'];
    currentUserIsAdmin = data!['isAdmin'];
    currentUserAllProductsAllowed = data!['allProductsAllowed'];
    currentUserProducts = data!['products'];
    currentUserQualifications = data!['qualification'];
  }

  Future<void> MarkAsRead(String id)async {
    await announcementCollection.doc(id).update({
      'readBy':FieldValue.arrayUnion([currentUserID])
    });
  }

  void UpdateNews(String body, String title, String firstName, String lastName,String id,String date,String time,String authorTitle){
    news = {
      'body':body,
      'title':title,
      'firstName':firstName,
      "lastName":lastName,
      "id":id,
      "date":date,
      "time":time,
      "authorTitle":authorTitle
    };
    notifyListeners();
  }

  Future<void> deleteAnnouncement(String id) async {
    await announcementCollection.doc(id).update({
      'isDeleted':true
    });
    news = {
      'body':'',
      'title':'',
      'firstName':'',
      "lastName":'',
      "id":'',
      "date":'',
      "time":''
    };
    notifyListeners();
  }

  void UpdateNewsWithoutNotifying(String body, String title, String firstName, String lastName,String id,String date,String time,String authorTitle){
    news = {
      'body':body,
      'title':title,
      'firstName':firstName,
      "lastName":lastName,
      "id":id,
      "date":date,
      "time":time,
      "authorTitle":authorTitle
    };
  }

  Future<void> addAnnouncement(String title,String body) async {
    String currentDate = DateFormat.yMMMMd('en_US').format(DateTime.now());
    final announcementDocument = announcementCollection.doc();
    String currentTime = DateFormat.jm().format(DateTime.now());
    String searchTitle = title.toLowerCase();
    List<String> searchList = [];
    String temp = "";
    for(int i = 0;i<searchTitle.length;i++){
      temp = temp + searchTitle[i];
      searchList.add(temp);
    }
    try{
      await announcementDocument.set({
        'authorTitle':currentUserTitle,
        'body':body,
        'byFirstName':currentUserFirstName,
        'byID':currentUserID,
        'byLastName':currentUserLastName,
        'date':currentDate,
        'forSearch':searchList,
        'id':announcementDocument.id,
        'isDeleted':false,
        'time':currentTime,
        'timestamp':FieldValue.serverTimestamp(),
        'title':title,
        'readBy':[]
      });
    } catch(e){
      throw Exception();
    } finally{
      notifyListeners();
    }
  }

  void UpdateSearchValue(String input){
    searchValue = input;
    notifyListeners();
  }

  Stream<QuerySnapshot> getSearchNewsStream(String searchWord){
    Stream<QuerySnapshot> stream = announcementCollection.where('isDeleted',isEqualTo: false).where('forSearch', arrayContains: searchWord).snapshots();
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

  Future updateGoals(String SFEgoal, String invoicesGOAL, String insuranceNotCompleted,String newClients, String insuranceCompleted) async {
    await goalsCollection.doc('SFE').update({
      'numberOfSFEs':int.parse(SFEgoal)
    });
    await goalsCollection.doc('insuranceCompleted').update({
      'amount':int.parse(insuranceCompleted)
    });
    await goalsCollection.doc('insuranceNotCompleted').update({
      'amount':int.parse(insuranceNotCompleted)
    });
    await goalsCollection.doc('newClients').update({
      'number':int.parse(newClients)
    });
    await goalsCollection.doc('numberOfInvoices').update({
      'number':int.parse(invoicesGOAL)
    });
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