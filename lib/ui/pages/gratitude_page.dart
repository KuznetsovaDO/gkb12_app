import 'package:flutter/material.dart';

import 'package:gkb12_app/ui/pages/patient_after_operation_page.dart';
import 'package:gkb12_app/ui/widgets/custom_richtext_widget.dart';
import 'package:gkb12_app/ui/pages/patient_discharged_page.dart';

class GratitudePage extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Container(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: Image.asset(
                'assets/images/stars.png',
                height: 100,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 18, bottom: 20),
              child: Text(
                'Спасибо!',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ),
            Text(
                'Мы успешно получили Вашу форму. Ваши ответы будут видны только врачу.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium),
            Container(
                margin: EdgeInsets.symmetric(vertical: 40),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PatientDischargedPage(
                                  isMorning: true,
                                )));
                  },
                  style: Theme.of(context).outlinedButtonTheme.style,
                  child: Text(
                    'Далее',
                  ),
                )),
          ],
        ),
      )),
    );
  }
}
