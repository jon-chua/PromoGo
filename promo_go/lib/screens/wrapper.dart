import 'package:flutter/material.dart';
import 'package:promogo/models/user.dart';
import 'package:promogo/screens/authenticate/authenticate.dart';
import 'package:promogo/screens/home/home.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);

    // return Home or Authenticate widget
    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}
