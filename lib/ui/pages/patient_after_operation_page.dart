import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gkb12_app/ui/pages/patient_discharged_page.dart';
import 'package:gkb12_app/ui/widgets/patient_condition_widget.dart';

class PatientAfterOperationPage extends StatefulWidget {
  @override
  _PatientAfterOperationPageState createState() =>
      _PatientAfterOperationPageState();
}

class _PatientAfterOperationPageState extends State<PatientAfterOperationPage> {
  final formKey = GlobalKey<FormState>();
  int selectedButtonIndex = 0;
  @override
  Widget build(BuildContext context) {
    List<bool> _isSelected = [false, true];
    return Scaffold(
        appBar: AppBar(
          title: Text('Статус: после операции'),
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
                  Text('Как вы себя чувствуете?'),
                  CustomToggleButtons(
                    initialSelectedIndex: selectedButtonIndex,
                    onPressed: (int index) {
                      setState(() {
                        selectedButtonIndex = index;
                      });
                    },
                    isSmiles: true,
                  ),
                  const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 60,
                            child: Text(
                              'Жалоб нет',
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(
                            width: 60,
                            child: Text(
                              'Очень плохо',
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      )),
                  Container(
                      margin: EdgeInsets.symmetric(vertical: 20),
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        PatientDischargedPage()));
                          },
                          child: Text('Я дома',
                              style: Theme.of(context).textTheme.labelMedium),
                          style: Theme.of(context).outlinedButtonTheme.style)),
                  Text('Пожалуйста, нажмите эту кнопку после прибытия домой',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.ibmPlexSans(
                          fontSize: 18,
                          letterSpacing: 0,
                          fontWeight: FontWeight.w700)),
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
                            'Написать врачу',
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
