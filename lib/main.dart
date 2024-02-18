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
        textTheme: GoogleFonts.ibmPlexSansCondensedTextTheme(),
        useMaterial3: true,
      ),
      home: const AuthPage(title: 'Flutter Demo Home Page'),
    );
  }
}
