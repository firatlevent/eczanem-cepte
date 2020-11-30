import 'package:flutter/material.dart';
import 'package:eczane/Services/databaseConnection.dart';
import 'package:wc_form_validators/wc_form_validators.dart';

class HastaKayit extends StatefulWidget {
  @override
  _HastaKayitState createState() => _HastaKayitState();
}

class _HastaKayitState extends State<HastaKayit> {
  final adC = TextEditingController();
  final soyadC = TextEditingController();
  final tcC = TextEditingController();
  final adressC = TextEditingController();
  final telefonC = TextEditingController();
  final _key = new GlobalKey<FormState>();
  _hastaKaydet() async {
    print(adC.text + soyadC.text + tcC.text + adressC.text + telefonC.text);
    await Services.hastaEkle(
      adC.text,
      soyadC.text,
      tcC.text,
      adressC.text,
      telefonC.text,
    ).then((result) {
      if ('success' == result) {
        print("Başarılı.");
      }
    });
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
            leading: IconButton(
                icon: Icon(Icons.arrow_back_ios),
                onPressed: () {
                  Navigator.pushNamed(context, "/anasayfa");
                }),
            centerTitle: true,
            backgroundColor: Colors.grey[900],
            title: Text(
              "Hasta Kayıt",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white),
            ),
            actions: <Widget>[],
          ),
          body: Theme(
            data: Theme.of(context).copyWith(accentColor: Colors.grey),
            child: Form(
              key: _key,
              child: ListView(children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: TextFormField(
                    controller: adC,
                    validator: Validators.compose([
                      Validators.required("Ad giriniz."),
                      Validators.minLength(3, 'En az 3 karakter olmalıdır.'),
                      Validators.maxLength(
                          16, 'En fazla 16 karakter olmalıdır.'),
                      Validators.patternRegExp(
                          RegExp(r"^[A-Za-z]+$"), 'Sadece harf içerebilir.'),
                    ]),
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey[900], width: 1)),
                      labelText: "Ad",
                      labelStyle: TextStyle(color: Colors.grey[900]),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey[900],
                          width: 2.0,
                        ),
                      ),
                      border: new OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey[900],
                          width: 2.5,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: TextFormField(
                    controller: soyadC,
                    validator: Validators.compose([
                      Validators.required("Soyad giriniz."),
                      Validators.minLength(2, 'En az 2 karakter olmalıdır.'),
                      Validators.maxLength(
                          16, 'En fazla 16 karakter olmalıdır.'),
                      Validators.patternRegExp(
                          RegExp(r"^[A-Za-z]+$"), 'Sadece harf içerebilir.'),
                    ]),
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey[900], width: 1)),
                      labelText: "Soyad",
                      labelStyle: TextStyle(color: Colors.grey[900]),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey[900],
                          width: 2.0,
                        ),
                      ),
                      border: new OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey[900],
                          width: 2.5,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: TextFormField(
                    controller: tcC,
                    validator: Validators.compose([
                      Validators.required("Tc giriniz."),
                      Validators.minLength(11, 'En az 11 karakter olmalıdır.'),
                      Validators.maxLength(
                          11, 'En fazla 11 karakter olmalıdır.'),
                      Validators.patternRegExp(
                          RegExp(r"^[0-9]+$"), 'Sadece sayı içerebilir.'),
                    ]),
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey[900], width: 0.5)),
                      labelText: "TC",
                      labelStyle: TextStyle(color: Colors.grey[900]),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey[900],
                          width: 2.0,
                        ),
                      ),
                      border: new OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey[900],
                          width: 2.0,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: TextFormField(
                    controller: telefonC,
                    validator: Validators.compose([
                      Validators.required("Telefon numarası giriniz."),
                      Validators.minLength(10,
                          'Sadece x ile gösterilen numaraları giriniz. +90(xxx) xxx xx xx'),
                      Validators.maxLength(10,
                          'Sadece x ile gösterilen numaraları giriniz. +90(xxx) xxx xx xx'),
                      Validators.patternRegExp(
                          RegExp(r"^[0-9]+$"), 'Sadece sayı içerebilir.'),
                    ]),
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey[900], width: 0.5)),
                      labelText: "Telefon",
                      labelStyle: TextStyle(color: Colors.grey[900]),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey[900],
                          width: 2.0,
                        ),
                      ),
                      border: new OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey[900],
                          width: 2.0,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: TextFormField(
                    controller: adressC,
                    validator: Validators.compose([
                      Validators.required("Adres giriniz."),
                      Validators.minLength(20, 'Yeterli adres giriniz.'),
                      Validators.maxLength(255, '255 Karekterden uzun olamaz'),
                    ]),
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey[900], width: 0.5)),
                      labelText: "Adres",
                      labelStyle: TextStyle(color: Colors.grey[900]),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey[900],
                          width: 2.0,
                        ),
                      ),
                      border: new OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey[900],
                          width: 2.0,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Container(
                    height: 40,
                    width: 90,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey[900]),
                    child: InkWell(
                      splashColor: Colors.white,
                      onTap: () {
                        _key.currentState.validate();
                        if (_key.currentState.validate()) {
                          _hastaKaydet();
                          return showDialog<bool>(
                            context: context,
                            builder: (c) => AlertDialog(
                              title: Text('Bildirim'),
                              content: Text('Hasta eklenmiştir.'),
                              actions: [
                                FlatButton(
                                  child: Text('Tamam'),
                                  onPressed: () {
                                    Navigator.pop(c, false);
                                    Navigator.pushNamed(context, '/anasayfa');
                                  },
                                ),
                              ],
                            ),
                          );
                          //_islemBitir(context);
                        }
                      },
                      child: Center(
                        child: Text("Kayıt",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20)),
                      ),
                    ),
                  ),
                ),
              ]),
            ),
          )),
    );
  }

  _islemBitir(BuildContext con) {
    return showDialog<bool>(
      context: con,
      builder: (c) => AlertDialog(
        title: Text('Uyarı'),
        content: Text('Çıkış yapmak istediğine emin misin?'),
        actions: [
          FlatButton(
            child: Text('Evet'),
            onPressed: () {
              Navigator.pop(c, false);
              Navigator.pushNamed(con, '/login');
            },
          ),
          FlatButton(
            child: Text('Hayır'),
            onPressed: () => Navigator.pop(c, false),
          ),
        ],
      ),
    );
  }
}
