import 'package:bus_online/models/don_tra.dart';
import 'package:bus_online/models/tram.dart';
import 'package:bus_online/services/auth_service.dart';
import 'package:bus_online/services/tuyen_service.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CustomerService {
  final supabase = Supabase.instance.client;
  final authService = AuthService();
  final tuyenService = TuyenService();

  Future<List<DonTra>?> getDonTra() async {
    try {
      final user = authService.getUserId();
      // if(user == null) {
      //   Get.snackbar('Lỗi', "Không tìm thấy user");
      //   return null;
      // }
      PostgrestList res = await supabase.from("bang_don_tra").select('''
        *,
        tram_di:ma_tram_di (*),
        tram_den:ma_tram_dich (*),
        chuyen_xe(*)
        ''')
      .isFilter("trang_thai_thanh_toan", null)
      .eq("ma_khach_hang", user);

      final List<DonTra> listOfDonTra = res.map((e) => DonTra.fromJson(e)).toList();
      return listOfDonTra;
    } catch (e) {
      Get.snackbar('Lỗi', e.toString());
      return null;
    }
  }

  Future<bool> postDonTra({
    required String maTramDi,
    required String maTramDen,
    required String maTuyen,
    required String maChuyen,
    required int soLuong,
    required int tienPhi,
    required String chieu,
  }) async {
    try {
      await supabase.from("bang_don_tra").insert({
        "ten_khach_hang": authService.getName(),
        "ma_khach_hang": authService.getUserId(),
        "ma_tram_di": maTramDi,
        "ma_tram_dich": maTramDen,
        "ma_chuyen": maChuyen,
        "hoan_thanh": false,
        "trang_thai_thanh_toan": null,
        "tien_phi": tienPhi,
        "so_luong": soLuong,
        "chieu": chieu
      });
      return true;
    } catch (e) {
      Get.snackbar('Lỗi', e.toString());
      return false;
    }
  }

  Future<int> tinhTien(
      {required String? maTramDi,
      required String? maTramDen,
      required String? maTuyen,
      required int soLuong}) async {
    try {

      if(maTuyen == null)
      {
        return 0;
      }
      List<Tram>? listOfTram = await tuyenService.getTramFromTuyen(maTuyen);
      if(listOfTram == null)
      {
        return 0;
      }
      
      var total = 0;
      var thuTuTramDi = int.parse(listOfTram.singleWhere((e) { return e.maTram == maTramDi; }).thuTuTram);
      var thuTuTramDen = int.parse(listOfTram.singleWhere((e) { return e.maTram == maTramDen; }).thuTuTram);

      if(thuTuTramDi > thuTuTramDen)
      {
        var temp = thuTuTramDen;
        thuTuTramDen = thuTuTramDi;
        thuTuTramDi = temp;
      }

      for(var tram in listOfTram)
      {
        if(int.parse(tram.thuTuTram) >= thuTuTramDi && int.parse(tram.thuTuTram) < thuTuTramDen)
        {
           total += tram.tienPhi;
        }
      }
      
      total = total*soLuong;
      return total;
    } catch (e) {
      Get.snackbar('Lỗi', e.toString());
      return 0;
    }
  }

  Future<void> suDungVe({required int id, required String maChuyen}) async {
    // try {
    //   Map<String, dynamic> body = {
    //     "id": id,
    //     "maChuyen": maChuyen,
    //   };
    //   http.Response res = await fetch.patch(
    //       endPoint:
    //           ApiEndPoints.customerEndPoints.bangDonTra,
		// 		  body: body,
    //       auth: true);
    //
		// 	final json = jsonDecode(res.body);
    //   if (res.statusCode != 200) {
    //     Get.snackbar("Lỗi",json['message']);
		// 		return;
		// 	}
		// 	Get.snackbar("Thành công",json['message']);
    // } catch (e) {
    //   Get.snackbar('Lỗi', e.toString());
    // }
  }
}
