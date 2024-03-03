import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gkb12_app/models/doctor_model.dart';

class DoctorsRepository extends GetxController {
  static DoctorsRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  //получает данные конкретного врача по его access_code
  Future<DoctorModel> getDoctorsDetails(String accessCode) async {
    final snapshot = await _db
        .collection('doctors')
        .where('access_code', isEqualTo: accessCode)
        .get();
    final doctorData =
        snapshot.docs.map((e) => DoctorModel.fromSnapshot(e)).single;
    return doctorData;
  }

//получает список всех врачей
  Future<List<DoctorModel>> allDoctors() async {
    final snapshot = await _db.collection('doctors').get();
    final doctorsData =
        snapshot.docs.map((e) => DoctorModel.fromSnapshot(e)).toList();
    return doctorsData;
  }

  //получает список всех врачей определенного профиля
  Future<List<DoctorModel>> allProfileDoctors(String profile) async {
    final snapshot = await _db
        .collection('doctors')
        .where('med_profile', isEqualTo: profile)
        .get();
    final doctorsData =
        snapshot.docs.map((e) => DoctorModel.fromSnapshot(e)).toList();
    return doctorsData;
  }

  //проверяет наличие доктора с access_code
  Future<bool> checkEmployee(String access_code) async {
    try {
      final querySnapshot = await _db
          .collection('doctors')
          .where('access_code', isEqualTo: access_code)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
