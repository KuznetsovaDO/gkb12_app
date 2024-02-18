import 'package:flutter/material.dart';
import 'package:gkb12_app/ui/pages/auth_stuff_page.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:google_fonts/google_fonts.dart';

class PatientBeforeOperationPage extends StatefulWidget {
  const PatientBeforeOperationPage({super.key, required this.title});

  final String title;

  @override
  State<PatientBeforeOperationPage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<PatientBeforeOperationPage> {
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Статус: перед операцией'),
          leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
                  })),
          actions: [
            Image.asset(
              "assets/icons/logo.jpg",
            ),

            //more widgets to place here
          ],
        ),
        body: Center(
            child: Container(
                margin: EdgeInsets.fromLTRB(15, 30, 15, 20), child: Column())));
  }
}
