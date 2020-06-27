import 'package:flutter/material.dart';
import 'package:promogo/models/user.dart';
import 'package:promogo/screens/authenticate/authenticate.dart';
import 'package:promogo/screens/home/tabs.dart';
import 'package:promogo/shared/constants.dart';
import 'package:provider/provider.dart';

import '../screens/home/tabs.dart';
import '../models/user.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    Widget screen = Authenticate();

    if (user == null) {
      screen = Authenticate();
    } else {
      screen = Tabs();
    }

    return MaterialApp(
      title: 'PromoGo',
      theme: themeData(context),
      home: screen,
    );
  }
}
