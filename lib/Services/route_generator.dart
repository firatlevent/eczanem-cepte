import 'package:flutter/material.dart';
import 'package:eczane/Pages/anasayfa.dart';
import 'package:eczane/Pages/login.dart';
import 'package:eczane/Pages/hastaKayit.dart';
import 'package:eczane/Pages/personelKayit.dart';
import 'package:eczane/Pages/ilacKayit.dart';
import 'package:eczane/Pages/ilacSatis.dart';

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
