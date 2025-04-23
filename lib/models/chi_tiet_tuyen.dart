class ChiTietTuyen {
  final String id;
  final String? maTuyen;
  final String thuTuTram;
  final String maTram;
  final int tienPhi;

  ChiTietTuyen({
    required this.id,
    required this.maTuyen,
    required this.thuTuTram,
    required this.maTram,
    required this.tienPhi,
  });

  factory ChiTietTuyen.fromJson(Map<String, dynamic> json) {
    return ChiTietTuyen(
      id: json['id'] as String,
      maTuyen: json['ma_tuyen'] ?? "",
      thuTuTram: json['thu_tu_tram'] as String,
      maTram: json['ma_tram'] as String,
      tienPhi: json['tien_phi'] as int,
    );
  }
}
