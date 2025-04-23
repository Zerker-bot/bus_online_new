import 'package:bus_online/fetch/fetch_base.dart';
import 'package:bus_online/pages/login.dart';
import 'package:bus_online/storage/user_storage.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:bus_online/env_key.dart';
import 'dart:convert';

import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final supabase = Supabase.instance.client.auth;
  final UserStorage _storage = UserStorage();
  final FetchBase fetch = FetchBase();

  Future<bool> loginWithSupabase(String email, String password) async {
    try {
      final AuthResponse res = await supabase.signInWithPassword(
        email: email,
        password: password,
      );
      if (res.user != null) {
        Get.snackbar('Login success', "Đăng nhập thành công");
        return true;
      } else {
        Get.snackbar('Login fail', "Không tìm thấy User");
        return false;
      }
    } catch (e) {
      if (e is AuthException) {
        Get.snackbar('Login fail', e.message);
      }
      return false;
    }
  }

  Future<bool> signupWithSupabase(String name, String email, String password) async {
    try {
      final AuthResponse res = await supabase.signUp(
        email: email,
        password: password,
        data: {
          "name": name,
          "role": "customer",
        },
      );
      if (res.user != null) {
        Get.snackbar('Sign up success', "Đăng kí thành công");
        return true;
      } else {
        Get.snackbar('Sign up fail', "Không tìm thấy User");
        return false;
      }
    } catch (e) {
      if (e is AuthException) {
        Get.snackbar('Sign up fail', e.message);
      }
      return false;
    }
  }

  Future loginWithEmail(String email, String password, String role) async {
    try {
      Map<String, String> body = {
        "email": email,
        "password": password,
        "role": role,
      };

      http.Response response = await fetch.post(
        endPoint: ApiEndPoints.authEndPoints.login,
        body: body,
      );

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        if (json['status']) {
          Get.snackbar('Xác thực', 'Đăng nhập thành công');
          return json;
        } else {
          throw jsonDecode(response.body)['message'] ?? "Unknow Error Occured";
        }
      } else {
        throw jsonDecode(response.body)['message'] ?? "Unknow Error Occured";
      }
    } catch (e) {
      Get.snackbar('Xác thực', 'Đăng nhập thất bại');
    }
  }

  Future registerWithEmail(String name, String email, String password) async {
    try {
      Map<String, String> body = {
        "name": name,
        "email": email,
        "password": password,
      };

      http.Response response = await fetch.post(
        endPoint: ApiEndPoints.authEndPoints.register,
        body: body,
      );

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        if (json['status']) {
          Get.snackbar('Xác thực', 'Đăng kí thành công');
          return json;
        } else {
          throw jsonDecode(response.body)['message'] ?? "Unknow Error Occured";
        }
      } else {
        throw jsonDecode(response.body)['message'] ?? "Unknow Error Occured";
      }
    } catch (e) {
      Get.snackbar('Xác thực', 'Đăng kí thất bại');
    }
  }

  Future logoutWithSupabase() async {
    try {
        await supabase.signOut();
        Get.offAll(const LoginPage());
    } catch (e) {
      Get.snackbar('Lỗi', 'Hệ thống đang gặp lỗi');
    }
  }
  Future logout() async {
    try {
      http.Response response = await fetch.post(
        endPoint: ApiEndPoints.authEndPoints.logout,
        auth: true,
      );

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        if (json['status']) {
          _storage.removeUser();
          Get.offAll(const LoginPage());
        } else {
          throw jsonDecode(response.body)['message'] ?? "Unknow Error Occured";
        }
      } else {
        throw jsonDecode(response.body)['message'] ?? "Unknow Error Occured";
      }
    } catch (e) {
      Get.snackbar('Lỗi', 'Hệ thống đang gặp lỗi');
    }
  }

  bool isLogin() {
    // final String token = _storage.getToken();
    // return token != "";
    final currentUser = Supabase.instance.client.auth.currentUser;
    return currentUser != null;
  }

  bool isDriver() {
    final String role = _storage.getRole();
    return role == 'driver';
  }

  User? getUser()  {
    return supabase.currentUser;
  }

  String getName() {
    final user = getUser();
    if ( user == null ) return "";
    final metadata = user.userMetadata;
    if ( metadata == null ) return "";
    return metadata["name"];
  }

  String getRole() {
    final user = getUser();
    if ( user == null ) return "";
    final metadata = user.userMetadata;
    if ( metadata == null ) return "";
    return metadata["role"];
  }
}
