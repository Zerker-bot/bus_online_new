import 'package:bus_online/models/chuyen_xe.dart';

class DonTra {
	final String id;
	final String maChuyen;
	final String maKhachHang;
	final String maTramDi;
	final String tenTramDi;
	final String maTramDen;
	final String tenTramDen;
	final bool hoanThanh;
	final String? trangThaiThanhToan;
	final String tienPhi;
	final String soLuong;
	final String createdAt;
	final String updatedAt;
	final ChuyenXe? chuyenXe;
	final String tenHanhKhach;
	final String chieu;

	DonTra({
     required this.id,
     required this.maChuyen,
     required this.maKhachHang,
     required this.maTramDi,
     required this.maTramDen,
     required this.hoanThanh,
     required this.trangThaiThanhToan,
     required this.tienPhi,
		required this.tenTramDi,
		required this.tenTramDen,
		required this.soLuong,
		required this.createdAt,
		this.chuyenXe,
		required this.updatedAt,
		required this.tenHanhKhach,
		required this.chieu,
	});

 factory DonTra.fromJson(Map<String, dynamic> json) {
		final ChuyenXe chuyenXe = ChuyenXe(
			maChuyen: json['chuyen_xe']['ma_chuyen'] as String, 
			gioLuotDi: json['chuyen_xe']['luot_di'] as String,
			gioLuotVe: json['chuyen_xe']['luot_ve'] as String,
			maXe: json['chuyen_xe']['ma_xe'] as String,
		);
   return DonTra(
		id : json['id'].toString(),
		maChuyen: json['ma_chuyen'] as String,
		maKhachHang: json['ma_khach_hang'].toString(),
		maTramDi: json['ma_tram_di'] as String,
		tenTramDi: json['tram_di']['ten_tram'] as String,
		maTramDen: json['ma_tram_dich'] as String,
		tenTramDen: json['tram_den']['ten_tram'] as String,
		hoanThanh: json['hoan_thanh'],
		trangThaiThanhToan: json['trang_thai_thanh_toan'],
		tienPhi: json['tien_phi'] as String,
		soLuong : json['so_luong'].toString(),
		createdAt : json['created_at'] as String,
		updatedAt: json['updated_at'] as String,
		chuyenXe: chuyenXe,
		tenHanhKhach: "",
		chieu: json['chieu'] as String,
	);
	}

  
}
