import 'package:bus_online/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController repeatPasswordController = TextEditingController();
	
  final passwordVisible = false.obs;
  final repeatPasswordVisible = false.obs;

	AuthService auth = AuthService();

  Future<void> register() async {
    final res = await auth.signupWithSupabase(
			nameController.text,
      emailController.text,
      passwordController.text,
    );

    if (res) {
		  emailController.clear();
		  passwordController.clear();
			nameController.clear();
			repeatPasswordController.clear();
      Get.offNamed('/login');
    }
  }

	String? nameValidator(String value) {
		if(GetUtils.isNullOrBlank(value)!) {
		  return "Thông tin không thể để trống";
		}
		return null;
	}

	String? emailValidator(String value) {
		if(GetUtils.isNullOrBlank(value)!) {
		  return "Thông tin không thể để trống";
		}
		if (GetUtils.isEmail(value)) {
		  return "Email định dạng không hợp lệ";
		}
		return null;
	}

	String? passwordValidator(String value) {
		if (GetUtils.isNullOrBlank(value)!) {
		  return "Thông tin không thể để trống";
		}
		if (GetUtils.isLengthLessThan(value, 6)) {
			return "Mật khẩu phải ít nhất 6 ký tự";
		}
		return null;
	}

	String? repeatPasswordValidator(String value) {
		if (GetUtils.isNullOrBlank(value)!) {
		  return "Thông tin không thể để trống";
		}
		if(value == emailController.text) {
      return "Mật khẩu không trùng khớp";
		}
		return null;
	}
}
