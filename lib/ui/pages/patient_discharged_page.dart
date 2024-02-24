import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gkb12_app/ui/widgets/patient_condition_widget.dart';
import 'package:gkb12_app/ui/pages/evening_form_page.dart';
import 'package:gkb12_app/ui/widgets/custom_richtext_widget.dart';

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
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.notifications,
                  size: 30,
                ))

            //more widgets to place here
          ],
        ),
        body: SingleChildScrollView(
            child: Center(
          child: Container(
              margin: EdgeInsets.all(15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                      margin: EdgeInsets.fromLTRB(0, 15, 0, 10),
                      child: OutlinedButton(
                          style: Theme.of(context).outlinedButtonTheme.style,
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EveningFormPage()));
                          },
                          child: Text(
                            'Пройти форму вечер',
                          ))),
                  const Text(
                    'Пожалуйста, нажмите эту кнопку после 20:00 в день выписки из больницы',
                    textAlign: TextAlign.center,
                  ),
                  Container(
                      margin: EdgeInsets.symmetric(vertical: 20),
                      child: OutlinedButton(
                          onPressed: () {},
                          style: TextButton.styleFrom(
                              textStyle:
                                  Theme.of(context).textTheme.labelMedium,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              side: BorderSide(width: 2, color: Colors.black),
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.black),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Написать врачу',
                                ),
                                Container(
                                    margin: EdgeInsets.symmetric(horizontal: 8),
                                    child: Icon(
                                      Icons.create,
                                      size: 25,
                                    ))
                              ]))),
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
                      margin: EdgeInsets.only(bottom: 20),
                      child: Text(
                        'Пожалуйста, пройдите форму обратной связи, чтобы мы могли улучшить работу нашего стационара! Спасибо!',
                        textAlign: TextAlign.center,
                      )),
                  CustomRichTextContainer(
                      richText: RichText(
                    text: TextSpan(
                      text: 'Рекомендации\n\n',
                      style: GoogleFonts.ibmPlexSans(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0,
                        color: Colors.black,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text:
                              'В течение 2-3 недель после операции исключить:',
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
              )),
        )));
  }
}
