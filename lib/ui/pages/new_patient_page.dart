import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NewPatientPage extends StatefulWidget {
  const NewPatientPage({Key? key}) : super(key: key);

  @override
  State<NewPatientPage> createState() => _NewPatientPageState();
}

class _NewPatientPageState extends State<NewPatientPage> {
  String length = '';
  List<String> medicalProfiles = [];

  @override
  void initState() {
    super.initState();
    getLength();
    fetchMedicalProfiles();
  }

  Future<void> getLength() async {
    int count = await FirebaseFirestore.instance
        .collection('patients')
        .get()
        .then((querySnapshot) => querySnapshot.size);

    setState(() {
      length = count.toString();
    });
  }

  Future<void> fetchMedicalProfiles() async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await FirebaseFirestore.instance.collection('med_profiles').get();

    setState(() {
      medicalProfiles =
          snapshot.docs.map((doc) => doc['title'] as String).toList();
    });
  }

  String selectedDate = ''; // Для хранения выбранной даты

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Column(children: [Text("Регистрация"), Text("5 полей")]),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Text("№1 Профиль пациента"),
            ListView.builder(
              shrinkWrap: true,
              itemCount: medicalProfiles.length,
              itemBuilder: (context, index) {
                return CheckboxListTile(
                  title: Text(medicalProfiles[index]),
                  value: false,
                  onChanged: (newValue) {},
                );
              },
            ),
            Text("№2 Диагноз пациента"),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Диагноз',
                ),
              ),
            ),
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
                  child: Text(selectedDate),
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
