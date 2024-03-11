import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gkb12_app/ui/widgets/patient_condition_widget.dart';
import 'package:gkb12_app/ui/widgets/custom_triangle_togglebutton.dart';
import 'package:gkb12_app/ui/pages/gratitude_page.dart';

class PatientFormForStaffPage extends StatelessWidget {
  final bool isMorning;
  final String? patientId;
  final Map<String, String>? someMap;

  const PatientFormForStaffPage(
      {Key? key,
      this.isMorning = false,
      required this.patientId,
      required this.someMap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isMorning ? 'Форма "Утро"' : 'Форма "Вечер"'),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications),
          ),
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
                ),
              ),
              CustomToggleButtons(
                initialSelectedIndex: int.parse(someMap!["condition"]!) - 1,
                onSelectedIndexChangedSmiles:
                    handleToggleButtonsIndexChangedSmiles,
                onSelectedIndexChangedNumbers:
                    handleToggleButtonsIndexChangedNumbers,
              ),
              Container(
                margin: EdgeInsets.only(bottom: 10),
                child: Text(
                  'Оцените интенсивность боли?\n(где 1 - жалоб нет, 5 - очень плохо)',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              CustomToggleButtons(
                isSmiles: false,
                initialSelectedIndex: int.parse(someMap!["painIntensity"]!) - 1,
                onSelectedIndexChangedSmiles:
                    handleToggleButtonsIndexChangedSmiles,
                onSelectedIndexChangedNumbers:
                    handleToggleButtonsIndexChangedNumbers,
              ),
              Container(
                  margin: EdgeInsets.only(top: 10, bottom: 15),
                  child: Text(
                    'Пожалуйста, укажите вашу текущую температуру тела',
                    style: Theme.of(context).textTheme.bodyMedium,
                  )),
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1.5,
                        color: Colors.grey,
                      ),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    height: 50,
                    width: 200,
                    child: Text(someMap!["temperature"]!)),
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
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1.5,
                        color: Colors.grey,
                      ),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    height: 50,
                    width: 200,
                    child:
                        Text(someMap!["dizziness"] == "true" ? "Да" : "Нет")),
              ),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Есть ли у вас кровотечение?')),
              Padding(
                padding: EdgeInsets.only(top: 10, bottom: 20),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1.5,
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      height: 50,
                      width: 200,
                      child:
                          Text(someMap!["bleeding"] == "true" ? "Да" : "Нет")),
                ),
              ),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Есть ли у вас тошнота и рвота?')),
              Padding(
                padding: EdgeInsets.only(top: 10, bottom: 20),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1.5,
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      height: 50,
                      width: 200,
                      child: Text(someMap!["nausea"] == "true" ? "Да" : "Нет")),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void handleToggleButtonsIndexChangedSmiles(int index) {
    // Обработка изменения индекса
  }

  void handleToggleButtonsIndexChangedNumbers(int index) {
    // Обработка изменения индекса
  }
}
