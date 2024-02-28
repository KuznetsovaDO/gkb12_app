import 'dart:html';
import 'package:get/get.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gkb12_app/models/patient_model.dart';

class PatientRepository extends GetxController {
  static PatientRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;
  Future<PatientModel> getPatientDetails(String accessCode) async {
    final snapshot = await _db.collection("patients").get();
    final patientData =
        snapshot.docs.map((e) => PatientModel.fromSnapshot(e)).single;
    return patientData;
  }

  Future<List<PatientModel>> allPatients(String accessCode) async {
    final snapshot = await _db.collection("patients").get();
    final patientData =
        snapshot.docs.map((e) => PatientModel.fromSnapshot(e)).toList();
    return patientData;
  }
}
