import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gkb12_app/controllers/patient_controller.dart';
import 'package:gkb12_app/models/patient_model.dart';
import 'package:gkb12_app/ui/pages/auth_page.dart';
import 'package:gkb12_app/ui/pages/new_patient_page.dart';
import 'package:gkb12_app/ui/pages/patient_page.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

bool exist = false;
String codeValue = '';
CollectionReference patients =
    FirebaseFirestore.instance.collection('patients');

class RegistratorMainPage extends StatefulWidget {
  const RegistratorMainPage({super.key});

  @override
  State<RegistratorMainPage> createState() => _RegistratoreMainPageState();
}

class _RegistratoreMainPageState extends State<RegistratorMainPage> {
  TextEditingController textEditingController = TextEditingController();
  // ..text = "123456";

  // ignore: close_sinks
  StreamController<ErrorAnimationType>? errorController;
  CollectionReference patients =
      FirebaseFirestore.instance.collection('patients');
  bool hasError = false;
  String currentText = "";
  final formKey = GlobalKey<FormState>();
  PatientController controller = PatientController();

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
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          'Выйти из профиля',
          textAlign: TextAlign.center,
          style: GoogleFonts.ibmPlexSans(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              letterSpacing: 0,
              color: Colors.grey),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Добрый день!",
                        textAlign: TextAlign.left,
                        style: GoogleFonts.ibmPlexSans(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0),
                      ),
                      Text(
                        "Профиль: регистрация",
                        textAlign: TextAlign.left,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                  Icon(Icons.notifications)
                ],
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 20),
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => NewPatientPage()));
                  },
                  child: Row(
                    children: [
                      Text(
                        "Добавить пациента",
                        style: GoogleFonts.ibmPlexSans(
                            fontSize: 18,
                            letterSpacing: 0,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                      Icon(Icons.add)
                    ],
                    mainAxisAlignment: MainAxisAlignment.center,
                  ),
                ),
              ),
              FutureBuilder<List<PatientModel>>(
                future: controller.getPatientsBeforeDischarged(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      return Column(children: [
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Количество активных пациентов: ${snapshot.data!.length}",
                              style: GoogleFonts.ibmPlexSans(
                                  fontSize: 16,
                                  letterSpacing: 0,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.black),
                            )),
                        ListView.builder(
                          padding: EdgeInsets.symmetric(vertical: 15),
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (c, index) {
                            return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => PatientProfile(
                                                id: snapshot.data![index].id
                                                    .toString(),
                                              )));
                                },
                                child: Card(
                                  margin: EdgeInsets.symmetric(vertical: 7),
                                  elevation: 10,
                                  surfaceTintColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    side: BorderSide(
                                      width: 1,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              margin: EdgeInsets.all(8),
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  6,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  6,
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.all(
                                                  MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      30),
                                              child: Image.asset(
                                                  'assets/images/smile' +
                                                      snapshot.data![index]
                                                          .lastCondition +
                                                      '.png'),
                                              decoration: BoxDecoration(
                                                color: snapshot.data![index]
                                                            .lastCondition ==
                                                        "1"
                                                    ? Colors.green.shade200
                                                    : snapshot.data![index]
                                                                .lastCondition ==
                                                            "2"
                                                        ? Colors.green.shade100
                                                        : snapshot.data![index]
                                                                    .lastCondition ==
                                                                "3"
                                                            ? Colors
                                                                .yellow.shade200
                                                            : snapshot
                                                                        .data![
                                                                            index]
                                                                        .lastCondition ==
                                                                    "4"
                                                                ? Colors.orange
                                                                    .shade300
                                                                : snapshot
                                                                            .data![
                                                                                index]
                                                                            .lastCondition ==
                                                                        "5"
                                                                    ? Colors.red
                                                                        .shade300
                                                                    : Colors
                                                                        .white,
                                                border: Border.all(
                                                  width: 0.5,
                                                  color: Colors.grey,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                              ),
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "#" +
                                                      snapshot.data![index].id
                                                          .toString(),
                                                  style:
                                                      GoogleFonts.ibmPlexSans(
                                                          fontSize: 14,
                                                          letterSpacing: 0,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: Colors.black),
                                                ),
                                                Text(
                                                  snapshot
                                                      .data![index].med_profile,
                                                  style:
                                                      TextStyle(fontSize: 11),
                                                ),
                                                Text(
                                                  "Статус:  ${snapshot.data![index].status}",
                                                  style:
                                                      TextStyle(fontSize: 11),
                                                ),
                                              ],
                                            ),
                                            Expanded(
                                                child: Container(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    child: Icon(
                                                      Icons
                                                          .arrow_circle_right_outlined,
                                                    )))
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              flex: 2,
                                              child: Container(
                                                margin: EdgeInsets.symmetric(
                                                    vertical: 15),
                                                height: 40,
                                                child: OutlinedButton(
                                                    style: TextButton.styleFrom(
                                                      elevation: 0,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                      side: BorderSide(
                                                        width: 1.5,
                                                        color: Colors.black,
                                                      ),
                                                      backgroundColor:
                                                          Colors.white,
                                                      foregroundColor:
                                                          Colors.black,
                                                    ),
                                                    onPressed: () {},
                                                    child: Text(
                                                      "Перейти в чат",
                                                      style: GoogleFonts
                                                          .ibmPlexSans(
                                                              fontSize: 14,
                                                              letterSpacing: 0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              color:
                                                                  Colors.black),
                                                    )),
                                              ),
                                            ),
                                            SizedBox(width: 8),
                                            Expanded(
                                              flex: 1,
                                              child: Container(
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    width: 1.5,
                                                    color: Colors.grey,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                height: 40,
                                                child: Text(
                                                  snapshot.data![index].status,
                                                  textAlign: TextAlign.center,
                                                  style:
                                                      GoogleFonts.ibmPlexSans(
                                                          fontSize: 13,
                                                          letterSpacing: 0,
                                                          height: 1,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: Colors.black),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ));
                          },
                        )
                      ]);
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
              Divider(
                color: Colors.red,
                thickness: 2,
                height: 20,
                indent: 20,
                endIndent: 20,
              ),
              FutureBuilder<List<PatientModel>>(
                future: controller.getPatientsAfterDischarged(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      return Column(children: [
                        ListView.builder(
                          padding: EdgeInsets.symmetric(vertical: 15),
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (c, index) {
                            return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => PatientProfile(
                                                id: '',
                                              )));
                                },
                                child: Card(
                                  margin: EdgeInsets.symmetric(vertical: 7),
                                  elevation: 10,
                                  surfaceTintColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    side: BorderSide(
                                      width: 1,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              margin: EdgeInsets.all(8),
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  6,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  6,
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.all(
                                                  MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      30),
                                              child: Image.asset(
                                                  'assets/images/smile' +
                                                      snapshot.data![index]
                                                          .lastCondition +
                                                      '.png'),
                                              decoration: BoxDecoration(
                                                color: snapshot.data![index]
                                                            .lastCondition ==
                                                        "1"
                                                    ? Colors.green.shade200
                                                    : snapshot.data![index]
                                                                .lastCondition ==
                                                            "2"
                                                        ? Colors.green.shade100
                                                        : snapshot.data![index]
                                                                    .lastCondition ==
                                                                "3"
                                                            ? Colors
                                                                .yellow.shade200
                                                            : snapshot
                                                                        .data![
                                                                            index]
                                                                        .lastCondition ==
                                                                    "4"
                                                                ? Colors.orange
                                                                    .shade300
                                                                : snapshot
                                                                            .data![
                                                                                index]
                                                                            .lastCondition ==
                                                                        "5"
                                                                    ? Colors.red
                                                                        .shade300
                                                                    : Colors
                                                                        .white,
                                                border: Border.all(
                                                  width: 0.5,
                                                  color: Colors.grey,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                              ),
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "#" +
                                                      snapshot.data![index].id
                                                          .toString(),
                                                  style:
                                                      GoogleFonts.ibmPlexSans(
                                                          fontSize: 14,
                                                          letterSpacing: 0,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: Colors.black),
                                                ),
                                                Text(
                                                  snapshot
                                                      .data![index].med_profile,
                                                  style:
                                                      TextStyle(fontSize: 11),
                                                ),
                                                Text(
                                                  snapshot
                                                      .data![index].diagnosis,
                                                  style:
                                                      TextStyle(fontSize: 11),
                                                ),
                                              ],
                                            ),
                                            Expanded(
                                                child: Container(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    child: Icon(
                                                      Icons
                                                          .arrow_circle_right_outlined,
                                                    )))
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              flex: 2,
                                              child: Container(
                                                margin: EdgeInsets.symmetric(
                                                    vertical: 15),
                                                height: 40,
                                                child: OutlinedButton(
                                                    style: TextButton.styleFrom(
                                                      elevation: 0,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                      side: BorderSide(
                                                        width: 1.5,
                                                        color: Colors.black,
                                                      ),
                                                      backgroundColor:
                                                          Colors.white,
                                                      foregroundColor:
                                                          Colors.black,
                                                    ),
                                                    onPressed: () {},
                                                    child: Text(
                                                      "Перейти в чат",
                                                      style: GoogleFonts
                                                          .ibmPlexSans(
                                                              fontSize: 14,
                                                              letterSpacing: 0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              color:
                                                                  Colors.black),
                                                    )),
                                              ),
                                            ),
                                            SizedBox(width: 8),
                                            Expanded(
                                              flex: 1,
                                              child: Container(
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    width: 1.5,
                                                    color: Colors.grey,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                height: 40,
                                                child: Text(
                                                  snapshot.data![index].status,
                                                  textAlign: TextAlign.center,
                                                  style:
                                                      GoogleFonts.ibmPlexSans(
                                                          fontSize: 13,
                                                          letterSpacing: 0,
                                                          height: 1,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: Colors.black),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ));
                          },
                        )
                      ]);
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
            ],
          ),
        ),
      ),
    );
  }
}
