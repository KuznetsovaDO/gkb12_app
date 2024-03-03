import 'package:get/get.dart';
import 'package:gkb12_app/repository/registrators_repository.dart';

class RegistratorsController extends GetxController {
  static RegistratorsController get instance => Get.find();
  final _registratorsRepo = Get.put(RegistratorsRepository());

  Future<bool> checkRegistrator(String docID) async {
    return await _registratorsRepo.checkRegistrator(docID);
  }
}
