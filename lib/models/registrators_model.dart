import 'package:cloud_firestore/cloud_firestore.dart';

class RegistratorModel {
  final String? id;
  final String access_code;

  RegistratorModel({
    this.id,
    required this.access_code,
  });

  toJson() {
    return {
      "id": id,
      "access_code": access_code,
    };
  }

  factory RegistratorModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data();
    return RegistratorModel(
      access_code: data!["access_code"],
    );
  }
}
