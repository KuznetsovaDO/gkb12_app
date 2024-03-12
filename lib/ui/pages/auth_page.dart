import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gkb12_app/controllers/patient_controller.dart';
import 'package:gkb12_app/ui/pages/auth_stuff_page.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gkb12_app/ui/pages/patient_before_operation_page.dart';
import 'package:gkb12_app/ui/widgets/custom_richtext_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<AuthPage> {
  TextEditingController textEditingController = TextEditingController();
  StreamController<ErrorAnimationType>? errorController;
  bool medicalCardChecked = false;
  bool passportChecked = false;

  final formKey = GlobalKey<FormState>();
  PatientController controller = PatientController();
  String debugMessage = "";
  bool isLoading = false;

  late SharedPreferences _prefs;

  @override
  void initState() {
    super.initState();
    _initPreferences();
  }

  Future<void> _initPreferences() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      medicalCardChecked = _prefs.getBool('medicalCardChecked') ?? false;
      passportChecked = _prefs.getBool('passportChecked') ?? false;
    });
  }

  Future<void> _savePreferences() async {
    await _prefs.setBool('medicalCardChecked', medicalCardChecked);
    await _prefs.setBool('passportChecked', passportChecked);
  }

  Future<void> _saveUserState(String userId) async {
    await _prefs.setString('userId', userId);
  }

  Future<String?> _getUserState() async {
    return _prefs.getString('userId');
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
                  style: GoogleFonts.ibmPlexSans(
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0),
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
                  ),
                ),
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
                      } else {
                        setState(() {
                          isLoading = true;
                        });
                        bool isPatientValid =
                            await controller.checkPatient(codeValue);
                        if (isPatientValid) {
                          getUserId(codeValue, context);
                        } else {
                          setState(() {
                            debugMessage = "Пациент с таким кодом не найден";
                            isLoading = false;
                          });
                        }
                      }
                    },
                    style: Theme.of(context).outlinedButtonTheme.style,
                    child: Text('Войти'),
                  ),
                ),
                Text(
                  'Не получили код?',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Text(
                  '+7 999 200 10 10',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.ibmPlexSans(
                      fontSize: 17,
                      letterSpacing: 0,
                      fontWeight: FontWeight.w300),
                ),
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
                    foregroundColor: Colors.black,
                  ),
                  child: Row(
                    children: [
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
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(),
                  padding: const EdgeInsets.all(18.0),
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1.5,
                      color: Colors.grey,
                    ),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Чек-лист - что стоит взять с собой в больницу",
                        style: GoogleFonts.ibmPlexSans(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "1. Документы",
                        style: GoogleFonts.ibmPlexSans(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0,
                          color: Colors.grey[800],
                        ),
                      ),
                      CheckboxListTile(
                        title: Text('Паспорт'),
                        value: passportChecked,
                        onChanged: (bool? value) {
                          setState(() {
                            passportChecked = value!;
                            _savePreferences();
                          });
                        },
                      ),
                      CheckboxListTile(
                        title: Text('Медицинская карта'),
                        value: medicalCardChecked,
                        onChanged: (bool? value) {
                          setState(() {
                            medicalCardChecked = value!;
                            _savePreferences();
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> getUserId(String accessCode, BuildContext context) async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore
        .instance
        .collection('patients')
        .where("access_code", isEqualTo: accessCode)
        .get();

    String documentId = querySnapshot.docs.first.id;
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.setString('userId', accessCode);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PatientBeforeOperationPage(
          accessCode: codeValue,
        ),
      ),
    );
  }
}
