import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gkb12_app/ui/widgets/patient_condition_widget.dart';

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
          title: Text('Статус: выписан(-а)'),
          leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
                  })),
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.notifications))

            //more widgets to place here
          ],
        ),
        body: Center(
          child: Container(
              margin: EdgeInsets.all(15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  CustomToggleButtons(
                    initialSelectedIndex: selectedButtonIndex,
                    onPressed: (int index) {
                      setState(() {
                        selectedButtonIndex = index;
                      });
                    },
                    isSmiles: false,
                  ),
                ],
              )),
        ));
  }
}
