class Tram {
  final String maTram;
  final String tenTram;
  final String thuTuTram;
	int soNguoiDen;

  Tram({required this.maTram, required this.tenTram, required this.thuTuTram, required this.soNguoiDen});

  factory Tram.fromJson(Map<String, dynamic> json) {
    return Tram(
      maTram: json['ma_tram'] as String,
      tenTram: json['tram']['ten_tram'] as String,
      thuTuTram: json['thu_tu_tram'] ?? "",
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
