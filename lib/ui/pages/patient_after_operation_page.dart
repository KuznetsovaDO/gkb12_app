import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gkb12_app/ui/pages/patient_discharged_page.dart';
import 'package:gkb12_app/ui/widgets/patient_condition_widget.dart';
import 'package:gkb12_app/ui/widgets/custom_richtext_widget.dart';

class PatientAfterOperationPage extends StatefulWidget {
  final String patientId;
  PatientAfterOperationPage({required this.patientId});
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
                icon: const Icon(
                  Icons.arrow_back,
                ),
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
        ],
      ),
      body: SingleChildScrollView(
          child: Container(
              margin: EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                      padding: EdgeInsets.fromLTRB(0, 25, 0, 10),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Как вы себя чувствуете?',
                            textAlign: TextAlign.left,
                            style: Theme.of(context).textTheme.labelMedium,
                          ))),
                  CustomToggleButtons(
                    initialSelectedIndex: selectedButtonIndex,
                    onPressed: (int index) {
                      setState(() {});
                    },
                    isSmiles: true,
                  ),
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 60,
                            child: Text(
                              'Жалоб нет',
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ),
                          SizedBox(
                            width: 60,
                            child: Text(
                              'Очень плохо',
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ),
                        ],
                      )),
                  Container(
                      margin: EdgeInsets.symmetric(vertical: 20),
                      child: ElevatedButton(
                          onPressed: () {
                            changeStatus(widget.patientId, context);
                          },
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Я дома',
                                ),
                                Container(
                                    margin: EdgeInsets.symmetric(horizontal: 8),
                                    child: Icon(
                                      Icons.home,
                                      size: 30,
                                    ))
                              ]),
                          style: Theme.of(context).outlinedButtonTheme.style)),
                  Text('Пожалуйста, нажмите эту кнопку после прибытия домой',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium),
                  Container(
                      margin: EdgeInsets.symmetric(vertical: 35),
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
                  CustomRichTextContainer(
                      richText: RichText(
                    text: TextSpan(
                      text: 'Важная информация\n\n',
                      style: GoogleFonts.ibmPlexSans(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0,
                        color: Colors.black,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text:
                              'Сейчас вы находитесь в палате под наблюдением медицинского персонала',
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
              ))),
    );
  }

  Future<void> changeStatus(String patientId, BuildContext context) async {
    try {
      // Получаем ссылку на документ с заданным documentId
      DocumentReference documentReference =
          FirebaseFirestore.instance.collection('patients').doc(patientId);

      // Обновляем поля документа с помощью метода update
      await documentReference.update({'Status': 'Выписан(-а)'});
      await documentReference
          .update({'ConditionAfterOperation': endSelected + 1});
      // ignore: use_build_context_synchronously
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => PatientDischargedPage(
                    patientId: widget.patientId,
                  )));
      print('Поле документа успешно обновлено');
    } catch (e) {
      print('Ошибка при обновлении поля документа: $e');
    }
  }
}
