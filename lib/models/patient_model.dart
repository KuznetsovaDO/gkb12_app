import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math';

class PatientModel {
  final String? id;
  String accessCode;
  final String med_profile;
  final String diagnosis;
  final String lastCondition;
  final String status;
  final Timestamp dateAdmission;
  String diagnosisNote;
  String EMKnumber;
  int age;
  PatientModel({
    this.id,
    required this.med_profile,
    required this.diagnosis,
    this.lastCondition = "1",
    required this.status,
    this.accessCode = "",
    Timestamp? dateAdmission,
    this.diagnosisNote = "",
    this.EMKnumber = "",
    this.age = 18,
  }) : dateAdmission = dateAdmission ?? Timestamp.fromDate(DateTime.now());

  toJson() {
    return {
      "access_code": accessCode,
      "med_profile": med_profile,
      "diagnosis": diagnosis,
      "lastCondition": lastCondition,
      "status": status,
      "dateAdmission": dateAdmission,
      "diagnosisNote": diagnosisNote,
      "EMKnumber": EMKnumber,
      "age": age
    };
  }

  factory PatientModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data();
    return PatientModel(
        id: document.id,
        accessCode: data!["access_code"],
        med_profile: data["med_profile"],
        diagnosis: data["diagnosis"],
        lastCondition: data['lastCondition'],
        status: data['status']);
  }
  static String generateAccessCode() {
    // Создаем список допустимых символов
    List<String> characters = [];
    for (int i = 0; i < 10; i++) {
      characters.add(i.toString()); // Добавляем цифры от 0 до 9
    }
    for (int char = 65; char <= 90; char++) {
      // Добавляем заглавные буквы от A до Z
      characters.add(String.fromCharCode(char));
    }

    // Генерируем accessCode из случайных символов
    String accessCode = '';
    Random random = Random();
    for (int i = 0; i < 4; i++) {
      accessCode += characters[random.nextInt(characters.length)];
    }
    accessCode = accessCode;
    return accessCode;
  }
}
