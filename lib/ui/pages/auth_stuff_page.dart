import 'package:flutter/material.dart';
import 'package:gkb12_app/controllers/doctors_controller.dart';
import 'package:gkb12_app/controllers/registrators_controller.dart';
import 'package:gkb12_app/ui/pages/registrator_main_page.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gkb12_app/ui/pages/doctor_main_page.dart';

bool exist = false;
String codeValue = '';

class AuthStaffPage extends StatefulWidget {
  const AuthStaffPage({super.key});

  @override
  State<AuthStaffPage> createState() => _AuthStaffPageState();
}

class _AuthStaffPageState extends State<AuthStaffPage> {
  TextEditingController textEditingController = TextEditingController();
  // ..text = "123456";

  String debugMessage = "";
  final formKey = GlobalKey<FormState>();
  DoctorsController controllerD = DoctorsController();
  RegistratorsController controllerR = RegistratorsController();
  String codeValue = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
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
          ],
        ),
        body: SingleChildScrollView(
          child: Center(
              child: Container(
            margin: EdgeInsets.fromLTRB(15, 30, 15, 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Пожалуйста, введите код сотрудника',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                Container(
                    margin: EdgeInsets.symmetric(vertical: 30),
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
                          if (codeValue.length == 4) {
                            if (codeValue[0] == "D") {
                              // Вызываем метод checkPatient напрямую из контроллера PatientController
                              bool isDoctorValid =
                                  await controllerD.checkDoctor(codeValue);
                              String profile = await controllerD
                                  .getDoctorsProfile(codeValue);
                              if (isDoctorValid == true) {
                                // Если пациент существует, переходим на страницу PatientBeforeOperationPage
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        DoctorMainPage(medProfile: profile),
                                  ),
                                );
                              } else {
                                // Если доктор не существует, вы можете выполнить какие-то действия, например, показать сообщение об ошибке
                                setState(() {
                                  debugMessage =
                                      "Сотрудник с таким кодом не найден";
                                });
                              }
                            } else if (codeValue[0] == "R") {
                              bool isRegValid =
                                  await controllerR.checkRegistrator(codeValue);
                              if (isRegValid) {
                                // Если пациент существует, переходим на страницу PatientBeforeOperationPage
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => RegistratorMainPage(),
                                  ),
                                );
                              } else {
                                // Если пациент не существует, вы можете выполнить какие-то действия, например, показать сообщение об ошибке
                                setState(() {
                                  debugMessage =
                                      "Сотрудник с таким кодом не найден";
                                });
                              }
                            }
                          } else {
                            setState(() {
                              debugMessage =
                                  "Код должен содержать не менее 4 символов";
                            });
                          }
                        },
                        child: Text(
                          'Войти как сотрудник',
                          style: GoogleFonts.ibmPlexSans(
                              fontSize: 20,
                              letterSpacing: 0,
                              fontWeight: FontWeight.w500),
                        ),
                        style: Theme.of(context).outlinedButtonTheme.style)),
                Text('Не получили код?',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.ibmPlexSans(
                        fontSize: 18,
                        letterSpacing: 0,
                        fontWeight: FontWeight.w700)),
                Text('+8999999999',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.ibmPlexSans(
                        fontSize: 18,
                        letterSpacing: 0,
                        fontWeight: FontWeight.w500)),
              ],
            ),
          )),
        ));
  }
}
