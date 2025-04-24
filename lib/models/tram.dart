class Tram {
  final String maTram;
  final String tenTram;
  final String thuTuTram;
  int soNguoiDen;
  final int tienPhi;

  Tram({
    required this.maTram,
    required this.tenTram,
    required this.thuTuTram,
    required this.tienPhi,
    required this.soNguoiDen,
  });

  factory Tram.fromJson(Map<String, dynamic> json) {
    return Tram(
      maTram: json['ma_tram'] as String,
      tenTram: json['tram']['ten_tram'] as String,
      thuTuTram: json['thu_tu_tram'] ?? "",
      tienPhi: json['tien_phi'] != null ? json['tien_phi'] as int : 0,
      soNguoiDen: 0,
    );
  }

  void setSoNguoiDen(int num) {
    soNguoiDen = num;
  }

  int getSoNguoiDen(int num) {
    return soNguoiDen;
  }
}
