import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gkb12_app/controllers/patient_controller.dart';
import 'package:gkb12_app/models/patient_model.dart';
import 'package:gkb12_app/ui/pages/patient_form_for_staff.dart';

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
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Обработка нажатия кнопки стрелки назад
          },
        ),
        actions: [TextButton(onPressed: () {}, child: Text("Редактировать"))],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(15),
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
                      style: GoogleFonts.ibmPlexSans(
                        fontSize: 23,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    _buildField("Код доступа", snapshot.data!.accessCode),
                    _buildField("Возраст", snapshot.data!.age.toString()),
                    _buildField("Диагноз", snapshot.data!.diagnosis),
                    _buildField("Профиль", snapshot.data!.med_profile),
                    Card(
                      surfaceTintColor: Colors.white,
                      margin: EdgeInsets.symmetric(vertical: 7),
                      elevation: 10,
                      color: Colors.white, // Устанавливаем белый цвет фона
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        side: BorderSide(
                          width: 1,
                          color: Colors.grey,
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Форма \"Утро\"",
                              style: GoogleFonts.ibmPlexSans(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              "Результаты самообследования пациента спустя 24 часа после операции",
                              style: GoogleFonts.ibmPlexSans(
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                                letterSpacing: 0,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        PatientFormForStaffPage(
                                      patientId: snapshot.data!.id,
                                      someMap: snapshot.data!.morningForm,
                                    ),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  backgroundColor:
                                      snapshot.data!.morningForm == null
                                          ? Colors.grey
                                          : Color.fromARGB(255, 0, 60, 210)),
                              child: Text(
                                "Посмотреть",
                                style: GoogleFonts.ibmPlexSans(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 0,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Card(
                      surfaceTintColor: Colors.white,
                      margin: EdgeInsets.symmetric(vertical: 7),
                      elevation: 10,
                      color: Colors.white, // Устанавливаем белый цвет фона
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        side: BorderSide(
                          width: 1,
                          color: Colors.grey,
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Форма \"Вечер\"",
                              style: GoogleFonts.ibmPlexSans(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              "Результаты самообследования пациента спустя 12 часов после операции",
                              style: GoogleFonts.ibmPlexSans(
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                                letterSpacing: 0,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        PatientFormForStaffPage(
                                      patientId: snapshot.data!.id,
                                      someMap: snapshot.data!.eveningForm,
                                    ),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  backgroundColor:
                                      snapshot.data!.morningForm == null
                                          ? Colors.grey
                                          : Color.fromARGB(255, 0, 60, 210)),
                              child: Text(
                                "Посмотреть",
                                style: GoogleFonts.ibmPlexSans(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 0,
                                  color: Colors.white,
                                ),
                              ),
                            )
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
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }

  Widget _buildField(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          enabled: false,
          style: GoogleFonts.ibmPlexSans(
            fontSize: 17,
            fontWeight: FontWeight.w700,
            letterSpacing: 0,
            color: Colors.black,
            height: 1,
          ),
          initialValue: value,
          decoration: InputDecoration(
            border: UnderlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(vertical: 2),
          ),
        ),
        Text(
          label,
          style: GoogleFonts.ibmPlexSans(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            letterSpacing: 0,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 15),
      ],
    );
  }
}
