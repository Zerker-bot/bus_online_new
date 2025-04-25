import 'package:bus_online/pages/login.dart';
import 'package:bus_online/storage/user_storage.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:bus_online/env_key.dart';
import 'dart:convert';

import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final supabaseAuth = Supabase.instance.client.auth;
  final supabase = Supabase.instance.client;
  final UserStorage userStorage = UserStorage();

  Future<bool> loginWithSupabase(String email, String password) async {
    try {
      final AuthResponse res = await supabaseAuth.signInWithPassword(
        email: email,
        password: password,
      );
      var user = res.user;
      if (user != null) {
        Get.snackbar('Login success', "Đăng nhập thành công");
        PostgrestList r = await supabase.from("profiles").select().eq("id", user.id);
        userStorage.setUser(name: r[0]['name'] as String, role: r[0]['role'] as String);
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
      final AuthResponse res = await supabaseAuth.signUp(
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
  Future logoutWithSupabase() async {
    try {
        await supabaseAuth.signOut();
        userStorage.removeUser();
        Get.offAll(const LoginPage());
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
    final String role = getRole();
    return role == 'driver';
  }

  User? getUser()  {
    return supabaseAuth.currentUser;
  }

  String getUserId()  {
    return supabaseAuth.currentUser?.id ?? "";
  }

  String getName() {
  return userStorage.getName();
  }

  String getRole() {
    return userStorage.getRole();
  }
}
