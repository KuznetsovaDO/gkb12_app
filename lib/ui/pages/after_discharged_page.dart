import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gkb12_app/ui/pages/patient_discharged_page.dart';
import 'package:gkb12_app/ui/widgets/patient_condition_widget.dart';
import 'package:gkb12_app/ui/widgets/custom_richtext_widget.dart';

class AfterDischargedPage extends StatefulWidget {
  @override
  _AfterDischargedPageState createState() => _AfterDischargedPageState();
  final String patientId;
  final bool isMorning;
  AfterDischargedPage({required this.patientId, this.isMorning = false});
}

class _AfterDischargedPageState extends State<AfterDischargedPage> {
  final formKey = GlobalKey<FormState>();
  int selectedButtonIndex = 0;
  @override
  Widget build(BuildContext context) {
    List<bool> _isSelected = [false, true];
    return Scaffold(
      appBar: AppBar(
        title: Text('Статус: 24 часа после операции'),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.notifications,
                size: 30,
              ))
        ],
      ),
      body: SingleChildScrollView(
          child: Container(
              margin: EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  ElevatedButton(
                      style: Theme.of(context).outlinedButtonTheme.style,
                      onPressed: () {},
                      child: Text("Ваша оценка качества медицинской помощи")),
                  Text("Пожалуйста, проидите форму обратной связи")
                ],
              ))),
    );
  }
}
