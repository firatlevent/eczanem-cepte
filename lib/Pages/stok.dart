import 'package:flutter/material.dart';
import 'package:eczane/Services/veriDepo.dart' as globals;

class Stok extends StatefulWidget {
  @override
  _StokState createState() => _StokState();
}

class _StokState extends State<Stok> {
  List<String> liste2 = [
    "Nurofen",
    "Parol",
  ];

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
              "Stok",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white),
            ),
            actions: <Widget>[],
          ),
          body: Theme(
            data: Theme.of(context).copyWith(accentColor: Colors.grey),
            child: ListView.builder(
              itemCount: globals.stokDepo.length,
              itemBuilder: (context, index) {
                return _bilgiCard(
                    globals.stokDepo[index].isim,
                    globals.stokDepo[index].barkodno,
                    globals.stokDepo[index].adet);
              },
            ),
          )),
    );
  }

  Widget _bilgiCard(String isim, String barkod, String adet) {
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
                    width: 70,
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
                    width: 70,
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
                  padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                  child: Container(
                    width: 70,
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
                              adet,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w300,
                                  fontSize: 20),
                            ),
                          )
                        ]),
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}
