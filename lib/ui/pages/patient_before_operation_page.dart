import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gkb12_app/ui/pages/patient_after_operation_page.dart';

class PatientBeforeOperationPage extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Статус: перед операцией'),
        leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                })),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.notifications))

          //more widgets to place here
        ],
      ),
      body: Center(
          child: Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
                margin: EdgeInsets.symmetric(vertical: 20),
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  PatientAfterOperationPage()));
                    },
                    child: Text(
                      'После операции',
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
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))))),
            Text('Пожалуйста, нажмите на эту кнопку после операции',
                textAlign: TextAlign.center,
                style: GoogleFonts.ibmPlexSans(
                    fontSize: 18,
                    letterSpacing: 0,
                    fontWeight: FontWeight.w500)),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(vertical: 20),
              padding: const EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                  ),
                  borderRadius: BorderRadius.circular(10.0)),
              child: Text(
                'Рекомендации после операции text text text text text text text text text text text text text text text text',
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
