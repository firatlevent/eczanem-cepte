class MuhasebeData {
  String id;
  String ilacadi;
  String tutar;
  String adet;
  String neYapildi;
  MuhasebeData({
    this.id,
    this.ilacadi,
    this.tutar,
    this.adet,
    this.neYapildi,
  });
  factory MuhasebeData.fromJson(Map<String, dynamic> json) {
    return MuhasebeData(
      id: json['id'] as String,
      ilacadi: json['ilacadi'] as String,
      tutar: json['tutar'] as String,
      adet: json['adet'] as String,
      neYapildi: json['neYapildi'] as String,
    );
  }
}
