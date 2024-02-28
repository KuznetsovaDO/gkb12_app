import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';

class PatientModel {
  final String? id;
  final String accessCode;
  final String medProfile;
  final String diagnosis;

  PatientModel(
      {this.id,
      required this.accessCode,
      required this.medProfile,
      required this.diagnosis});

  toJson() {
    return {
      "id": id,
      "accessCode": accessCode,
      "medProfile": medProfile,
      "diagnosis": diagnosis
    };
  }

  factory PatientModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data();

    return PatientModel(
        accessCode: data!["accessCode"],
        medProfile: data["medProfile"],
        diagnosis: data["diagnosis"]);
  }
}
