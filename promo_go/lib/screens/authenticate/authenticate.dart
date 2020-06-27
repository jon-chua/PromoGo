import 'package:flutter/material.dart';
import 'package:promogo/screens/authenticate/register.dart';
import 'package:promogo/screens/authenticate/sign_in.dart';
import 'package:promogo/shared/constants.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: themeData(context),
      home: Register(),
      routes: {
        Register.routeName: (ctx) => Register(),
        SignIn.routeName: (ctx) => SignIn(),
      },
    );
  }
}

