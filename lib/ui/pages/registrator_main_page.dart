import 'dart:async';
import 'package:flutter/material.dart';
import 'package:gkb12_app/controllers/patient_controller.dart';
import 'package:gkb12_app/models/patient_model.dart';
import 'package:gkb12_app/ui/pages/auth_page.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegistratorMainPage extends StatefulWidget {
  const RegistratorMainPage({super.key});

  @override
  State<RegistratorMainPage> createState() => _RegistratoreMainPageState();
}

class _RegistratoreMainPageState extends State<RegistratorMainPage> {
  TextEditingController textEditingController = TextEditingController();
  StreamController<ErrorAnimationType>? errorController;

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
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text('Выйти из профиля',
            textAlign: TextAlign.center,
            style: GoogleFonts.ibmPlexSans(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                letterSpacing: 0,
                color: Colors.grey)),
      ),
      body: Column(
        children: [
          Text(
            "Добрый День!",
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          Text(
            "Профиль: ",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          Expanded(
            child: FutureBuilder<List<PatientModel>>(
              future: controller.getAllPatient(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      physics: const AlwaysScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (c, index) {
                        return Card(
                          child: Padding(
                            padding: EdgeInsets.all(8),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.all(8),
                                      width:
                                          MediaQuery.of(context).size.width / 6,
                                      height:
                                          MediaQuery.of(context).size.width / 6,
                                      alignment: Alignment.center,
                                      padding: EdgeInsets.all(
                                          MediaQuery.of(context).size.width /
                                              120),
                                      child: Image.asset('assets/images/smile' +
                                          snapshot.data![index].lastCondition +
                                          '.png'),
                                      decoration: BoxDecoration(
                                        color: snapshot.data![index]
                                                    .lastCondition ==
                                                "1"
                                            ? Colors.green.shade300
                                            : snapshot.data![index]
                                                        .lastCondition ==
                                                    "2"
                                                ? Colors.green.shade200
                                                : snapshot.data![index]
                                                            .lastCondition ==
                                                        "3"
                                                    ? Colors.yellow.shade200
                                                    : snapshot.data![index]
                                                                .lastCondition ==
                                                            "4"
                                                        ? Colors.orange.shade300
                                                        : snapshot.data![index]
                                                                    .lastCondition ==
                                                                "5"
                                                            ? Colors
                                                                .red.shade300
                                                            : Colors.white,
                                        border: Border.all(
                                          width: 0.5,
                                          color: Colors.grey,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                    ),
                                    Column(
                                      children: [
                                        Text("#" +
                                            snapshot.data![index].id
                                                .toString()),
                                        Text(
                                          snapshot.data![index].med_profile,
                                          style: TextStyle(fontSize: 11),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Container(
                                        margin:
                                            EdgeInsets.symmetric(vertical: 15),
                                        height: 40,
                                        child: OutlinedButton(
                                          style: TextButton.styleFrom(
                                            elevation: 0,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            side: BorderSide(
                                              width: 1.5,
                                              color: Colors.black,
                                            ),
                                            backgroundColor: Colors.white,
                                            foregroundColor: Colors.black,
                                          ),
                                          onPressed: () {},
                                          child: Text("Перейти в чат"),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 8),
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            width: 1.5,
                                            color: Colors.grey,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                        ),
                                        height: 40,
                                        child: Text(
                                          "Статус",
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
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
                return Container();
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<bool?> showExitProfileDialog(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Хотите выйти из профиля?"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(
                    true); // Возвращает true, если пользователь выбрал "Да"
              },
              child: Text('Да'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(
                    false); // Возвращает false, если пользователь выбрал "Нет"
              },
              child: Text('Нет'),
            ),
          ],
        );
      },
    );
  }
}
