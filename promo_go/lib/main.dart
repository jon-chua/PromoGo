import 'package:flutter/material.dart';
import 'package:promogo/screens/wrapper.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

import './models/userid.dart';
import './services/auth.dart';

void main() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserID>.value(
      value: AuthService().user,
      child: MaterialApp(
        home: Wrapper(),
      ),
    );
  }
}
