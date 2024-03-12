import 'package:flutter/material.dart';
import 'package:gkb12_app/ui/pages/patient_before_operation_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:gkb12_app/ui/pages/auth_page.dart';
import 'package:gkb12_app/ui/pages/registrator_main_page.dart';
import 'package:gkb12_app/ui/pages/doctor_main_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyBZg3dL1IdOoV-H2t1qMm41jWFl1a7frW8",
      projectId: "gkb12-13981",
      appId: '1:871841936359:android:541eb1820e65cf9f648342',
      messagingSenderId: '',
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? userId;
  String? status;

  @override
  void initState() {
    super.initState();
    checkUserId();
  }

  Future<void> checkUserId() async {
    final prefs = await SharedPreferences.getInstance();
    final storedUserId = prefs.getString('userId');
    if (storedUserId != null) {
      setState(() {
        userId = storedUserId;
      });
      // await getStatus(userId!);
    }
  }

  // Future<void> getStatus(String userId) async {
  //   final docSnapshot = await FirebaseFirestore.instance
  //       .collection('patients')
  //       .doc(userId)
  //       .get();
  //   setState(() {
  //     status = docSnapshot['status'];
  //   });
  // }

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
                  fontSize: 30, fontWeight: FontWeight.w700, letterSpacing: 0),
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
              headlineSmall: GoogleFonts.ibmPlexSans(
                  fontSize: 12, fontWeight: FontWeight.w500, letterSpacing: 0)),
          useMaterial3: true,
        ),
        home: userId == null
            ? AuthPage()
            : userId!.startsWith('D')
                ? DoctorMainPage(
                    doctorId: userId,
                  )
                : userId!.startsWith('R')
                    ? RegistratorMainPage()
                    : PatientBeforeOperationPage(accessCode: userId));
  }
}
