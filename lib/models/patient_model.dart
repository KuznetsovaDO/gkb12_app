import 'package:cloud_firestore/cloud_firestore.dart';

class PatientModel {
  final String? id;
  final String accessCode;
  final String med_profile;
  final String diagnosis;

  PatientModel(
      {this.id,
      required this.accessCode,
      required this.med_profile,
      required this.diagnosis});

  toJson() {
    return {"id": id, "med_profile": med_profile, "diagnosis": diagnosis};
  }

  factory PatientModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data();
    return PatientModel(
        accessCode: data!["access_code"],
        med_profile: data["med_profile"],
        diagnosis: data["diagnosis"]);
  }
}
