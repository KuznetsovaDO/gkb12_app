import 'package:flutter/material.dart';
import 'package:gkb12_app/ui/pages/auth_page.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
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
                shadowColor: Colors.grey.shade400,
                elevation: 15,
                backgroundColor: Color.fromARGB(255, 0, 60, 210),
                foregroundColor: Colors.white,
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
                fontSize: 20,
                letterSpacing: 0,
                fontWeight: FontWeight.w500,
                color: Colors.white),
            bodyMedium: GoogleFonts.ibmPlexSans(
                fontSize: 18, letterSpacing: 0, fontWeight: FontWeight.w600)),
        useMaterial3: true,
      ),
      home: const AuthPage(title: 'Flutter Demo Home Page'),
    );
  }
}



// Usage:

