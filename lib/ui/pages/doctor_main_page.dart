import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gkb12_app/controllers/patient_controller.dart';
import 'package:gkb12_app/models/patient_model.dart';
import 'package:gkb12_app/ui/pages/auth_page.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
        body: SingleChildScrollView(
          child: Container(
              padding: const EdgeInsets.all(5),
              child: FutureBuilder<List<PatientModel>>(
                future: controller.getAllPatient(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (c, index) {
                          return Column(
                            children: [
                              ListTile(
                                iconColor: Colors.blue,
                                tileColor: Colors.blue.withOpacity(0.1),
                                leading:
                                    const Icon(Icons.account_circle_outlined),
                                title: Text(
                                    "Name: ${snapshot.data![index].accessCode}"),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              AuthPage(title: "title")));
                                },
                              ),
                            ],
                          );
                        },
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text(snapshot.error.toString()),
                      );
                    }
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                  // Добавляем возврат значения, если все условия не выполнены
                  return Container(); // Можно также вернуть другой виджет по умолчанию
                },
              )),
        ));
  }
}
