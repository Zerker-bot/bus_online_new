import 'package:bus_online/models/bang_don_tra.dart';
import 'package:bus_online/models/chuyen_xe.dart';
import 'package:bus_online/models/tram.dart';
import 'package:bus_online/services/tuyen_service.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DashboardController extends GetxController {
  final List<String> danhSachThongBao = <String>[].obs;
  final supabase = Supabase.instance.client;

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> quetVe(String id) async {
    // final data = await supabase
    //     .from('bang_don_tra')
    //     .update({ 'trang_thai_thanh_toan': 'done' })
    //     .eq('id', id).select();
    try {
      final data = await supabase
          .from('bang_don_tra')
          .update({'trang_thai_thanh_toan': 'done'})
          .eq('id', id)
          .select('''
      *,
      tram_di:ma_tram_di (*),  
      tram_den:ma_tram_dich (*) 
    ''');
      var donTra = bang_don_tra.fromJson(data[0]);
      danhSachThongBao.add("""
  Khách hàng: ${donTra.tenKhachHang} 
  Giá vé: ${donTra.tienPhi}
  Chuyến: ${donTra.maChuyen} 
  Trạm đi:${donTra.tenTramDi}
  Trạm đến: ${donTra.tenTramDen}""");
    }
    catch (e) {
      Get.snackbar("Lỗi", "Đã xảy ra lỗi: ${e.toString()}");
    }
    Get.offNamed("/dashboard");

}
}
