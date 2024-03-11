import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegistratorsRepository extends GetxController {
  static RegistratorsRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;
  Future<String> getRegistratorsId(String access_code) async {
    final snapshot = await _db
        .collection('registrators')
        .where('access_code', isEqualTo: access_code)
        .get();
    return snapshot.docs.first.id;
  }

  Future<bool> checkRegistrator(String access_code) async {
    try {
      final querySnapshot = await _db
          .collection('registrators')
          .where('access_code', isEqualTo: access_code)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      // If any error
      return false;
    }
  }
}
