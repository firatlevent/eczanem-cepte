import 'package:flutter/material.dart';
import 'package:eczane/Database/stokData.dart';
import 'package:eczane/Services/databaseConnection.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';
import 'package:eczane/Services/veriDepo.dart' as globals;
import 'package:wc_form_validators/wc_form_validators.dart';

class StokEkle extends StatefulWidget {
  @override
  _StokEkleState createState() => _StokEkleState();
}

class _StokEkleState extends State<StokEkle> {
  List<DropdownMenuItem<String>> _dropDownMenuItems;
  String _secilenIlac;
  String _secilenID;
  final alC = TextEditingController();
  final adetC = TextEditingController();
  final _key = new GlobalKey<FormState>();
  int _tutar = 0;

  _stokEkleme() async {
    _tutar = int.parse(alC.text) * int.parse(adetC.text);
    print(_tutar.toString() + " Toplam Tutar");
    await Services.stokEkle(
      _secilenID,
      _secilenIlac,
      adetC.text,
      _tutar.toString(),
    ).then((result) {
      if ('success' == result) {
        print("Başarılı.");
      }
    });
  }

  @override
  void initState() {
    _dropDownMenuItems = getDropDownMenuItems();
    _secilenIlac = _dropDownMenuItems[0].value;
    super.initState();
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
              "Stok Ekle",
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
                  child: SearchableDropdown.single(
                    items: _dropDownMenuItems,
                    value: _secilenIlac,
                    hint: "İlaç Seçiniz",
                    searchHint: "İlaç Seçiniz",
                    onChanged: changedDropDownItem,
                    isExpanded: true,
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
                          _stokEkleme();
                          return showDialog<bool>(
                            context: context,
                            builder: (c) => AlertDialog(
                              title: Text('Bildirim'),
                              content: Text('Stok eklenmiştir.'),
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
                        child: Text("Ekle",
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

  void changedDropDownItem(String secilen) {
    print("Seçilen ilaç $secilen");
    for (StokData ilac in globals.stokDepo) {
      if (ilac.isim == secilen) {
        _secilenID = ilac.id;
      }
    }
    setState(() {
      _secilenIlac = secilen;
    });
  }

  List<DropdownMenuItem<String>> getDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = new List();
    for (StokData ilac in globals.stokDepo) {
      // here we are creating the drop down menu items, you can customize the item right here
      // but I'll just use a simple text for this
      items.add(
          new DropdownMenuItem(value: ilac.isim, child: new Text(ilac.isim)));
    }
    return items;
  }
}
