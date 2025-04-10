class ChuyenXe {
	final String maChuyen;
	final String? maTuyen;
	final String maXe;
	final String gioLuotDi;
	final String gioLuotVe;

	ChuyenXe({required this.maChuyen, required this.gioLuotDi, required this.gioLuotVe,required this.maXe, this.maTuyen});

 factory ChuyenXe.fromJson(Map<String, dynamic> json) {
   return ChuyenXe(
		maChuyen: json['ma_chuyen'] as String,
		maTuyen: json['chuyen']?['ma_tuyen'] ?? "",
		maXe: json['ma_xe'] as String,
		gioLuotDi: json['luot_di'] as String,
		gioLuotVe: json['luot_ve'] as String
	);
	}
  
}
