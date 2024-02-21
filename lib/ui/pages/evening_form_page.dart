import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gkb12_app/ui/widgets/patient_condition_widget.dart';
import 'package:gkb12_app/ui/widgets/custom_triangle_togglebutton.dart';

class EveningFormPage extends StatefulWidget {
  @override
  _EveningFormPageState createState() => _EveningFormPageState();
}

class _EveningFormPageState extends State<EveningFormPage> {
  final formKey = GlobalKey<FormState>();
  int selectedButtonIndex = 0;
  @override
  Widget build(BuildContext context) {
    List<bool> _isSelected = [false, true];
    return Scaffold(
      appBar: AppBar(
        title: Text('Форма "Вечер'),
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
          preferredSize:
              Size.fromHeight(30.0), // Установите желаемую высоту подзаголовка
          child: Padding(
            padding: EdgeInsets.only(bottom: 8.0),
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
                  Text(
                    'Оцените свое самочувствие в настоящее время?\n(где 1 - жалоб нет, 5 - очень плохо)',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  CustomToggleButtons(
                    initialSelectedIndex: selectedButtonIndex,
                    onPressed: (int index) {
                      setState(() {
                        selectedButtonIndex = index;
                      });
                    },
                  ),
                  Text(
                    'Пожалуйста, оцените интенсивность боли в послеоперационнойобласти:?\n(где 1 - почти не ощущаю, 5 - сложно терпеть)',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  CustomToggleButtons(
                    initialSelectedIndex: selectedButtonIndex,
                    onPressed: (int index) {
                      setState(() {
                        selectedButtonIndex = index;
                      });
                    },
                    isSmiles: false,
                  ),
                  Text(
                    'Пожалуйста, укажите вашу текущую температуру тела',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const Align(
                      alignment: Alignment.centerLeft,
                      child: SizedBox(
                        width: 200,
                        child: TextField(
                            decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Температура тела',
                        )),
                      )),
                  Text(
                      'Отметьте, пожалуйста, наличие/отсутствие у Вас следующих симпотомов:'),
                  Text('Есть ли у вас головокружение?'),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: CustomTriangleToggleButtons(
                        label1: 'Да',
                        label2: 'Нет',
                        onPressed: (bool isFirstSelected) {
                          // Пишите здесь код, который будет выполняться при выборе одной из кнопок
                          if (isFirstSelected) {
                            print('Выбрана кнопка 1');
                          } else {
                            print('Выбрана кнопка 2');
                          }
                        },
                      )),
                  Text('Есть ли у вас кровотечение?'),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: CustomTriangleToggleButtons(
                        label1: 'Да',
                        label2: 'Нет',
                        onPressed: (bool isFirstSelected) {
                          // Пишите здесь код, который будет выполняться при выборе одной из кнопок
                          if (isFirstSelected) {
                            print('Да');
                          } else {
                            print('Нет');
                          }
                        },
                      )),
                  Text('Есть ли у вас тошнота и рвота?'),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: CustomTriangleToggleButtons(
                        label1: 'Да',
                        label2: 'Нет',
                        onPressed: (bool isFirstSelected) {
                          // Пишите здесь код, который будет выполняться при выборе одной из кнопок
                          if (isFirstSelected) {
                            print('Выбрана кнопка 1');
                          } else {
                            print('Выбрана кнопка 2');
                          }
                        },
                      )),
                ],
              ))),
    );
  }
}
