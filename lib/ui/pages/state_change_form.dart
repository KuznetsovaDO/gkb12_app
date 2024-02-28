import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gkb12_app/ui/pages/gratitude_page.dart';
import 'package:gkb12_app/ui/pages/evening_and_morning_form_page.dart';

class StateChangeForm extends StatelessWidget {
  final String patientId;
  StateChangeForm({required this.patientId});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Форма "Утро"'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Text(
              'Изменилось ли ваше состояние?',
              style: GoogleFonts.ibmPlexSans(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                letterSpacing: 0,
                color: Colors.grey[800],
              ),
            ),
            Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  children: [
                    SizedBox(
                        height: 40,
                        width: 120,
                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        EveningAndMorningFormPage(
                                          isMorning: true,
                                          patientId: patientId,
                                        )));
                          },
                          child: Text("Стало хуже",
                              style: GoogleFonts.ibmPlexSans(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 0,
                                color: Colors.black,
                              )),
                          style: TextButton.styleFrom(
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              side: BorderSide(
                                  width: 1, color: Colors.grey.shade500),
                              backgroundColor: Colors.white),
                        )),
                    Container(
                        margin: EdgeInsets.symmetric(horizontal: 5),
                        child: SizedBox(
                            height: 40,
                            width: 120,
                            child: OutlinedButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => GratitudePage(
                                              patientId: patientId,
                                              isMorning: true,
                                            )));
                              },
                              child: Text("Не изменилось",
                                  style: GoogleFonts.ibmPlexSans(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 0,
                                    color: Colors.black,
                                  )),
                              style: OutlinedButton.styleFrom(
                                  padding: EdgeInsets.all(2),
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  side: BorderSide(
                                      width: 1, color: Colors.grey.shade500),
                                  backgroundColor: Colors.white),
                            ))),
                    SizedBox(
                        height: 40,
                        width: 120,
                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        EveningAndMorningFormPage(
                                          isMorning: true,
                                          patientId: patientId,
                                        )));
                          },
                          child: Text("Стало лучше",
                              style: GoogleFonts.ibmPlexSans(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 0,
                                color: Colors.black,
                              )),
                          style: OutlinedButton.styleFrom(
                              padding: EdgeInsets.all(1),
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              side: BorderSide(
                                  width: 1, color: Colors.grey.shade500),
                              backgroundColor: Colors.white),
                        ))
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
