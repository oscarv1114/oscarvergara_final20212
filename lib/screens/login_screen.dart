// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    _showButtons(),
                  ],
                )
              ])
        ],
      ),
    );
  }

  Widget _showButtons() {
    return Container(
      padding: EdgeInsets.fromLTRB(25, 10, 25, 5),
      child: Row(
        children: <Widget>[
          Expanded(
              child: ElevatedButton.icon(
            onPressed: () => _loginFacebook(),
            icon: Icon(Icons.facebook),
            label: Text("Iniciar sesión con facebook"),
            style: ElevatedButton.styleFrom(primary: Color(0xFF3B5998)),
          ))
        ],
      ),
    );
  }

  void _loginFacebook() async {
    await FacebookAuth.i.logOut();

    var result = await FacebookAuth.i.login(
      permissions: ["public_profile", "email"],
    );

    if (result.status == LoginStatus.success) {
      final requestData = await FacebookAuth.i.getUserData(
        fields:
            "email, name, picture.width(800).heigth(800), first_name, last_name",
      );

      print(requestData);
    }

    print(result.message);
  }
}
