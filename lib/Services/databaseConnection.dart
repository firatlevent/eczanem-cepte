import 'package:http/http.dart' as http;
import 'package:eczane/Database/hastaData.dart';
import 'package:eczane/Database/muhasebeData.dart';
import 'package:eczane/Database/personelData.dart';
import 'dart:async';
import 'dart:convert';

import 'package:eczane/Database/stokData.dart';

class Services {
  static const ROOT = 'http://peyda.tech/app/database.php';

  static const _ILAC_STOK_GETIR_ACTION = 'ILAC_STOK_GETIR';
  static const _BUTUN_PERSONEL_GETIR_ACTION = 'BUTUN_PERSONEL_GETIR';
  static const _BUTUN_HASTA_GETIR_ACTION = 'BUTUN_HASTA_GETIR';
  static const _MUHASEBE_GETIR_ACTION = 'MUHASEBE_GETIR';

  static const _HASTA_EKLE_ACTION = 'HASTA_EKLE';
  static const _PERSONEL_EKLE_ACTION = 'PERSONEL_EKLE';
  static const _ILAC_KAYIT_ACTION = 'ILAC_KAYIT';
  static const _MUHASEBE_ILAC_SATIS_ACTION = 'MUHASEBE_ILAC_SATIS';

  static const _STOK_EKLE_ACTION = 'STOK_EKLE';
  static const _SATIS_YAP_ACTION = 'SATIS_YAP';

/*
  ****************************************************************************
  ****************************************************************************
  ****************************************************************************
                              Çağırma metodları
  ****************************************************************************
  ****************************************************************************
  ****************************************************************************
*/
  static Future<List<StokData>> stokGetir() async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _ILAC_STOK_GETIR_ACTION;
      final response = await http.post(ROOT, body: map);
      print('stokGetirSonuc: ${response.body}');
      if (200 == response.statusCode) {
        List<StokData> list = stokDataDonusur(response.body);
        return list;
      } else {
        return List<StokData>();
      }
    } catch (e) {
      print("Catch Hatası!");
      return List<StokData>();
    }
  }

  static Future<List<HastaData>> hastaGetir() async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _BUTUN_HASTA_GETIR_ACTION;
      final response = await http.post(ROOT, body: map);
      print('hastaGetirSonuc: ${response.body}');
      if (200 == response.statusCode) {
        List<HastaData> list = hastaDataDonusur(response.body);
        return list;
      } else {
        return List<HastaData>();
      }
    } catch (e) {
      print("Catch Hatası!");
      return List<HastaData>();
    }
  }

  static Future<List<PersonelData>> personelGetir() async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _BUTUN_PERSONEL_GETIR_ACTION;
      final response = await http.post(ROOT, body: map);
      print('personelGetirSonuc: ${response.body}');
      if (200 == response.statusCode) {
        List<PersonelData> list = personelDataDonusur(response.body);
        return list;
      } else {
        return List<PersonelData>();
      }
    } catch (e) {
      print("Catch Hatası!");
      return List<PersonelData>();
    }
  }

  static Future<List<MuhasebeData>> muhasebeGetir() async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _MUHASEBE_GETIR_ACTION;
      final response = await http.post(ROOT, body: map);
      print('muhasebeGetirSonuc: ${response.body}');
      if (200 == response.statusCode) {
        List<MuhasebeData> list = muhasebeDataDonusur(response.body);
        return list;
      } else {
        return List<MuhasebeData>();
      }
    } catch (e) {
      print("Catch Hatası!");
      return List<MuhasebeData>();
    }
  }

/*
  ****************************************************************************
  ****************************************************************************
  ****************************************************************************
                              Güncelleme metodları
  ****************************************************************************
  ****************************************************************************
  ****************************************************************************
*/
  static Future<String> stokEkle(
    String id,
    String isim,
    String adet,
    String tutar,
  ) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _STOK_EKLE_ACTION;
      map['id'] = id;
      map['isim'] = isim;
      map['adet'] = adet;
      map['tutar'] = tutar;
      final response = await http.post(ROOT, body: map);
      print('stok Ekleme: ${response.body}');
      if (200 == response.statusCode) {
        return response.body;
      } else {
        return "error1";
      }
    } catch (e) {
      return "error2";
    }
  }

  static Future<String> ilacSat(
    String id,
    String adet,
  ) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _SATIS_YAP_ACTION;
      map['id'] = id;
      map['adet'] = adet;
      final response = await http.post(ROOT, body: map);
      print('ilac Satisi: ${response.body}');
      if (200 == response.statusCode) {
        return response.body;
      } else {
        return "error1";
      }
    } catch (e) {
      return "error2";
    }
  }

/*
  ****************************************************************************
  ****************************************************************************
  ****************************************************************************
                              Ekleme metodları
  ****************************************************************************
  ****************************************************************************
  ****************************************************************************
*/
  static Future<String> hastaEkle(
    String ad,
    String soyad,
    String tc,
    String adress,
    String telefon,
  ) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _HASTA_EKLE_ACTION;
      map['ad'] = ad;
      map['soyad'] = soyad;
      map['tc'] = tc;
      map['adress'] = adress;
      map['telefon'] = telefon;
      final response = await http.post(ROOT, body: map);
      print('Hasta Ekleme: ${response.body}');
      if (200 == response.statusCode) {
        return response.body;
      } else {
        return "error";
      }
    } catch (e) {
      return "error";
    }
  }

  static Future<String> personelEkle(
    String ad,
    String soyad,
    String tc,
    String adress,
    String telefon,
    String maas,
  ) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _PERSONEL_EKLE_ACTION;
      map['ad'] = ad;
      map['soyad'] = soyad;
      map['tc'] = tc;
      map['adress'] = adress;
      map['telefon'] = telefon;
      map['maas'] = maas;
      final response = await http.post(ROOT, body: map);
      print('Personel Ekleme: ${response.body}');
      if (200 == response.statusCode) {
        return response.body;
      } else {
        return "error";
      }
    } catch (e) {
      return "error";
    }
  }

  static Future<String> ilacEkle(
    String barkodno,
    String isim,
    String alis,
    String satis,
    String adet,
    String tutar,
  ) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _ILAC_KAYIT_ACTION;
      map['isim'] = isim;
      map['barkodno'] = barkodno;
      map['alisfiyati'] = alis;
      map['satisfiyati'] = satis;
      map['adet'] = adet;
      map['tutar'] = tutar;
      final response = await http.post(ROOT, body: map);
      print('İlaç Kayıt Ekleme: ${response.body}');
      if (200 == response.statusCode) {
        return response.body;
      } else {
        return "error";
      }
    } catch (e) {
      return "error";
    }
  }

  static Future<String> muhasebeIlacSatis(
    String isim,
    String adet,
    String tutar,
  ) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _MUHASEBE_ILAC_SATIS_ACTION;
      map['isim'] = isim;
      map['adet'] = adet;
      map['tutar'] = tutar;
      final response = await http.post(ROOT, body: map);
      print('Muhasebe ilaç Satışı: ${response.body}');
      if (200 == response.statusCode) {
        return response.body;
      } else {
        return "error";
      }
    } catch (e) {
      return "error";
    }
  }

/*
  ****************************************************************************
  ****************************************************************************
  ****************************************************************************
                              Dönüştürme metodları
  ****************************************************************************
  ****************************************************************************
  ****************************************************************************
*/

  static List<StokData> stokDataDonusur(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<StokData>((json) => StokData.fromJson(json)).toList();
  }

  static List<HastaData> hastaDataDonusur(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<HastaData>((json) => HastaData.fromJson(json)).toList();
  }

  static List<PersonelData> personelDataDonusur(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<PersonelData>((json) => PersonelData.fromJson(json))
        .toList();
  }

  static List<MuhasebeData> muhasebeDataDonusur(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<MuhasebeData>((json) => MuhasebeData.fromJson(json))
        .toList();
  }
}
