import 'package:flutter/material.dart';
import 'package:eczane/Services/databaseConnection.dart';
import 'package:synchronized/synchronized.dart';
import 'package:eczane/Services/veriDepo.dart' as globals;

class Anasayfa extends StatefulWidget {
  @override
  _AnasayfaState createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {
  final _lock = new Lock();

  _stokGetir() async {
    await _lock.synchronized(() async {
      Services.stokGetir().then((stok) {
        globals.stokDepo = stok;
        setState(() {});
      });
    });
  }

  _hastaGetir() async {
    await _lock.synchronized(() async {
      Services.hastaGetir().then((hasta) {
        globals.hastaDepo = hasta;
        setState(() {});
      });
    });
  }

  _personelGetir() async {
    await _lock.synchronized(() async {
      Services.personelGetir().then((personel) {
        globals.personelDepo = personel;
        setState(() {});
      });
    });
  }

  _muhasebeGetir() async {
    await _lock.synchronized(() async {
      Services.muhasebeGetir().then((muhasebe) {
        globals.muhasebeDepo = muhasebe;
        setState(() {});
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _stokGetir();
    _hastaGetir();
    _personelGetir();
    _muhasebeGetir();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          Navigator.pushNamed(context, "/anasayfa");
          return Future.value(false);
        },
        child: Scaffold(
          appBar: AppBar(
            leading: new Container(
              width: 0,
            ),
            centerTitle: true,
            backgroundColor: Colors.grey[900],
            title: Text(
              "Eczane Otomasyonu",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white),
            ),
            actions: <Widget>[],
          ),
          body: Theme(
            data: Theme.of(context).copyWith(accentColor: Colors.grey),
            child: ListView(children: <Widget>[
              Center(
                  child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(top: 0),
                            child: InkWell(
                              splashColor: Colors.white,
                              onTap: () {
                                Navigator.pushNamed(context, "/ilacSatis");
                              },
                              child: Container(
                                height: 150,
                                width:
                                    MediaQuery.of(context).size.width / 2 - 20,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.grey[900]),
                                child: Center(
                                  child: Text("İlaç Satış",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 24,
                                      )),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 0),
                            child: InkWell(
                              splashColor: Colors.white,
                              onTap: () {
                                Navigator.pushNamed(context, "/ilacKayit");
                              },
                              child: Container(
                                height: 150,
                                width:
                                    MediaQuery.of(context).size.width / 2 - 20,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.grey[900]),
                                child: Center(
                                  child: Text("İlaç Kayıt",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 24,
                                      )),
                                ),
                              ),
                            ),
                          )
                        ]),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(top: 0),
                            child: InkWell(
                              splashColor: Colors.white,
                              onTap: () {
                                Navigator.pushNamed(context, "/hastaGoruntule");
                              },
                              child: Container(
                                height: 150,
                                width:
                                    MediaQuery.of(context).size.width / 2 - 20,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.grey[900]),
                                child: Center(
                                  child: Text("Hasta Görüntüle",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 24,
                                      )),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 0),
                            child: InkWell(
                              splashColor: Colors.white,
                              onTap: () {
                                Navigator.pushNamed(
                                    context, "/personelGoruntule");
                              },
                              child: Container(
                                height: 150,
                                width:
                                    MediaQuery.of(context).size.width / 2 - 20,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.grey[900]),
                                child: Center(
                                  child: Text("Personel Görüntüle",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 24,
                                      )),
                                ),
                              ),
                            ),
                          )
                        ]),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(top: 0),
                            child: InkWell(
                              splashColor: Colors.white,
                              onTap: () {
                                Navigator.pushNamed(context, "/hastaKayit");
                              },
                              child: Container(
                                height: 150,
                                width:
                                    MediaQuery.of(context).size.width / 2 - 20,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.grey[900]),
                                child: Center(
                                  child: Text("Hasta Kayıt",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 24,
                                      )),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 0),
                            child: InkWell(
                              splashColor: Colors.white,
                              onTap: () {
                                Navigator.pushNamed(context, "/personelKayit");
                              },
                              child: Container(
                                height: 150,
                                width:
                                    MediaQuery.of(context).size.width / 2 - 20,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.grey[900]),
                                child: Center(
                                  child: Text("Personel Kayıt",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 24,
                                      )),
                                ),
                              ),
                            ),
                          )
                        ]),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(top: 0),
                            child: InkWell(
                              splashColor: Colors.white,
                              onTap: () {
                                Navigator.pushNamed(context, "/stok");
                              },
                              child: Container(
                                height: 150,
                                width:
                                    MediaQuery.of(context).size.width / 2 - 20,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.grey[900]),
                                child: Center(
                                  child: Text("Stok Görüntüle",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 24,
                                      )),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 0),
                            child: InkWell(
                              splashColor: Colors.white,
                              onTap: () {
                                Navigator.pushNamed(context, "/stokEkle");
                              },
                              child: Container(
                                height: 150,
                                width:
                                    MediaQuery.of(context).size.width / 2 - 20,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.grey[900]),
                                child: Center(
                                  child: Text("Stok Ekle",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 24,
                                      )),
                                ),
                              ),
                            ),
                          ),
                        ]),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(top: 0),
                            child: InkWell(
                              splashColor: Colors.white,
                              onTap: () {
                                Navigator.pushNamed(context, "/muhasebe");
                              },
                              child: Container(
                                height: 150,
                                width:
                                    MediaQuery.of(context).size.width / 2 - 20,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.grey[900]),
                                child: Center(
                                  child: Text("Muhasebe",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 24,
                                      )),
                                ),
                              ),
                            ),
                          ),
                        ]),
                  )
                ],
              )),
            ]),
          ),
        ));
  }
}
