import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'Auth/auth.dart';
import 'Providers/auth_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(apiKey: "AIzaSyDafrO07pb7ZzmDq9z7gBPY6MKIRWNbebc", appId: "1:272123219077:web:981b2dc3f983009929adec", messagingSenderId: "272123219077", projectId: "panoceanic-sfe",authDomain: "panoceanic-sfe.firebaseapp.com",storageBucket: "panoceanic-sfe.appspot.com")
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(
          create: (_) => AuthProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: Color(0xFFE4E4E4),
          textTheme: GoogleFonts.latoTextTheme(),
        ),
        home: const Authentication(),
      ),
    );
  }
}