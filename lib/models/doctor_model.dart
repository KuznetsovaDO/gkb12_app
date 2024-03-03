import 'package:cloud_firestore/cloud_firestore.dart';

class DoctorModel {
  final String? id;
  final String access_code;
  final String med_profile;
  final String lastname;
  final String name;
  final String patronymic;

  DoctorModel({
    this.id,
    required this.access_code,
    required this.med_profile,
    required this.lastname,
    required this.name,
    required this.patronymic,
  });

  toJson() {
    return {
      "id": id,
      "access_code": access_code,
      "med_profile": med_profile,
      "lastname": lastname,
      "name": name,
      "patronymic": patronymic
    };
  }

  factory DoctorModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data();
    return DoctorModel(
        access_code: data!["access_code"],
        med_profile: data["med_profile"],
        lastname: data['lastname'],
        name: data["name"],
        patronymic: data["patronymic"]);
  }
}
