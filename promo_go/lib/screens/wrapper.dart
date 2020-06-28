import 'package:flutter/material.dart';
import 'package:promogo/models/userid.dart';
import 'package:promogo/screens/authenticate/authenticate.dart';
import 'package:promogo/screens/home/home.dart';
import 'package:promogo/shared/constants.dart';
import 'package:provider/provider.dart';

import '../screens/home/home.dart';
import '../models/userid.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserID>(context);
    print(user);
    Widget screen = Authenticate();

    if (user == null) {
      screen = Authenticate();
    } else {
      screen = Home();
    }
//    screen = Authenticate();
    return MaterialApp(
      title: 'PromoGo',
      theme: themeData(context),
      home: screen,
    );
  }
}
