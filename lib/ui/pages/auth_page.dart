import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gkb12_app/controllers/patient_controller.dart';
import 'package:gkb12_app/ui/pages/auth_stuff_page.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gkb12_app/ui/pages/patient_before_operation_page.dart';
import 'package:gkb12_app/ui/widgets/custom_richtext_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

bool exist = false;
String codeValue = '';
CollectionReference patients =
    FirebaseFirestore.instance.collection('patients');

class AuthPage extends StatefulWidget {
  const AuthPage({super.key, required this.title});

  final String title;

  @override
  State<AuthPage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<AuthPage> {
  TextEditingController textEditingController = TextEditingController();
  // ..text = "123456";

  // ignore: close_sinks
  StreamController<ErrorAnimationType>? errorController;

  bool hasError = false;
  String currentText = "";
  final formKey = GlobalKey<FormState>();
  PatientController controller = PatientController();
  String debugMessage = "";
  bool isLoading = false;

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
    if (isLoading) CircularProgressIndicator();
    return Scaffold(
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              "assets/icons/logo.jpg",
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AuthStaffPage()));
              },
              child: Text(
                'Войти как сотрудник',
                style: GoogleFonts.ibmPlexSans(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0,
                    color: Colors.grey),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Center(
              child: Container(
            margin: const EdgeInsets.fromLTRB(15, 30, 15, 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Пожалуйста, введите код пациента',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                Container(
                    margin: const EdgeInsets.symmetric(vertical: 30),
                    child: Text(
                      'Код был ранее выдан Вам в регистратуре',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.ibmPlexSans(
                          fontSize: 18,
                          letterSpacing: 0,
                          fontWeight: FontWeight.w500),
                    )),
                Form(
                  key: formKey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8.0,
                      horizontal: 10,
                    ),
                    child: PinCodeTextField(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      appContext: context,
                      length: 4,
                      obscureText: false,
                      textStyle: GoogleFonts.ibmPlexSans(
                          fontSize: 30,
                          letterSpacing: 0,
                          fontWeight: FontWeight.w700),
                      animationType: AnimationType.fade,
                      validator: (v) {},
                      controller: textEditingController,
                      pinTheme: PinTheme(
                          shape: PinCodeFieldShape.box,
                          fieldHeight: MediaQuery.of(context).size.width / 5,
                          fieldWidth: MediaQuery.of(context).size.width / 5,
                          borderRadius: BorderRadius.circular(14),
                          activeFillColor: Colors.white,
                          inactiveColor: Colors.grey[400],
                          selectedColor: Colors.blueAccent[700],
                          activeColor: Colors.blueAccent[700]),
                      cursorColor: Colors.black,
                      animationDuration: const Duration(milliseconds: 300),
                      enableActiveFill: false,
                      keyboardType: TextInputType.text,
                      textCapitalization: TextCapitalization.characters,
                      boxShadows: const [
                        BoxShadow(
                          offset: Offset(0, 1),
                          color: Colors.black12,
                          blurRadius: 10,
                        )
                      ],
                      onChanged: (value) {
                        debugMessage = "";
                        setState(() {
                          codeValue = value;
                        });
                      },
                    ),
                  ),
                ),
                Text(
                  debugMessage,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Color.fromARGB(255, 178, 1, 1)),
                ),
                Container(
                    margin: EdgeInsets.symmetric(vertical: 20),
                    child: ElevatedButton(
                        onPressed: () async {
                          if (codeValue.length < 4) {
                            setState(() {
                              debugMessage =
                                  "Код должен содержать не менее 4 символов";
                            });
                          }
                          // Вызываем метод checkPatient напрямую из контроллера PatientController
                          else {
                            setState(() {
                              isLoading =
                                  true; // Устанавливаем состояние загрузки в true перед вызовом checkDocument
                            });
                            bool isPatientValid =
                                await controller.checkPatient(codeValue);
                            if (isPatientValid) {
                              // Если пациент существует, переходим на страницу PatientBeforeOperationPage
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      PatientBeforeOperationPage(
                                    patientId: codeValue,
                                  ),
                                ),
                              );
                            } else {
                              // Если пациент не существует, вы можете выполнить какие-то действия, например, показать сообщение об ошибке
                              setState(() {
                                debugMessage =
                                    "Пациент с таким кодом не найден";
                                isLoading = false;
                              });
                            }
                          }
                        },
                        style: Theme.of(context).outlinedButtonTheme.style,
                        child: Text(
                          'Войти',
                        ))),
                Text('Не получили код?',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium),
                Text('+7 999 200 10 10',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.ibmPlexSans(
                        fontSize: 17,
                        letterSpacing: 0,
                        fontWeight: FontWeight.w300)),
                SizedBox(
                  height: 20,
                ),
                OutlinedButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        side: BorderSide(width: 1.5, color: Colors.black),
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black),
                    child: Row(children: [
                      Text(
                        'Посмотреть адрес и контакты',
                        style: GoogleFonts.ibmPlexSans(
                            fontSize: 16,
                            letterSpacing: 0,
                            fontWeight: FontWeight.w500),
                      ),
                      const Icon(
                        Icons.arrow_forward,
                        size: 35,
                      )
                    ])),
                SizedBox(
                  height: 20,
                ),
                CustomRichTextContainer(
                    richText: RichText(
                  text: TextSpan(
                    text: 'Чек-лист - что стоит взять с собой в больницу\n\n',
                    style: GoogleFonts.ibmPlexSans(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0,
                      color: Colors.black,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: '1. Документы',
                        style: GoogleFonts.ibmPlexSans(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0,
                          color: Colors.grey[800],
                        ),
                      ),
                    ],
                  ),
                ))
              ],
            ),
          )),
        ));
  }

  Future<bool> checkDocument(String docID, BuildContext context) async {
    try {
      await FirebaseFirestore.instance
          .collection('patients')
          .where('access_code',
              isEqualTo:
                  docID) // Проверяем поле access_code на соответствие docID
          .get()
          .then((querySnapshot) {
        if (querySnapshot.docs.isNotEmpty) {
          // Документ с заданным access_code найден
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PatientBeforeOperationPage(
                patientId: querySnapshot.docs.first.id,
              ),
            ),
          );
        }
      });
      return exist;
    } catch (e) {
      // If any error
      return false;
    }
  }
}
