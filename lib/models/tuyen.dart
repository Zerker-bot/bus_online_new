class Tuyen {
  final String maTuyen;
  final String tenTuyen;

  Tuyen({required this.maTuyen, required this.tenTuyen});

  factory Tuyen.fromJson(Map<String, dynamic> json) {
    return Tuyen(
			maTuyen: json['ma_tuyen'] as String, 
			tenTuyen: json['ten_tuyen'] as String)
    ;
  }
}
