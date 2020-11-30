import 'package:flutter/material.dart';
import 'package:eczane/Services/databaseConnection.dart';
import 'package:wc_form_validators/wc_form_validators.dart';

class IlacKayit extends StatefulWidget {
  @override
  _IlacKayitState createState() => _IlacKayitState();
}

class _IlacKayitState extends State<IlacKayit> {
  final barkodC = TextEditingController();
  final isimC = TextEditingController();
  final alC = TextEditingController();
  final satC = TextEditingController();
  final adetC = TextEditingController();
  final _key = new GlobalKey<FormState>();
  int _tutar = 0;

  _ilacKaydet() async {
    _tutar = int.parse(alC.text) * int.parse(adetC.text);
    print(_tutar.toString() + " Toplam Tutar");
    await Services.ilacEkle(
      barkodC.text,
      isimC.text,
      alC.text,
      satC.text,
      adetC.text,
      _tutar.toString(),
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
              "İlaç Kayıt",
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
                    controller: barkodC,
                    validator: Validators.compose([
                      Validators.required("Barkod giriniz."),
                      Validators.patternRegExp(
                          RegExp(r"^[0-9]+$"), 'Sadece sayı içerebilir.'),
                    ]),
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey[900], width: 1)),
                      labelText: "Barkod No",
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
                    controller: isimC,
                    validator: Validators.compose([
                      Validators.required("İsim giriniz."),
                      Validators.minLength(2, 'En az 2 karakter olmalıdır.'),
                    ]),
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey[900], width: 1)),
                      labelText: "İsim",
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
                    controller: alC,
                    validator: Validators.compose([
                      Validators.required("Alış fiyatı giriniz."),
                      Validators.patternRegExp(
                          RegExp(r"^[0-9]+$"), 'Sadece sayı içerebilir.'),
                    ]),
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey[900], width: 0.5)),
                      labelText: "Alış Fiyatı",
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
                    controller: satC,
                    validator: Validators.compose([
                      Validators.required("Satış fiyatı giriniz."),
                      Validators.patternRegExp(
                          RegExp(r"^[0-9]+$"), 'Sadece sayı içerebilir.'),
                    ]),
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey[900], width: 0.5)),
                      labelText: "Satış Fiyatı",
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
                    controller: adetC,
                    validator: Validators.compose([
                      Validators.required("Adet giriniz."),
                      Validators.patternRegExp(
                          RegExp(r"^[0-9]+$"), 'Sadece sayı içerebilir.'),
                    ]),
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey[900], width: 0.5)),
                      labelText: "Adet",
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
                          _ilacKaydet();
                          return showDialog<bool>(
                            context: context,
                            builder: (c) => AlertDialog(
                              title: Text('Bildirim'),
                              content: Text('İlaç eklenmiştir.'),
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
}
