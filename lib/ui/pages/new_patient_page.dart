import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class NewPatientPage extends StatefulWidget {
  const NewPatientPage({Key? key}) : super(key: key);

  @override
  State<NewPatientPage> createState() => _NewPatientPageState();
}

class _NewPatientPageState extends State<NewPatientPage> {
  String? selectedProfile = '';
  List<String> profiles = [];
  String? selectedDiagnosis;
  List<String> diagnoses = ['Option 1', 'Option 2', 'Option 3'];
  TextEditingController noteController = TextEditingController();
  DateTime? selectedDate;

  @override
  void initState() {
    super.initState();

    fetchMedicalProfiles();
  }

  Future<void> fetchMedicalProfiles() async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await FirebaseFirestore.instance.collection('med_profiles').get();

    setState(() {
      profiles = snapshot.docs.map((doc) => doc['title'] as String).toList();
    });
  }

  void fetchDiagnoses(String? profile) {
    FirebaseFirestore.instance
        .collection('diagnoses')
        .where("profile", isEqualTo: profile)
        .get()
        .then((QuerySnapshot<Map<String, dynamic>> snapshot) {
      setState(() {
        diagnoses =
            snapshot.docs.map((doc) => doc['diagnosis'] as String).toList();
        selectedDiagnosis =
            null; // Сбрасываем выбранный диагноз при изменении профиля
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            "Регистрация",
            textAlign: TextAlign.left,
          ),
          Text(
            "5 полей",
            textAlign: TextAlign.left,
            style: GoogleFonts.ibmPlexSans(
                fontSize: 15,
                letterSpacing: 0,
                fontWeight: FontWeight.w400,
                color: Colors.grey[800]),
          )
        ]),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("№1 Профиль пациента"),
            Column(
              children: profiles
                  .map(
                    (option) => RadioListTile(
                      title: Text(option),
                      value: option,
                      groupValue: selectedProfile,
                      onChanged: (value) {
                        setState(() {
                          selectedProfile = value as String;
                          fetchDiagnoses(selectedProfile);
                        });
                      },
                    ),
                  )
                  .toList(),
            ),
            Text("№2 Диагноз пациента"),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey),
              ),
              child: DropdownButton<String>(
                isExpanded: true,
                value: selectedDiagnosis,
                onChanged: (String? value) {
                  setState(() {
                    selectedDiagnosis = value;
                  });
                },
                items: diagnoses.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 8),
                      child: Text(value),
                    ),
                  );
                }).toList(),
              ),
            ),
            SizedBox(height: 10),
            Text("Примечание"),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: TextField(
                  controller: noteController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Введите примечание',
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Text("№3 Номер ЭМК пациента"),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Номер карты',
                ),
              ),
            ),
            Text("Дата поступления пациента"),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: InkWell(
                onTap: () {},
                child: InputDecorator(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Выберите дату',
                  ),
                  child: Text("j"),
                ),
              ),
            ),
            Text("Возраст пациента"),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
