import 'package:flutter/material.dart';
import 'package:gkb12_app/ui/pages/auth_stuff_page.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gkb12_app/ui/pages/patient_before_operation_page.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key, required this.title});

  final String title;

  @override
  State<AuthPage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<AuthPage> {
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
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
                  MaterialPageRoute(builder: (context) => AuthStuffPage()));
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
      body: Center(
          child: Container(
        margin: EdgeInsets.fromLTRB(15, 30, 15, 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              'Пожалуйста, введите код пациента',
              textAlign: TextAlign.center,
              style: GoogleFonts.ibmPlexSans(
                  fontSize: 35, fontWeight: FontWeight.w700, letterSpacing: 0),
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
                  appContext: context,
                  length: 4,
                  obscureText: false,
                  textStyle: GoogleFonts.ibmPlexSans(
                      fontSize: 30,
                      letterSpacing: 0,
                      fontWeight: FontWeight.w700),
                  animationType: AnimationType.fade,
                  validator: (v) {
                    if (v!.length < 3) {
                      return "Неверный код";
                    } else {
                      return null;
                    }
                  },
                  pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(10),
                      fieldHeight: 80,
                      fieldWidth: 80,
                      activeFillColor: Colors.white,
                      inactiveColor: Colors.grey,
                      selectedColor: Colors.blueAccent[700],
                      activeColor: Colors.blueAccent[700]),
                  cursorColor: Colors.black,
                  animationDuration: const Duration(milliseconds: 300),
                  enableActiveFill: false,
                  keyboardType: TextInputType.number,
                  boxShadows: const [
                    BoxShadow(
                      offset: Offset(0, 1),
                      color: Colors.black12,
                      blurRadius: 10,
                    )
                  ],
                  onCompleted: (v) {
                    debugPrint() {}
                    ;
                  },
                  onChanged: (value) {
                    debugPrint(value);
                    setState(() {});
                  },
                ),
              ),
            ),
            Container(
                margin: EdgeInsets.symmetric(vertical: 20),
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  PatientBeforeOperationPage()));
                    },
                    child: Text(
                      'Войти',
                      style: GoogleFonts.ibmPlexSans(
                          fontSize: 20,
                          letterSpacing: 0,
                          fontWeight: FontWeight.w500),
                    ),
                    style: OutlinedButton.styleFrom(
                        primary: Colors.white,
                        minimumSize: Size.fromHeight(50),
                        onSurface: Colors.red,
                        backgroundColor: Colors.blueAccent[700],
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))))),
            Text('Код будет выдан Вам в регистратуре \nНе получили код?',
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
            Container(
                margin: EdgeInsets.symmetric(vertical: 20),
                child: OutlinedButton(
                    onPressed: () {},
                    child: Text(
                      'Посмотреть адрес и контакты',
                      style: GoogleFonts.ibmPlexSans(
                          fontSize: 19,
                          letterSpacing: 0,
                          fontWeight: FontWeight.w500),
                    ),
                    style: TextButton.styleFrom(
                        minimumSize: Size.fromHeight(50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        side: BorderSide(width: 2, color: Colors.black),
                        foregroundColor: Colors.black))),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(),
              padding: const EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                  ),
                  borderRadius: BorderRadius.circular(5.0)),
              child: Text(
                'Чек-лист text text text text text text text text text text text text text text text text',
                textAlign: TextAlign.center,
                style: GoogleFonts.ibmPlexSans(
                    fontSize: 20,
                    letterSpacing: 0,
                    fontWeight: FontWeight.w500),
              ),
            )
          ],
        ),
      )),
    );
  }
}
