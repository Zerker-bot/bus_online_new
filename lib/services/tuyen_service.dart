import 'dart:convert';
import 'package:bus_online/env_key.dart';
import 'package:bus_online/models/chuyen_xe.dart';
import 'package:bus_online/models/tram.dart';
import 'package:bus_online/models/tuyen.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:supabase_flutter/supabase_flutter.dart';

class TuyenService {
  final supabase = Supabase.instance.client;


  Future<List<Tuyen>?> getAllTuyen() async {
    try {
      PostgrestList res = await supabase.from("tuyen").select();
      final List<Tuyen> listOfTuyen =
          res.map((e) => Tuyen.fromJson(e)).toList();
      return listOfTuyen;
    } catch (e) {
      Get.snackbar('Lỗi', e.toString());
      return null;
    }
  }

  Future<List<Tram>?> getTramFromTuyen(String? maTuyen) async {
    try {
      if (maTuyen == null) return null;
      // PostgrestList res = await supabase.from("tuyen").select("*, chi_tiet_tuyen(*, tram(*))").eq("ma_tuyen", maTuyen);

      PostgrestList res = await supabase.from("chi_tiet_tuyen")
      .select("*, tram(*)")
      .eq("ma_tuyen", maTuyen)
      .order("thu_tu_tram", ascending: true);

      // final List list = res[0]['chi_tiet_tuyen'];
      final List<Tram> listOfTram = res.map((e) => Tram.fromJson(e)).toList();
      return listOfTram;
    } catch (e) {
      Get.snackbar('Lỗi', e.toString());
      return null;
    }
  }

  Future<ChuyenXe?> getChuyenXe(String maChuyen) async {
    // try {
    //   http.Response res = await fetch.get(
    //     endPoint: '${ApiEndPoints.chuyenXeEndPoints.chuyenXe}/$maChuyen',
    //     auth: true,
    //   );
    //   if (res.statusCode != 200) return null;
    //
    //   final data = jsonDecode(res.body)['data'];
    //   final ChuyenXe chuyenXe = ChuyenXe.fromJson(data);
    //   return chuyenXe;
    // } catch (e) {
    //   Get.snackbar('Lỗi', e.toString());
    //   return null;
    // }
  }

  Future<List<ChuyenXe>?> getTatCaChuyenXe(String? maTuyen) async {
    try {
      if (maTuyen == null) return null;
      PostgrestList res = await supabase.from("tuyen").select("*, chuyen_xe(*)").eq("ma_tuyen", maTuyen);

      final List list = res[0]['chuyen_xe'];
      final List<ChuyenXe> listOfTram =
          list.map((e) => ChuyenXe.fromJson(e)).toList();
      return listOfTram;
    } catch (e) {
      Get.snackbar('Lỗi', e.toString());
      return null;
    }
  }
}
