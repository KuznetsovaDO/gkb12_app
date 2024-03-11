import 'package:get/get.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gkb12_app/models/patient_model.dart';

class PatientRepository extends GetxController {
  static PatientRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;
  Future<PatientModel> getPatientDetails(String accessCode) async {
    final snapshot = await _db
        .collection('patients')
        .where('access_code', isEqualTo: accessCode)
        .get();
    final patientData =
        snapshot.docs.map((e) => PatientModel.fromSnapshot(e)).single;
    return patientData;
  }

  Future<List<PatientModel>> allPatients() async {
    final snapshot = await _db.collection("patients").get();
    final patientData =
        snapshot.docs.map((e) => PatientModel.fromSnapshot(e)).toList();
    return patientData;
  }

  Future<List<PatientModel>> allPatientsFromProfileBeforeDischarged(
      String profile) async {
    final snapshot = await _db
        .collection("patients")
        .where("med_profile", isEqualTo: profile)
        .where("status", whereIn: ["перед операцией", 'после операции']).get();
    final patientData =
        snapshot.docs.map((e) => PatientModel.fromSnapshot(e)).toList();
    return patientData;
  }

  Future<List<PatientModel>> allPatientsFromProfileAfterDischarged(
      String profile) async {
    final snapshot = await _db
        .collection("patients")
        .where("status", whereNotIn: ["перед операцией", 'после операции'])
        .where("med_profile", isEqualTo: profile)
        .get();
    final patientData =
        snapshot.docs.map((e) => PatientModel.fromSnapshot(e)).toList();
    return patientData;
  }

  Future<List<PatientModel>> getPatientsBeforeDischarged() async {
    final snapshot = await _db
        .collection("patients")
        .where("status", whereIn: ["перед операцией", 'после операции']).get();
    final patientData =
        snapshot.docs.map((e) => PatientModel.fromSnapshot(e)).toList();
    return patientData;
  }

  Future<List<PatientModel>> getPatientsAfterDischarged() async {
    final snapshot = await _db.collection("patients").where("status",
        whereNotIn: ["перед операцией", 'после операции']).get();
    final patientData =
        snapshot.docs.map((e) => PatientModel.fromSnapshot(e)).toList();
    return patientData;
  }

  Future<bool> checkPatient(String docID) async {
    try {
      final querySnapshot = await _db
          .collection('patients')
          .where("access_code", isEqualTo: docID)
          .get();
      if (querySnapshot.size != 0) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
