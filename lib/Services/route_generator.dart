import 'package:flutter/material.dart';
import 'package:eczane/Pages/anasayfa.dart';
import 'package:eczane/Pages/login.dart';
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
