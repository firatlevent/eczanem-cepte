import 'package:flutter/material.dart';
import 'package:eczane/Pages/anasayfa.dart';
import 'package:eczane/Pages/login.dart';
import 'package:eczane/Pages/hastaKayit.dart';
import 'package:eczane/Pages/personelKayit.dart';
import 'package:eczane/Pages/ilacKayit.dart';
import 'package:eczane/Pages/ilacSatis.dart';
import 'package:eczane/Pages/hastaGoruntule.dart';
import 'package:eczane/Pages/personelGoruntule.dart';
import 'package:eczane/Pages/stok.dart';
import 'package:eczane/Pages/stokEkle.dart';
import 'package:eczane/Pages/muhasebe.dart';

import '../main.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    //final args = settings.arguments;
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => BeklemeSayfasi());
      case '/login':
        return MaterialPageRoute(builder: (_) => Login());
      case '/anasayfa':
        return MaterialPageRoute(builder: (_) => Anasayfa());
      case '/hastaKayit':
        return MaterialPageRoute(builder: (_) => HastaKayit());
      case '/personelKayit':
        return MaterialPageRoute(builder: (_) => PersonelKayit());
      case '/ilacKayit':
        return MaterialPageRoute(builder: (_) => IlacKayit());
      case '/ilacSatis':
        return MaterialPageRoute(builder: (_) => IlacSatis());
      case '/hastaGoruntule':
        return MaterialPageRoute(builder: (_) => HastaGoruntule());
      case '/personelGoruntule':
        return MaterialPageRoute(builder: (_) => PersonelGoruntule());
      case '/stok':
        return MaterialPageRoute(builder: (_) => Stok());
      case '/stokEkle':
        return MaterialPageRoute(builder: (_) => StokEkle());
      case '/muhasebe':
        return MaterialPageRoute(builder: (_) => Muhasebe());
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Hata"),
        ),
        body: Center(
          child: Text("Bir şey oldu."),
        ),
      );
    });
  }
}
