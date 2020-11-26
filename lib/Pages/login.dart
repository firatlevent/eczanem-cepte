import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: Align(
        alignment: Alignment.center,
        child: Container(
          height: 200,
          width: 200,
          color: Colors.transparent,
          child: Center(
            child: IconButton(
                icon: Icon(
                  Icons.input,
                  size: 40,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, "/anasayfa");
                }),
          ),
        ),
      ),
    );
  }
}
