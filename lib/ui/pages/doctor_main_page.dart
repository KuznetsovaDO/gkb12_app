import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gkb12_app/ui/pages/auth_stuff_page.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gkb12_app/ui/pages/patient_before_operation_page.dart';
import 'package:gkb12_app/ui/widgets/custom_richtext_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gkb12_app/ui/widgets/patient_list_item.dart';

bool exist = false;
String codeValue = '';
CollectionReference patients =
    FirebaseFirestore.instance.collection('patients');

class DoctorMainPage extends StatefulWidget {
  const DoctorMainPage({super.key});

  @override
  State<DoctorMainPage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<DoctorMainPage> {
  TextEditingController textEditingController = TextEditingController();
  // ..text = "123456";

  // ignore: close_sinks
  StreamController<ErrorAnimationType>? errorController;
  CollectionReference patients = FirebaseFirestore.instance.collection('Stuff');
  bool hasError = false;
  String currentText = "";
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  @override
  void dispose() {
    errorController!.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextButton(
          onPressed: () {},
          child: Text('Выйти из профиля',
              style: GoogleFonts.ibmPlexSans(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0,
                  color: Colors.grey)),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(20.0),
          child: Padding(
              padding: EdgeInsets.only(bottom: 5.0),
              child: Column(
                children: [
                  Text(
                    "Добрый День!",
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  Text(
                    "Профиль: ",
                    style: Theme.of(context).textTheme.bodyMedium,
                  )
                ],
              )),
        ),
      ),
      //   body:  StreamBuilder<QuerySnapshot>(
      //   stream: db.collection('notes').snapshots(),
      //   builder: (context, snapshot) {
      //     if (!snapshot.hasData) {
      //       return Center(
      //         child: CircularProgressIndicator(),
      //       );
      //     } else
      //       return ListView(
      //         children: snapshot.data.docs.map((doc) {
      //           return Card(
      //             child: ListTile(
      //               title: Text(doc.data()['title']),
      //             ),
      //           );
      //         }).toList(),
      //       );
      //   },
      // ),
    );
  }
}
