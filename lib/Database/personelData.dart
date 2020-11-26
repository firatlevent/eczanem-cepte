class PersonelData {
  String id;
  String ad;
  String soyad;
  String tc;
  String adress;
  String telefon;
  String maas;
  PersonelData({
    this.id,
    this.ad,
    this.soyad,
    this.tc,
    this.adress,
    this.telefon,
    this.maas,
  });
  factory PersonelData.fromJson(Map<String, dynamic> json) {
    return PersonelData(
      id: json['id'] as String,
      ad: json['ad'] as String,
      soyad: json['soyad'] as String,
      tc: json['tc'] as String,
      adress: json['adress'] as String,
      telefon: json['telefon'] as String,
      maas: json['maas'] as String,
    );
  }
}
