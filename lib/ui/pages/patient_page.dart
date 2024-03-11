import 'package:flutter/material.dart';
import 'package:gkb12_app/controllers/patient_controller.dart';
import 'package:gkb12_app/models/patient_model.dart';
import 'package:gkb12_app/ui/pages/patient_form_for_staff.dart';
import 'package:google_fonts/google_fonts.dart';

class PatientProfile extends StatefulWidget {
  final String accessCode;
  const PatientProfile({Key? key, required this.accessCode}) : super(key: key);

  @override
  State<PatientProfile> createState() => _PatientProfileState();
}

class _PatientProfileState extends State<PatientProfile> {
  PatientController controller = PatientController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        actions: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Icon(Icons.arrow_back),
            OutlinedButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                    minimumSize: Size.fromWidth(30),
                    textStyle: Theme.of(context).textTheme.labelMedium,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    side: BorderSide(width: 2, color: Colors.black),
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text(
                    'Редактировать',
                  ),
                  Container(
                      margin: EdgeInsets.symmetric(horizontal: 8),
                      child: Icon(
                        Icons.edit,
                        size: MediaQuery.of(context).size.width * 0.10,
                      ))
                ])),
          ])
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10),
        child: FutureBuilder<PatientModel>(
          future: controller.getPatientData(widget.accessCode),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Пациент: #${snapshot.data!.id}",
                      style: Theme.of(context).textTheme.headlineLarge,
                      textAlign: TextAlign.left,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              TextFormField(
                                enabled: false,
                                decoration: InputDecoration(
                                  labelText: snapshot.data!.accessCode,
                                  labelStyle: GoogleFonts.ibmPlexSans(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: 0,
                                      color: Colors.black),
                                  border: UnderlineInputBorder(),
                                ),
                              ),
                              Text("Код доступа")
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              TextFormField(
                                enabled: false,
                                decoration: InputDecoration(
                                  labelText: "",
                                  labelStyle: GoogleFonts.ibmPlexSans(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: 0,
                                      color: Colors.black),
                                  border: UnderlineInputBorder(),
                                ),
                              ),
                              Text("Код доступа")
                            ],
                          ),
                        )
                      ],
                    ),
                    Card(
                      margin: EdgeInsets.symmetric(vertical: 7),
                      elevation: 10,
                      surfaceTintColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        side: const BorderSide(
                          width: 1,
                          color: Colors.grey,
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text("Форма \"Вечер\""),
                            Text(
                                "Результаты самообследования пациента спустя 24 часа после операции"),
                            OutlinedButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.resolveWith<Color?>(
                                    (states) {
                                      if (snapshot.data != null &&
                                          snapshot.data!.eveningForm != null &&
                                          snapshot
                                              .data!.eveningForm!.isNotEmpty) {
                                        // Возвращаем синий цвет, если eveningForm не пустое
                                        return Colors.blue;
                                      } else {
                                        // Возвращаем серый цвет в других случаях
                                        return Colors.grey;
                                      }
                                    },
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              PatientFormForStaffPage(
                                                patientId: snapshot.data!.id,
                                                someMap:
                                                    snapshot.data!.eveningForm,
                                              )));
                                },
                                child: Text("Посмотреть"))
                          ],
                        ),
                      ),
                    )
                  ],
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text(snapshot.error.toString()),
                );
              }
            } else {
              return const Center(child: CircularProgressIndicator());
            }
            return Container();
          },
        ),
      ),
    );
  }
}
