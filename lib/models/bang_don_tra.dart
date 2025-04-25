class bang_don_tra{
  final int id;
  final String maChuyen;
  final String maKhachHang;
  final String maTramDi;
  final String maTramDich;
  final bool hoanThanh;
  final String trangThaiThanhToan;
  final String tienPhi;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int soLuong;
  final String chieu;
  final String tenKhachHang;
  final String? tenTramDi;
  final String? tenTramDen;

  bang_don_tra({
  required this.id,
  required this.maChuyen,
  required this.maKhachHang,
  required this.maTramDi,
  required this.maTramDich,
  required this.hoanThanh,
  required this.trangThaiThanhToan,
  required this.tienPhi,
  required this.createdAt,
  required this.updatedAt,
  required this.soLuong,
  required this.chieu,
  required this.tenKhachHang,
  this.tenTramDi,
    this.tenTramDen,
  });
  factory bang_don_tra.fromJson(Map<String, dynamic> json) {
    return bang_don_tra(
      id: json['id'] ,
      maChuyen: json['ma_chuyen'],
      maKhachHang: json['ma_khach_hang'],
      maTramDi: json['ma_tram_di'],
      maTramDich: json['ma_tram_dich'],
      hoanThanh: json['hoan_thanh'],
      trangThaiThanhToan: json['trang_thai_thanh_toan'],
      tienPhi: json['tien_phi'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      soLuong: json['so_luong'],
      chieu: json['chieu'],
      tenKhachHang: json['ten_khach_hang'],
      tenTramDi: json['tram_di'] != null ? json['tram_di']['ten_tram'] : null,
      tenTramDen: json['tram_den'] != null ? json['tram_den']['ten_tram'] : null,
    );
  }
}