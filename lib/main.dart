import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pan_oceanic_sfe/Admin/Announcements/new_announcements_page.dart';
import 'package:pan_oceanic_sfe/Admin/announcements_page.dart';
import 'package:pan_oceanic_sfe/Admin/progress_page.dart';
import 'package:pan_oceanic_sfe/Providers/firestore_provider.dart';
import 'package:pan_oceanic_sfe/Services/constants.dart';
import 'package:provider/provider.dart';
import 'Admin/home_page.dart';
import 'Auth/auth.dart';
import 'Providers/auth_provider.dart';
import 'Providers/storage_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(apiKey: "AIzaSyDafrO07pb7ZzmDq9z7gBPY6MKIRWNbebc", appId: "1:272123219077:web:981b2dc3f983009929adec", messagingSenderId: "272123219077", projectId: "panoceanic-sfe",authDomain: "panoceanic-sfe.firebaseapp.com",storageBucket: "panoceanic-sfe.appspot.com")
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(
          create: (_) => AuthProvider(),
        ),
        ChangeNotifierProvider<FirestoreProvider>(
          create: (_) => FirestoreProvider(),
        ),
        ChangeNotifierProvider<StorageProvider>(
          create: (_) => StorageProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Pan Oceanic SFE',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: MyConstants.scaffoldBackgroundColor,
          textTheme: GoogleFonts.latoTextTheme(),
          appBarTheme: const AppBarTheme(
            centerTitle: true,
            backgroundColor: MyConstants.scaffoldBackgroundColor,
            elevation: 0,
            iconTheme: IconThemeData(color: Colors.black),
          ),
        ),
       home: (FirebaseAuth.instance.currentUser==null)?Authentication():AdminHomePage(),
       //home: AdminProgressPage(),
      ),
    );
  }
}