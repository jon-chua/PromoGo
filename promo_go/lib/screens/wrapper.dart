import 'package:flutter/material.dart';
import 'package:promogo/screens/authenticate/authenticate.dart';
import 'package:promogo/screens/home/home.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // return Home or Authenticate widget
//    return Home();
    return Authenticate();
  }
}
