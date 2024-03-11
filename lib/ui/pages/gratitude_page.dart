import 'package:flutter/material.dart';
import 'package:gkb12_app/ui/pages/after_discharged_page.dart';

import 'package:gkb12_app/ui/pages/state_change_form.dart';
import 'package:url_launcher/url_launcher.dart';

class GratitudePage extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  final String patientId;
  final bool isMorning;
  GratitudePage({required this.patientId, this.isMorning = false});
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
                    if (isMorning) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AfterDischargedPage(
                                    patientId: patientId,
                                    isMorning: true,
                                  )));
                    } else {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  StateChangeForm(patientId: patientId)));
                    }
                  },
                  style: Theme.of(context).outlinedButtonTheme.style,
                  child: Text(
                    'Далее',
                  ),
                )),
            ElevatedButton(
              onPressed: () => _launchPhoneCall("112"),
              child: Text('Позвонить 112'),
            )
          ],
        ),
      )),
    );
  }

  _launchPhoneCall(String phoneNumber) async {
    final url = 'tel:$phoneNumber';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Не удалось запустить приложение для звонков';
    }
  }
}
