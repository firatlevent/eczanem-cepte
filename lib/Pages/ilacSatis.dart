import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:eczane/Database/hastaData.dart';
import 'package:eczane/Database/stokData.dart';
import 'package:eczane/Services/databaseConnection.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';
import 'package:eczane/Services/veriDepo.dart' as globals;

class IlacSatis extends StatefulWidget {
  @override
  _IlacSatisState createState() => _IlacSatisState();
}

class _IlacSatisState extends State<IlacSatis> {
  GlobalKey<ScaffoldState> _key = GlobalKey();
  List<DropdownMenuItem<String>> _dropDownMenuItems;
  String _secilenIlac;

  ScanResult scanResult;
  List<StokData> _satilanIlaclar = [];
  double _odenecekTutar = 0;
  double _toplamTutar = 0;
  double _indirimTutari = 0;

  final _flashOnController = TextEditingController(text: "Flash on");
  final _flashOffController = TextEditingController(text: "Flash off");
  final _cancelController = TextEditingController(text: "Cancel");

  var _aspectTolerance = 0.00;
  var _numberOfCameras = 0;
  var _selectedCamera = -1;
  var _useAutoFocus = true;
  var _autoEnableFlash = false;
  int _secilenRadio;

  static final _possibleFormats = BarcodeFormat.values.toList()
    ..removeWhere((e) => e == BarcodeFormat.unknown);

  List<BarcodeFormat> selectedFormats = [..._possibleFormats];

  _stokEkleme() async {
    await Services.muhasebeIlacSatis(
      "İlaç Satışı",
      _satilanIlaclar.length.toString(),
      _odenecekTutar.toString(),
    ).then((result) {
      if ('success' == result) {
        print("Başarılı.");
      }
    });
    for (StokData item in _satilanIlaclar) {
      await Services.ilacSat(item.id, item.adet).then((result) {
        if ('success' == result) {
          print("Başarılı.");
        }
      });
    }
  }

  @override
  // ignore: type_annotate_public_apis
  initState() {
    _dropDownMenuItems = getDropDownMenuItems();
    _secilenIlac = null; //_dropDownMenuItems[0].value;
    _secilenRadio = 1;
    super.initState();

    Future.delayed(Duration.zero, () async {
      _numberOfCameras = await BarcodeScanner.numberOfCameras;
      setState(() {});
    });
  }

  int radioKont = 1;
  setSecilenRadio(int value) {
    double temp = 0;
    if (value == 1) {
      radioKont = 1;
      if (_satilanIlaclar.length > 0) {
        for (StokData item in _satilanIlaclar) {
          temp += double.parse(item.satisfiyati) * double.parse(item.adet);
        }
        _toplamTutar = temp;
        temp = 0;
        _indirimTutari = _toplamTutar * 0.4;
        _odenecekTutar = _toplamTutar * 0.6;
      }
      setState(() {});
    }
    if (value == 2) {
      print("Sigortasız");
      radioKont = 2;
      _indirimTutari = _toplamTutar;
      _odenecekTutar = _toplamTutar;
    }
    if (value == 3) {
      print("Reçetesiz");
      radioKont = 3;
      _indirimTutari = _toplamTutar;
      _odenecekTutar = _toplamTutar;
    }
    setState(() {
      _secilenRadio = value;
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
          key: _key,
          appBar: AppBar(
            leading: IconButton(
                icon: Icon(Icons.arrow_back_ios),
                onPressed: () {
                  Navigator.pushNamed(context, "/anasayfa");
                }),
            centerTitle: true,
            backgroundColor: Colors.grey[900],
            title: Text(
              "İlaç Satış",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white),
            ),
            actions: <Widget>[],
          ),
          body: Theme(
            data: Theme.of(context).copyWith(accentColor: Colors.grey),
            child: ListView(children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Text(
                  "Hasta Seçimi",
                  style: TextStyle(
                      color: Colors.grey[900],
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: SearchableDropdown.single(
                  items: _dropDownMenuItems,
                  value: _secilenIlac,
                  hint: "Hasta Seçiniz",
                  searchHint: "Hasta Seçiniz",
                  onChanged: changedDropDownItem,
                  isExpanded: true,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Row(children: <Widget>[
                      Radio(
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        value: 1,
                        groupValue: _secilenRadio,
                        onChanged: (value) {
                          setSecilenRadio(value);
                        },
                        activeColor: Colors.grey[900],
                      ),
                      Text("Sigortalı")
                    ]),
                    Row(children: <Widget>[
                      Radio(
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        value: 2,
                        groupValue: _secilenRadio,
                        onChanged: (value) {
                          setSecilenRadio(value);
                        },
                        activeColor: Colors.grey[900],
                      ),
                      Text("Sigortasız")
                    ]),
                    Row(children: <Widget>[
                      Radio(
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        value: 3,
                        groupValue: _secilenRadio,
                        onChanged: (value) {
                          setSecilenRadio(value);
                        },
                        activeColor: Colors.grey[900],
                      ),
                      Text("Reçetesiz")
                    ]),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(0),
                child: Container(
                  height: _satilanIlaclar.length == 0 ? 75 : 200,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white),
                  child: _satilanIlaclar.length != 0
                      ? Padding(
                          padding: EdgeInsets.all(5),
                          child: Container(
                            width: MediaQuery.of(context).size.width / 2 - 40,
                            child: ListView.builder(
                              itemCount: _satilanIlaclar.length,
                              itemBuilder: (context, index) {
                                return _bilgiCard(
                                    _satilanIlaclar[index].isim,
                                    _satilanIlaclar[index].barkodno,
                                    _satilanIlaclar[index].id,
                                    _satilanIlaclar[index].adet,
                                    index);
                              },
                            ),
                          ),
                        )
                      : Padding(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            "Boş",
                            style: TextStyle(
                                color: Colors.grey[900],
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20, 20, 5, 20),
                child: Container(
                  height: 40,
                  width: 90,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey[900]),
                  child: InkWell(
                    splashColor: Colors.white,
                    onTap: () {
                      scan();
                    },
                    child: Center(
                      child: Text("İlaç Ekle",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20)),
                    ),
                  ),
                ),
              ),
              Padding(
                  padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(0),
                        child: Container(
                          width: MediaQuery.of(context).size.width / 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.fromLTRB(20, 5, 20, 0),
                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text(
                                    "İlaçların Toplam Tutarı",
                                    style: TextStyle(
                                        color: Colors.grey[900],
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(20, 5, 20, 0),
                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text(
                                    "Sigortanın Karşıladığı",
                                    style: TextStyle(
                                        color: Colors.grey[900],
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(20, 5, 20, 0),
                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text(
                                    "Ödenecek Tutar",
                                    style: TextStyle(
                                        color: Colors.grey[900],
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(0),
                        child: Container(
                          width: MediaQuery.of(context).size.width / 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.fromLTRB(20, 5, 20, 0),
                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text(
                                    "₺" + _toplamTutar.toString(),
                                    style: TextStyle(
                                        color: Colors.grey[900],
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(20, 5, 20, 0),
                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text(
                                    "₺" + _indirimTutari.toString(),
                                    style: TextStyle(
                                        color: Colors.grey[900],
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(20, 5, 20, 0),
                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text(
                                    "₺" + _odenecekTutar.toString(),
                                    style: TextStyle(
                                        color: Colors.grey[900],
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )),
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
                    },
                    child: Center(
                      child: Text("İşlemi Tamamla",
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
          )),
    );
  }

  /*IconButton(
            icon: Icon(Icons.camera),
            tooltip: "Scan",
            onPressed: scan,
          )*/

  Future scan() async {
    try {
      var options = ScanOptions(
        strings: {
          "cancel": _cancelController.text,
          "flash_on": _flashOnController.text,
          "flash_off": _flashOffController.text,
        },
        restrictFormat: selectedFormats,
        useCamera: _selectedCamera,
        autoEnableFlash: _autoEnableFlash,
        android: AndroidOptions(
          aspectTolerance: _aspectTolerance,
          useAutoFocus: _useAutoFocus,
        ),
      );

      var result = await BarcodeScanner.scan(options: options);

      setState(() {
        bool kont = false;
        scanResult = result;
        for (StokData item in globals.stokDepo) {
          if (item.barkodno == scanResult.rawContent) {
            item.adet = "1";
            _satilanIlaclar.add(item);
            kont = true;
            setSecilenRadio(radioKont);
          }
        }
        if (!kont) {
          return showDialog<bool>(
            context: context,
            builder: (c) => AlertDialog(
              title: Text('Uyarı'),
              content: Text('İlaç kayıtlı değil!'),
              actions: [
                FlatButton(
                  child: Text('Tamam'),
                  onPressed: () {
                    Navigator.pop(c, false);
                  },
                ),
              ],
            ),
          );
        }
      });
    } on PlatformException catch (e) {
      var result = ScanResult(
        type: ResultType.Error,
        format: BarcodeFormat.unknown,
      );

      if (e.code == BarcodeScanner.cameraAccessDenied) {
        setState(() {
          result.rawContent = 'The user did not grant the camera permission!';
        });
      } else {
        result.rawContent = 'Unknown error: $e';
      }
      setState(() {
        scanResult = result;
      });
    }
  }

  void changedDropDownItem(String secilen) {
    print("Seçilen ilaç $secilen");
    setState(() {});
  }

  List<DropdownMenuItem<String>> getDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = new List();
    for (HastaData hasta in globals.hastaDepo) {
      // here we are creating the drop down menu items, you can customize the item right here
      // but I'll just use a simple text for this
      items.add(new DropdownMenuItem(
          value: hasta.ad + " " + hasta.soyad,
          child: new Text(hasta.ad + " " + hasta.soyad)));
    }
    return items;
  }

  Widget _bilgiCard(
      String isim, String barkod, String id, String adet, int index) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 2.5, 0, 2.5),
      child: Card(
        elevation: 8.0,
        child: Dismissible(
          background: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5), color: Colors.red),
            child: Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text("Sil",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 70)),
            ),
          ),
          key: UniqueKey(),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.grey[900]),
            height: 80,
            width: MediaQuery.of(context).size.width - 20,
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(15, 20, 15, 20),
                    child: Container(
                      width: 60,
                      height: 80,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text("İlaç İsim",
                                style: TextStyle(
                                  color: Colors.grey[100],
                                  fontWeight: FontWeight.bold,
                                )),
                            FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(isim,
                                  style: TextStyle(
                                      color: Colors.grey[100],
                                      fontWeight: FontWeight.w300,
                                      fontSize: 20)),
                            ),
                          ]),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(15, 20, 15, 20),
                    child: Container(
                      width: 60,
                      height: 80,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text("Barkod",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                )),
                            FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(barkod,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w300,
                                      fontSize: 20)),
                            ),
                          ]),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(15, 20, 15, 20),
                    child: Container(
                      width: 60,
                      height: 80,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text("Adet",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                )),
                            //SizedBox(width:10)
                            FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                "x" + adet,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w300,
                                    fontSize: 20),
                              ),
                            )
                          ]),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 15),
                    child: IconButton(
                        splashColor: Colors.white,
                        hoverColor: Colors.white,
                        highlightColor: Colors.white,
                        icon: Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                        tooltip: "Arttır",
                        onPressed: () {
                          for (StokData item in _satilanIlaclar) {
                            if (item.id == id) {
                              int temp = int.parse(item.adet);
                              temp++;
                              item.adet = temp.toString();
                              setSecilenRadio(radioKont);
                              setState(() {});
                            }
                          }
                        }),
                  ),
                ]),
          ),
          onDismissed: (direction) {
            setState(() {
              StokData deletedItem = _satilanIlaclar.removeAt(index);
            });
          },
        ),
      ),
    );
  }
}
