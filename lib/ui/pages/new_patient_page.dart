import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gkb12_app/models/patient_model.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:intl/intl.dart';
import 'package:numberpicker/numberpicker.dart';

class NewPatientPage extends StatefulWidget {
  const NewPatientPage({Key? key}) : super(key: key);

  @override
  State<NewPatientPage> createState() => _NewPatientPageState();
}

class _NewPatientPageState extends State<NewPatientPage> {
  String? selectedProfile = null;
  List<String> profiles = [];
  String? selectedDiagnosis = null;
  List<String> diagnoses = [];
  String EMK = "";
  TextEditingController noteController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  DateTime? selectedDate;
  int age = 18;
  // Ваши переменные состояния для управления видимостью ошибок
  bool selectedProfileError = false;
  bool selectedDiagnosisError = false;
  bool selectedDateError = false;
  bool ageError = false;
  bool EMKerror = false;
  int count = 0;

  @override
  void initState() {
    super.initState();

    fetchMedicalProfiles();
    _ageController.text = age.toString();
  }

  TextEditingController _ageController = TextEditingController();

  void incrementAge() {
    setState(() {
      age++;
      _ageController.text = age.toString();
    });
  }

  void decrementAge() {
    if (age > 0) {
      setState(() {
        age--;
        _ageController.text = age.toString();
      });
    }
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
            Text("№1 Профиль пациента",
                style: GoogleFonts.ibmPlexSans(
                    fontSize: 18,
                    letterSpacing: 0,
                    fontWeight: FontWeight.w600,
                    color: selectedProfileError == true
                        ? Colors.red
                        : Colors.black)),
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
            Text("№2 Диагноз пациента",
                style: GoogleFonts.ibmPlexSans(
                    fontSize: 18,
                    letterSpacing: 0,
                    fontWeight: FontWeight.w600,
                    color: selectedDiagnosisError == true
                        ? Colors.red
                        : Colors.black)),
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
            Text("№3 Номер ЭМК пациента",
                style: GoogleFonts.ibmPlexSans(
                    fontSize: 18,
                    letterSpacing: 0,
                    fontWeight: FontWeight.w600,
                    color: EMKerror == true ? Colors.red : Colors.black)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    EMK = value;
                  });
                },
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Номер карты',
                ),
              ),
            ),
            Text("Дата поступления пациента",
                style: GoogleFonts.ibmPlexSans(
                    fontSize: 18,
                    letterSpacing: 0,
                    fontWeight: FontWeight.w600,
                    color:
                        selectedDateError == true ? Colors.red : Colors.black)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: InkWell(
                onTap: () {
                  DatePicker.showDatePicker(context,
                      showTitleActions: true,
                      minTime: DateTime(2023, 3, 5),
                      maxTime: DateTime.now(), onChanged: (date) {
                    print('change $date');
                  }, onConfirm: (date) {
                    print('confirm $date');
                    setState(() {
                      selectedDate = date;
                      dateController.text =
                          DateFormat('dd.MM.yyyy').format(date);
                      ;
                    });
                  }, currentTime: DateTime.now(), locale: LocaleType.ru);
                },
                child: InputDecorator(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Выберите дату',
                  ),
                  child: TextField(
                    controller: dateController,
                    enabled: false,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Text("Возраст пациента",
                style: GoogleFonts.ibmPlexSans(
                    fontSize: 18,
                    letterSpacing: 0,
                    fontWeight: FontWeight.w600,
                    color: ageError == true ? Colors.red : Colors.black)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey),
                ),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: decrementAge,
                      icon: Icon(Icons.remove),
                    ),
                    Expanded(
                      child: TextField(
                        controller: _ageController,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                        onChanged: (value) {
                          setState(() {
                            age = int.tryParse(value) ?? 0;
                          });
                        },
                      ),
                    ),
                    IconButton(
                      onPressed: incrementAge,
                      icon: Icon(Icons.add),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 20),
              child: OutlinedButton(
                onPressed: () {
                  _addPatient();
                },
                child: Row(
                  children: [
                    Text(
                      "Добавить",
                      style: GoogleFonts.ibmPlexSans(
                          fontSize: 18,
                          letterSpacing: 0,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                    Icon(Icons.add)
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _ageController.dispose();
    super.dispose();
  }

  void _addPatient() async {
    // Проверяем, все ли обязательные поля заполнены
    if (selectedProfile == null ||
        selectedDiagnosis == null ||
        selectedDate == null ||
        _ageController.text.isEmpty) {
      // Если какие-то поля не заполнены, выделяем их красным цветом
      setState(() {
        if (selectedProfile == null)
          selectedProfileError = true;
        else
          selectedProfileError = false;
        if (selectedDiagnosis == null)
          selectedDiagnosisError = true;
        else
          selectedDiagnosisError = false;
        if (selectedDate == null)
          selectedDateError = true;
        else
          selectedDateError = false;
        if (_ageController.text.isEmpty)
          ageError = true;
        else
          ageError = false;
        if (_ageController.text.isEmpty)
          ageError = true;
        else
          ageError = false;
        if (EMK == "")
          EMKerror = true;
        else
          EMKerror = false;
      });

      // Выводим диалоговое сообщение
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Ошибка"),
            content: Text("Заполните все обязательные поля."),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("OK"),
              ),
            ],
          );
        },
      );
      return;
    }

    // Если все обязательные поля заполнены, можно добавить пациента
    // Создаем экземпляр класса PatientModel
    PatientModel patient = PatientModel(
      med_profile: selectedProfile!,
      diagnosis: selectedDiagnosis!,
      status: 'Перед операцией',
      dateAdmission: Timestamp.fromDate(selectedDate!),
      diagnosisNote: noteController.text,
      EMKnumber: EMK,
      age: age,
    );

    try {
      // Преобразуем объект PatientModel в JSON
      Map<String, dynamic> patientJson = patient.toJson();

      QuerySnapshot<Map<String, dynamic>> snapshot =
          await FirebaseFirestore.instance.collection('med_profiles').get();
      String id = (snapshot.docs.length + 1).toString();
      // Добавляем JSON-данные в коллекцию patients Firestore
      final DocumentReference docRef =
          FirebaseFirestore.instance.collection('patients').doc(id);

// Добавление документа с указанным идентификатором
      await docRef.set(patientJson);

      // Очищаем поля ввода после успешного добавления пациента
      setState(() {
        selectedProfile = null;
        selectedDiagnosis = null;
        noteController.clear();
        dateController.clear();
        selectedDate = null;
        _ageController.text = '18';
        age = 18;
        EMK = '';
        EMKerror = false;
      });

      // Выводим сообщение об успешном добавлении пациента
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Успех"),
            content: Text("Пациент успешно добавлен."),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("OK"),
              ),
            ],
          );
        },
      );
    } catch (e) {
      // В случае ошибки выводим сообщение об ошибке
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Ошибка"),
            content: Text(
                "Не удалось добавить пациента. Пожалуйста, попробуйте снова."),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("OK"),
              ),
            ],
          );
        },
      );
    }
  }
}
