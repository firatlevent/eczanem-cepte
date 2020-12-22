import 'package:flutter/material.dart';
import 'package:eczane/Database/muhasebeData.dart';
import 'package:eczane/Services/veriDepo.dart' as globals;

class Muhasebe extends StatefulWidget {
  @override
  _MuhasebeState createState() => _MuhasebeState();
}

class _MuhasebeState extends State<Muhasebe> {
  int _toplamAldiVerdiDurum = 0;
  @override
  void initState() {
    super.initState();
    for (MuhasebeData item in globals.muhasebeDepo) {
      if (item.neYapildi == "satildi")
        _toplamAldiVerdiDurum += int.parse(item.tutar);
      if (item.neYapildi == "alindi")
        _toplamAldiVerdiDurum -= int.parse(item.tutar);
    }
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
              "Muhasebe",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white),
            ),
            actions: <Widget>[],
          ),
          body: Theme(
            data: Theme.of(context).copyWith(accentColor: Colors.grey),
            child: Stack(children: <Widget>[
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  height: MediaQuery.of(context).size.height - 120,
                  child: ListView.builder(
                    itemCount: globals.muhasebeDepo.length,
                    itemBuilder: (context, index) {
                      return _bilgiCard(
                        globals.muhasebeDepo[index].ilacadi,
                        globals.muhasebeDepo[index].adet,
                        globals.muhasebeDepo[index].tutar,
                        globals.muhasebeDepo[index].neYapildi,
                      );
                    },
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  color: Colors.grey[900],
                  child: Center(
                      child: Text(
                    "Durum : ₺" + _toplamAldiVerdiDurum.toString(),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  )),
                ),
              )
            ]),
          )),
    );
  }

  Widget _bilgiCard(String isim, String adet, String tutar, String neYapildi) {
    return Padding(
      padding: EdgeInsets.fromLTRB(5, 2.5, 5, 2.5),
      child: Card(
        elevation: 8.0,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5), color: Colors.grey[900]),
          height: 80,
          width: MediaQuery.of(context).size.width - 20,
          child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
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
                  padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
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
                  padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                  child: Container(
                    width: 60,
                    height: 80,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text("Tutar",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              )),
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text("₺" + tutar,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w300,
                                    fontSize: 20)),
                          ),
                        ]),
                  ),
                ),
                neYapildi == "alindi"
                    ? Padding(
                        padding: EdgeInsets.only(right: 15),
                        child: Icon(Icons.arrow_downward, color: Colors.red))
                    : Padding(
                        padding: EdgeInsets.only(right: 15),
                        child: Icon(Icons.arrow_upward, color: Colors.green))
              ]),
        ),
      ),
    );
  }
}
