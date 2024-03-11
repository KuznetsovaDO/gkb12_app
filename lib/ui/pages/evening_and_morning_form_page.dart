import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gkb12_app/ui/widgets/patient_condition_widget.dart';
import 'package:gkb12_app/ui/widgets/custom_triangle_togglebutton.dart';
import 'package:gkb12_app/ui/pages/gratitude_page.dart';

class EveningAndMorningFormPage extends StatefulWidget {
  final bool isMorning;
  final String patientId;
  const EveningAndMorningFormPage(
      {super.key, this.isMorning = false, required this.patientId});
  @override
  // ignore: library_private_types_in_public_api
  _EveningFormPageState createState() => _EveningFormPageState();
}

class _EveningFormPageState extends State<EveningAndMorningFormPage> {
  final formKey = GlobalKey<FormState>();
  String strTemperature = "";
  bool dizziness = false;
  int selectedCondition = 0;
  int selectedPain = 0;
  late TextEditingController _controller;
  final Map<String, String> someMap = {
    "condition": '1',
    "painIntensity": '1',
    "temperature": '36.6',
    "dizziness": "true",
    "bleeding": "true",
    "nausea": "true"
  };
  double _temperature = 36.6;
  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: _temperature.toString());
  }

  @override
  Widget build(BuildContext context) {
    int count = 0;
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
                    onSelectedIndexChangedSmiles:
                        handleToggleButtonsIndexChangedSmiles,
                    onSelectedIndexChangedNumbers:
                        handleToggleButtonsIndexChangedNumbers,
                  ),
                  Container(
                      margin: EdgeInsets.only(top: 10, bottom: 10),
                      child: Text(
                        'Пожалуйста, оцените интенсивность боли в послеоперационной области?\n(где 1 - почти не ощущаю, 5 - сложно терпеть)',
                        style: Theme.of(context).textTheme.bodyMedium,
                      )),
                  CustomToggleButtons(
                    initialSelectedIndex: 0,
                    isSmiles: false,
                    onSelectedIndexChangedNumbers:
                        handleToggleButtonsIndexChangedNumbers,
                    onSelectedIndexChangedSmiles:
                        handleToggleButtonsIndexChangedNumbers,
                  ),
                  Container(
                      margin: EdgeInsets.only(top: 10, bottom: 15),
                      child: Text(
                        'Пожалуйста, укажите вашу текущую температуру тела',
                        style: Theme.of(context).textTheme.bodyMedium,
                      )),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          decoration: InputDecoration(
                              hintText: 'Введите температуру',
                              suffixText: '°C',
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 16),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          controller: _controller,
                          keyboardType:
                              TextInputType.numberWithOptions(decimal: true),
                          onChanged: (value) {
                            setState(() {
                              _temperature =
                                  double.tryParse(value) ?? _temperature;
                            });
                          },
                        ),
                      ),
                      SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () {
                          _incrementTemperature(0.1);
                        },
                        child: Icon(Icons.arrow_upward),
                      ),
                      SizedBox(width: 5),
                      ElevatedButton(
                        onPressed: () {
                          _incrementTemperature(-0.1);
                        },
                        child: Icon(Icons.arrow_downward),
                      ),
                    ],
                  ),
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
      someMap["painIntensity"] = (selectedPain + 1).toString();
      someMap["condition"] = (selectedPain + 1).toString();
      if (widget.isMorning) {
        await documentReference.update({'morningForm': data});
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => GratitudePage(
                      patientId: widget.patientId,
                      isMorning: true,
                    )));
      } else {
        await documentReference.update({'eveningForm': data});
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => GratitudePage(
                      patientId: widget.patientId,
                      isMorning: false,
                    )));
      }

      print('Поле документа успешно обновлено');
    } catch (e) {
      print('Ошибка при обновлении поля документа: $e');
    }
  }

  void _incrementTemperature(double delta) {
    setState(() {
      _temperature += delta;
      _controller.text = _temperature.toStringAsFixed(1);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void handleToggleButtonsIndexChangedSmiles(int index) {
    setState(() {
      selectedCondition = index;
    });
  }

  void handleToggleButtonsIndexChangedNumbers(int index) {
    setState(() {
      // Делайте что-то с индексом, если нужно
      selectedPain = index;
    });
  }
}
