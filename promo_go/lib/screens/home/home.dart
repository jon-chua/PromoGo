import 'package:flutter/material.dart';
import 'package:promogo/models/userid.dart';
import 'package:promogo/models/userprofile.dart';
import 'package:provider/provider.dart';

import '../../shared/constants.dart';
import '../../services/database.dart';
import '../AR/AR.dart';
import 'edit_profile.dart';
import 'tabs.dart';

class Home extends StatefulWidget {
  static const routeName = '/home';

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    UserID user = Provider.of<UserID>(context);
    print(user.uid);

    return StreamProvider<UserProfile>.value(
      value: DatabaseService(userID: user).userProfile,
      child: MaterialApp(
          home: Tabs(),
          routes: {
            Tabs.routeName: (ctx) => Tabs(),
            AR.routeName: (ctx) => AR(),
            EditProfile.routeName: (ctx) => EditProfile(),
          },
          theme: themeData(context)),
    );
  }
}
