import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gkb12_app/ui/pages/doctor_main_page.dart';

class AuthStuffPage extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
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

          //more widgets to place here
        ],
      ),
      body: Center(
          child: Container(
        margin: EdgeInsets.fromLTRB(15, 30, 15, 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              'Пожалуйста, введите код сотрудника',
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
                              builder: (context) => DoctorMainPage()));
                    },
                    child: Text(
                      'Войти как сотрудник',
                      style: GoogleFonts.ibmPlexSans(
                          fontSize: 20,
                          letterSpacing: 0,
                          fontWeight: FontWeight.w500),
                    ),
                    style: TextButton.styleFrom(
                      primary: Colors.white,
                      minimumSize: Size.fromHeight(50),
                      onSurface: Colors.red,
                      backgroundColor: Colors.blueAccent[700],
                    ))),
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
    );
  }
}
