import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key, required this.title});

  final String title;

  @override
  State<AuthPage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<AuthPage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            "assets/icons/logo.jpg",
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {},
            child: Text('Войти как сотрудник'),
          ),
        ],
      ),
      body: Center(
          child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              'Пожалуйста, введите код пациента',
              textAlign: TextAlign.end,
            ),
            Text(
              'Код был ранее выдан Вам в регистратуре',
            ),
            PinCodeTextField(
              mainAxisAlignment: MainAxisAlignment.center,
              appContext: context,
              length: 4,
              obscureText: false,
              animationType: AnimationType.fade,
              pinTheme: PinTheme(
                shape: PinCodeFieldShape.box,
                borderRadius: BorderRadius.circular(5),
                fieldHeight: 70,
                fieldWidth: 70,
                activeFillColor: Colors.black,
                inactiveColor: Colors.blue,
              ),
            ),
            ElevatedButton(
                onPressed: () {},
                child: Text('Войти'),
                style: TextButton.styleFrom(
                    primary: Colors.white,
                    onSurface: Colors.red,
                    backgroundColor: Colors.blueAccent)),
            Text(
              'Код будет выдан Вам в регистратуре \nНе получили код?\n89999999999',
              textAlign: TextAlign.center,
            ),
            OutlinedButton(
                onPressed: () {},
                child: Text('Посмотреть адрес и контакты'),
                style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    side: BorderSide(width: 2, color: Colors.black),
                    foregroundColor: Colors.black)),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.all(6.0),
              padding: const EdgeInsets.all(3.0),
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                  ),
                  borderRadius: BorderRadius.circular(5.0)),
              child: Text(
                  'Чек-лист ххххххххххххххххххххххххххххххххххххххххххххххххххххххххххххххххх'),
            )
          ],
        ),
      )),
    );
  }
}
