import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gkb12_app/ui/widgets/patient_condition_widget.dart';
import 'package:gkb12_app/ui/widgets/custom_triangle_togglebutton.dart';
import 'package:gkb12_app/ui/pages/gratitude_page.dart';

class EveningAndMorningFormPage extends StatefulWidget {
  final bool isMorning;
  final String patientId;
  EveningAndMorningFormPage({this.isMorning = false, required this.patientId});
  @override
  _EveningFormPageState createState() => _EveningFormPageState();
}

class _EveningFormPageState extends State<EveningAndMorningFormPage> {
  final formKey = GlobalKey<FormState>();
  String strTemperature = "";
  bool dizziness = false;
  final Map<String, String> someMap = {
    "condition": '1',
    "painIntensity": '1',
    "temperature": '36.6',
    "dizziness": "false",
    "bleeding": "false",
    "nausea": "false"
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text(widget.isMorning == false ? 'Форма "Вечер"' : 'Форма "Утро"'),
        leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                })),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.notifications))
        ],
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(20.0),
          child: Padding(
            padding: EdgeInsets.only(bottom: 5.0),
            child: Text(
              'Вы ответили на 1 из 6 вопросов',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
          child: Container(
              margin: EdgeInsets.all(15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                      margin: EdgeInsets.only(bottom: 10),
                      child: Text(
                        'Оцените свое самочувствие в настоящее время?\n(где 1 - жалоб нет, 5 - очень плохо)',
                        style: Theme.of(context).textTheme.bodyMedium,
                      )),
                  CustomToggleButtons(
                    initialSelectedIndex: 0,
                    onPressed: (int index) {
                      setState(() {
                        someMap["condition"] = (endSelected + 1).toString();
                      });
                    },
                  ),
                  Container(
                      margin: EdgeInsets.only(top: 10, bottom: 10),
                      child: Text(
                        'Пожалуйста, оцените интенсивность боли в послеоперационной области?\n(где 1 - почти не ощущаю, 5 - сложно терпеть)',
                        style: Theme.of(context).textTheme.bodyMedium,
                      )),
                  CustomToggleButtons(
                    initialSelectedIndex: 0,
                    onPressed: (int index) {
                      setState(() {});
                    },
                    isSmiles: false,
                  ),
                  Container(
                      margin: EdgeInsets.only(top: 10, bottom: 15),
                      child: Text(
                        'Пожалуйста, укажите вашу текущую температуру тела',
                        style: Theme.of(context).textTheme.bodyMedium,
                      )),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: SizedBox(
                        height: 50,
                        width: 200,
                        child: TextField(
                            onChanged: (value) => strTemperature = value,
                            onEditingComplete: () {
                              someMap["temperature"] = strTemperature;
                            },
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Температура тела',
                            )),
                      )),
                  Container(
                      margin: EdgeInsets.only(top: 10, bottom: 20),
                      child: const Text(
                        'Отметьте, пожалуйста, наличие/отсутствие у Вас следующих симпотомов:',
                        textAlign: TextAlign.center,
                      )),
                  const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Есть ли у вас головокружение?',
                        textAlign: TextAlign.start,
                      )),
                  Padding(
                      padding: EdgeInsets.only(top: 10, bottom: 20),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: CustomTriangleToggleButtons(
                            label1: 'Да',
                            label2: 'Нет',
                            onPressed: (bool isFirstSelected) {
                              // Пишите здесь код, который будет выполняться при выборе одной из кнопок
                              if (isFirstSelected) {
                                someMap["dizziness"] = "true";
                              } else {
                                someMap["dizziness"] = "false";
                              }
                            },
                          ))),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Есть ли у вас кровотечение?')),
                  Padding(
                      padding: EdgeInsets.only(top: 10, bottom: 20),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: CustomTriangleToggleButtons(
                            label1: 'Да',
                            label2: 'Нет',
                            onPressed: (bool isFirstSelected) {
                              // Пишите здесь код, который будет выполняться при выборе одной из кнопок
                              if (isFirstSelected) {
                                someMap["bleeding"] = "true";
                              } else {
                                someMap["bleeding"] = "false";
                              }
                            },
                          ))),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Есть ли у вас тошнота и рвота?')),
                  Padding(
                      padding: EdgeInsets.only(top: 10, bottom: 20),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: CustomTriangleToggleButtons(
                            label1: 'Да',
                            label2: 'Нет',
                            onPressed: (bool isFirstSelected) {
                              // Пишите здесь код, который будет выполняться при выборе одной из кнопок
                              if (isFirstSelected) {
                                someMap["nausea"] = "true";
                              } else {
                                someMap["nausea"] = "false";
                              }
                            },
                          ))),
                  Container(
                      margin: EdgeInsets.symmetric(vertical: 20),
                      child: ElevatedButton(
                          onPressed: () {
                            writeData(widget.patientId, someMap, context);
                          },
                          child: Text(
                            'Отправить форму',
                          ),
                          style: Theme.of(context).outlinedButtonTheme.style)),
                ],
              ))),
    );
  }

  Future<void> writeData(
      String patientId, Map data, BuildContext context) async {
    try {
      DocumentReference documentReference =
          FirebaseFirestore.instance.collection('patients').doc(patientId);

      // Получаем ссылку на документ с заданным documentId

      // Обновляем поля документа с помощью метода update
      await documentReference.update({'Status': 'Заполнил форму "Утро"'});
      await documentReference.update({'morningForm': data});
      someMap["painIntensity"] = (endSelectedIfNums + 1).toString();
      someMap["condition"] = (endSelected + 1).toString();
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => GratitudePage(
                    patientId: widget.patientId,
                    isMorning: false,
                  )));

      print('Поле документа успешно обновлено');
    } catch (e) {
      print('Ошибка при обновлении поля документа: $e');
    }
  }
}
