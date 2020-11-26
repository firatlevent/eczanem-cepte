class HastaData {
  String id;
  String ad;
  String soyad;
  String tc;
  String adress;
  String telefon;
  HastaData({
    this.id,
    this.ad,
    this.soyad,
    this.tc,
    this.adress,
    this.telefon,
  });
  factory HastaData.fromJson(Map<String, dynamic> json) {
    return HastaData(
      id: json['id'] as String,
      ad: json['ad'] as String,
      soyad: json['soyad'] as String,
      tc: json['tc'] as String,
      adress: json['adress'] as String,
      telefon: json['telefon'] as String,
    );
  }
}
