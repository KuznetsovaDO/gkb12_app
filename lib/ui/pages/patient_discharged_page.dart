import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gkb12_app/ui/widgets/patient_condition_widget.dart';
import 'package:gkb12_app/ui/pages/evening_form_page.dart';

class PatientDischargedPage extends StatefulWidget {
  @override
  _PatientDischargedPageState createState() => _PatientDischargedPageState();
}

class _PatientDischargedPageState extends State<PatientDischargedPage> {
  final formKey = GlobalKey<FormState>();
  int selectedButtonIndex = 0;
  @override
  Widget build(BuildContext context) {
    List<bool> _isSelected = [false, true];
    return Scaffold(
        appBar: AppBar(
          title: Text('Статус: выписан(-а)'),
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
              margin: EdgeInsets.all(15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  OutlinedButton(
                      style: Theme.of(context).outlinedButtonTheme.style,
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EveningFormPage()));
                      },
                      child: Text(
                        'Пройти форму вечер',
                        style: Theme.of(context).textTheme.labelMedium,
                      )),
                  const Text(
                    'Пожалуйста, нажмите эту кнопку после 20:00 в день выписки из больницы',
                    textAlign: TextAlign.center,
                  ),
                  Container(
                      margin: EdgeInsets.symmetric(vertical: 20),
                      child: OutlinedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EveningFormPage()));
                          },
                          style: TextButton.styleFrom(
                              elevation: 0,
                              side: BorderSide(width: 1.5, color: Colors.black),
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.black),
                          child: Text(
                            'Написать врачу',
                            style: GoogleFonts.ibmPlexSans(
                                fontSize: 20,
                                letterSpacing: 0,
                                fontWeight: FontWeight.w500),
                          ))),
                  Container(
                      margin: EdgeInsets.symmetric(vertical: 20),
                      child: OutlinedButton(
                          onPressed: () {},
                          style: TextButton.styleFrom(
                              elevation: 0,
                              side: BorderSide(width: 1.5, color: Colors.black),
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.black),
                          child: Text(
                            'Оценить качество обслуживания',
                            style: GoogleFonts.ibmPlexSans(
                                fontSize: 20,
                                letterSpacing: 0,
                                fontWeight: FontWeight.w500),
                          ))),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(vertical: 25),
                    padding: const EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(10.0)),
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
              )),
        ));
  }
}
