import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gkb12_app/ui/pages/auth_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gkb12_app/ui/pages/patient_after_operation_page.dart';
import 'package:gkb12_app/ui/widgets/custom_richtext_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PatientBeforeOperationPage extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  final String? patientId;
  PatientBeforeOperationPage({required this.patientId});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Статус: перед операцией',
              style: GoogleFonts.ibmPlexSans(
                  fontSize: 18, letterSpacing: 0, fontWeight: FontWeight.w500)),
          leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () async {
                    bool? result = await showExitProfileDialog(context);
                    if (result != null && result) {
                      final prefs = await SharedPreferences.getInstance();
                      await prefs.remove('userId');
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AuthPage(),
                          ));
                    }
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
                          changeStatus(patientId!, context);
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
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0,
                          color: Colors.grey[500],
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

  Future<void> changeStatus(String patientId, BuildContext context) async {
    try {
      // Получаем ссылку на документ по patientId
      DocumentReference documentReference =
          FirebaseFirestore.instance.collection('patients').doc(patientId);

      // Получаем сам документ
      DocumentSnapshot<Object?> documentSnapshot =
          await documentReference.get();

      // Проверяем, существует ли документ
      if (documentSnapshot.exists) {
        // Обновляем поле 'status' документа с помощью метода update
        await documentReference.update({'status': 'после операции'});
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PatientAfterOperationPage(
                      patientId: patientId,
                    )));
        print('Статус документа успешно обновлен');
      } else {
        print('Документ с указанным patientId не найден');
      }
    } catch (error) {
      print('Произошла ошибка при обновлении статуса: $error');
    }
  }

  Future<bool?> showExitProfileDialog(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Хотите выйти из профиля?"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(
                    true); // Возвращает true, если пользователь выбрал "Да"
              },
              child: Text('Да'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(
                    false); // Возвращает false, если пользователь выбрал "Нет"
              },
              child: Text('Нет'),
            ),
          ],
        );
      },
    );
  }
}
