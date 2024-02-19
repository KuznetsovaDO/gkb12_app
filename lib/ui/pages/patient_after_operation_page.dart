import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
                  ToggleButtons(
                      constraints: BoxConstraints.loose(Size.infinite),
                      direction: Axis.horizontal,
                      borderRadius: BorderRadius.circular(10),
                      renderBorder: false,
                      isSelected: List.generate(
                          5, (index) => index == selectedButtonIndex),
                      children: [
                        SizedBox(
                          width: 70, // <-- Your width
                          height: 70,
                          child: Container(
                              child: Image.asset('assets/images/smile1.png'),
                              decoration: BoxDecoration(
                                  color: Colors.lightGreen.shade200,
                                  border: Border.all(
                                    width: 3,
                                    color: selectedButtonIndex == 0
                                        ? Colors.green.shade700
                                        : Colors.grey,
                                  ),
                                  borderRadius: BorderRadius.circular(10.0))),
                        ),
                        SizedBox(
                          width: 70, // <-- Your width
                          height: 70,
                          child: Container(
                              child: Image.asset('assets/images/smile2.png'),
                              decoration: BoxDecoration(
                                  color: Colors.lightGreen.shade100,
                                  border: Border.all(
                                    width: 2,
                                    color: selectedButtonIndex == 1
                                        ? Colors.green.shade500
                                        : Colors.grey,
                                  ),
                                  borderRadius: BorderRadius.circular(10.0))),
                        ),
                        SizedBox(
                          width: 70, // <-- Your width
                          height: 70,
                          child: Container(
                              child: Image.asset('assets/images/smile3.png'),
                              decoration: BoxDecoration(
                                  color: Colors.yellow.shade100,
                                  border: Border.all(
                                    width: 2,
                                    color: selectedButtonIndex == 2
                                        ? Colors.yellow
                                        : Colors.grey,
                                  ),
                                  borderRadius: BorderRadius.circular(10.0))),
                        ),
                        SizedBox(
                          width: 70, // <-- Your width
                          height: 70,
                          child: Container(
                              child: Image.asset('assets/images/smile4.png'),
                              decoration: BoxDecoration(
                                  color: Colors.orange.shade100,
                                  border: Border.all(
                                    width: 2,
                                    color: selectedButtonIndex == 3
                                        ? Colors.orange
                                        : Colors.grey,
                                  ),
                                  borderRadius: BorderRadius.circular(10.0))),
                        ),
                        SizedBox(
                          width: 70, // <-- Your width
                          height: 70,
                          child: Container(
                              child: Image.asset('assets/images/smile5.png'),
                              decoration: BoxDecoration(
                                  color: Colors.red.shade100,
                                  border: Border.all(
                                    width: 2,
                                    color: selectedButtonIndex == 4
                                        ? Colors.red
                                        : Colors.grey,
                                  ),
                                  borderRadius: BorderRadius.circular(10.0))),
                        )
                      ],
                      onPressed: (int index) =>
                          setState(() => selectedButtonIndex = index)),
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
                            ;
                          },
                          child: Text(
                            'Я дома',
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
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(vertical: 25),
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
              )),
        ));
  }
}
