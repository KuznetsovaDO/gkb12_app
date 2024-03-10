import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gkb12_app/controllers/patient_controller.dart';
import 'package:gkb12_app/models/patient_model.dart';
import 'package:gkb12_app/ui/pages/auth_page.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PatientProfile extends StatefulWidget {
  final String id;
  const PatientProfile({Key? key, required this.id}) : super(key: key);

  @override
  State<PatientProfile> createState() => _PatientProfileState();
}

class _PatientProfileState extends State<PatientProfile> {
  PatientController controller = PatientController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        actions: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Icon(Icons.arrow_back),
            OutlinedButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                    minimumSize: Size.fromWidth(30),
                    textStyle: Theme.of(context).textTheme.labelMedium,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    side: BorderSide(width: 2, color: Colors.black),
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text(
                    'Редактировать',
                  ),
                  Container(
                      margin: EdgeInsets.symmetric(horizontal: 8),
                      child: Icon(
                        Icons.edit,
                        size: MediaQuery.of(context).size.width * 0.10,
                      ))
                ])),
          ])
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10),
        child: FutureBuilder<PatientModel>(
          future: controller.getPatientData(widget.id),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Пациент: #${widget.id}",
                      style: Theme.of(context).textTheme.headlineLarge,
                      textAlign: TextAlign.left,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              TextFormField(
                                enabled: false,
                                decoration: InputDecoration(
                                  labelText: widget.id,
                                  labelStyle: GoogleFonts.ibmPlexSans(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: 0,
                                      color: Colors.black),
                                  border: UnderlineInputBorder(),
                                ),
                              ),
                              Text("Код доступа")
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              TextFormField(
                                enabled: false,
                                decoration: InputDecoration(
                                  labelText: widget.id,
                                  labelStyle: GoogleFonts.ibmPlexSans(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: 0,
                                      color: Colors.black),
                                  border: UnderlineInputBorder(),
                                ),
                              ),
                              Text("Код доступа")
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text(snapshot.error.toString()),
                );
              }
            } else {
              return const Center(child: CircularProgressIndicator());
            }
            return Container();
          },
        ),
      ),
    );
  }
}
