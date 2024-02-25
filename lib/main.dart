import 'package:flutter/material.dart';
import 'package:gkb12_app/ui/pages/auth_page.dart';
import 'package:google_fonts/google_fonts.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        outlinedButtonTheme: OutlinedButtonThemeData(
            style: OutlinedButton.styleFrom(
                shadowColor: Colors.grey.shade600,
                elevation: 10,
                backgroundColor: Color.fromARGB(255, 0, 60, 210),
                foregroundColor: Colors.white,
                textStyle: GoogleFonts.ibmPlexSans(
                    fontSize: 20,
                    letterSpacing: 0,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
                minimumSize: const Size.fromHeight(60),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)))),
        primaryColor: const Color(0x9C0042EB),
        textTheme: TextTheme(
          titleLarge: GoogleFonts.ibmPlexSans(
              fontSize: 20,
              letterSpacing: 0,
              fontWeight: FontWeight.w500,
              color: Colors.white),
          headlineLarge: GoogleFonts.ibmPlexSans(
              fontSize: 35, fontWeight: FontWeight.w700, letterSpacing: 0),
          labelMedium: GoogleFonts.ibmPlexSans(
              fontSize: 20, letterSpacing: 0, fontWeight: FontWeight.w500),
          bodyMedium: GoogleFonts.ibmPlexSans(
              fontSize: 18,
              letterSpacing: 0,
              fontWeight: FontWeight.w500,
              color: Colors.grey[800]),
          bodySmall: GoogleFonts.ibmPlexSans(
              fontSize: 16,
              letterSpacing: 0,
              height: 1,
              fontWeight: FontWeight.w400,
              color: Colors.grey[600]),
        ),
        useMaterial3: true,
      ),
      home: const AuthPage(title: 'Flutter Demo Home Page'),
    );
  }
}



// Usage:

