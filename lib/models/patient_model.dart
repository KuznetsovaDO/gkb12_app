import 'package:cloud_firestore/cloud_firestore.dart';

class PatientModel {
  final String? id;
  final String accessCode;
  final String med_profile;
  final String diagnosis;
  final String lastCondition;
  final String status;

  PatientModel(
      {this.id,
      required this.accessCode,
      required this.med_profile,
      required this.diagnosis,
      required this.lastCondition,
      required this.status});

  toJson() {
    return {
      "id": id,
      "access_code": accessCode,
      "med_profile": med_profile,
      "diagnosis": diagnosis,
      "lastCondition": lastCondition,
      "status": status
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
}
