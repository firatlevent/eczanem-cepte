class StokData {
  String id;
  String barkodno;
  String isim;
  String satisfiyati;
  String alisfiyati;
  String adet;
  StokData(
      {this.id,
      this.barkodno,
      this.isim,
      this.satisfiyati,
      this.alisfiyati,
      this.adet});
  factory StokData.fromJson(Map<String, dynamic> json) {
    return StokData(
      id: json['id'] as String,
      barkodno: json['barkodno'] as String,
      isim: json['isim'] as String,
      satisfiyati: json['satisfiyati'] as String,
      alisfiyati: json['alisfiyati'] as String,
      adet: json['adet'] as String,
    );
  }
}
