import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gkb12_app/ui/pages/patient_after_operation_page.dart';
import 'package:gkb12_app/ui/widgets/custom_richtext_widget.dart';

class PatientBeforeOperationPage extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  final String patientId;
  PatientBeforeOperationPage({required this.patientId});
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
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.notifications),
              iconSize: 30,
            )

            //more widgets to place here
          ],
        ),
        body: SingleChildScrollView(
          child: Center(
              child: Container(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                    margin: EdgeInsets.symmetric(vertical: 20),
                    child: ElevatedButton(
                        onPressed: () {
                          changeStatus(patientId, context);
                        },
                        style: Theme.of(context).outlinedButtonTheme.style,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'После операции',
                              ),
                              Container(
                                  margin: EdgeInsets.symmetric(horizontal: 8),
                                  child: Icon(
                                    Icons.done,
                                    size: 30,
                                  ))
                            ]))),
                Text('Пожалуйста, нажмите на эту кнопку после операции',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium),
                Container(
                    margin: EdgeInsets.symmetric(vertical: 40),
                    child: OutlinedButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                            textStyle: Theme.of(context).textTheme.labelMedium,
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
                    text: 'Рекомендации до операции\n\n',
                    style: GoogleFonts.ibmPlexSans(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0,
                      color: Colors.black,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text:
                            '1. Перед операцией вам нужно сдать все необходимые анализы',
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
            ),
          )),
        ));
  }

  Future<void> changeStatus(String accessCode, BuildContext context) async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance
              .collection('patients')
              .where("access_code", isEqualTo: accessCode)
              .get();

      String documentId = querySnapshot.docs.first.id;
      if (querySnapshot.docs.isNotEmpty) {
        // Получаем первый документ из результата запроса
        DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
            querySnapshot.docs.first;

        // Получаем ссылку на документ
        DocumentReference documentReference = documentSnapshot.reference;

        // Обновляем поля документа с помощью метода update
        await documentReference.update({'status': 'после операции'});
      } else {
        print('Документ с указанным access_code не найден');
      }

      // ignore: use_build_context_synchronously
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => PatientAfterOperationPage(
                    patientId: documentId,
                  )));
      print('Поле документа успешно обновлено');
    } catch (e) {
      print('Ошибка при обновлении поля документа: $e');
    }
  }
}
