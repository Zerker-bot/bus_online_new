import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class UserStorage {
  final GetStorage _storage = GetStorage();

  void setUser(
      {required String name, required String role}) {
    try {
      _storage.write('userName', name);
      _storage.write('userRole', role);
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  Map<String, String>? getUser() {
    try {
      var user = <String, String>{};
      user['userName'] = _storage.read('userName');
      user['userRole'] = _storage.read('userRole');
    } catch (e) {
      Get.snackbar('Error', e.toString());
      return null;
    }
  }
	String getName() {
		var name = _storage.read('userName');
		return name ?? "";
	}

	String getRole() {
		var role = _storage.read('userRole');
		return role ?? "";
	}

  String getMaChuyen() {
    return "";
  }



  void removeUser() {
    try {
      _storage.remove('userName');
      _storage.remove('userToken');
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }
}
