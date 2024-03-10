import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gkb12_app/models/patient_model.dart';
import 'package:gkb12_app/repository/patient_repository.dart';

class PatientController extends GetxController {
  static PatientController get instance => Get.find();
  final _patientRepo = Get.put(PatientRepository());

  getPatientData(String access_code) {
    return _patientRepo.getPatientDetails(access_code);
  }

  Future<List<PatientModel>> getAllPatient() async {
    return await _patientRepo.allPatients();
  }

  Future<bool> checkPatient(String docID) async {
    return await _patientRepo.checkPatient(docID);
  }

  Future<List<PatientModel>> allPatientsFromProfile(String profile) async {
    return _patientRepo.allPatientsFromProfile(profile);
  }

  Future<List<PatientModel>> getPatientsBeforeDischarged() async {
    return _patientRepo.getPatientsBeforeDischarged();
  }

  Future<List<PatientModel>> getPatientsAfterDischarged() async {
    return _patientRepo.getPatientsAfterDischarged();
  }
}
