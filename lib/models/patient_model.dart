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
  Map<String, String>? eveningForm; // Необязательное поле eveningForm

  // Конструктор класса
  PatientModel({
    this.id,
    required this.med_profile,
    required this.diagnosis,
    this.lastCondition = "1",
    required this.status,
    this.accessCode = "",
    this.eveningForm, // Опциональный параметр
    Timestamp? dateAdmission,
    this.diagnosisNote = "",
    this.EMKnumber = "",
    this.age = 18,
  }) : dateAdmission = dateAdmission ?? Timestamp.fromDate(DateTime.now());

  // Метод для сериализации объекта в формат JSON
  Map<String, dynamic> toJson() {
    return {
      "access_code": accessCode,
      "med_profile": med_profile,
      "diagnosis": diagnosis,
      "lastCondition": lastCondition,
      "status": status,
      "dateAdmission": dateAdmission,
      "diagnosisNote": diagnosisNote,
      "EMKnumber": EMKnumber,
      "age": age,
      "eveningForm":
          eveningForm, // Включаем eveningForm в JSON, если он существует
    };
  }

  // Фабричный метод для создания объекта из снимка документа Firestore
  factory PatientModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data();
    final eveningFormData = data?['eveningForm'];

    // Проверяем, существует ли eveningForm и содержит ли элементы
    final Map<String, String>? eveningForm =
        (eveningFormData is Map && eveningFormData.isNotEmpty)
            ? eveningFormData.cast<String, String>()
            : null;

    return PatientModel(
      id: document.id,
      accessCode: data?["access_code"] ?? "",
      med_profile: data?["med_profile"] ?? "",
      diagnosis: data?["diagnosis"] ?? "",
      lastCondition: data?['lastCondition'] ?? "1",
      status: data?['status'] ?? "",
      eveningForm: eveningForm,
    );
  }

  // Метод для генерации случайного accessCode
  static String generateAccessCode() {
    List<String> characters = [];
    for (int i = 0; i < 10; i++) {
      characters.add(i.toString());
    }
    for (int char = 65; char <= 90; char++) {
      characters.add(String.fromCharCode(char));
    }
    String accessCode = '';
    Random random = Random();
    for (int i = 0; i < 4; i++) {
      accessCode += characters[random.nextInt(characters.length)];
    }
    return accessCode;
  }
}
