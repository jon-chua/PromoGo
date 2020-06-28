import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:promogo/models/user.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

import './offers.dart';
import '../../shared/constants.dart';
import '../home/capture.dart';
import '../home/activity.dart';
import '../AR/AR.dart';
import 'edit_profile.dart';
import 'account/account.dart';
import '../../services/database.dart';

class Tabs extends StatefulWidget {
  static const routeName = '/tabs';

  @override
  _TabsState createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    Offers(),
    Capture(),
    Activity(),
    Account(),
  ];
  final List<String> appBarTitles = [
    'Targeted Offers',
    'Promo Captures',
    'Activity',
    'Account',
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    print(user.uid);

    return StreamProvider<QuerySnapshot>.value(
      value: DatabaseService(uid: user.uid).profile,
      child: MaterialApp(
        routes: {
          AR.routeName: (ctx) => AR(),
          EditProfile.routeName: (ctx) => EditProfile(),
        },
        theme: ThemeData(
          primarySwatch: createMaterialColor(Color(0xFF1A1F71)),
          accentColor: Color.fromRGBO(247, 182, 0, 1),
          textTheme: GoogleFonts.quicksandTextTheme(
            Theme.of(context).textTheme,
          ),
          buttonTheme: ButtonThemeData(
            buttonColor: Color(0xFF1A1F71), //  <-- dark color
            textTheme: ButtonTextTheme
                .primary, //  <-- this auto selects the right color
          ),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Scaffold(
          appBar: AppBar(
            title: Text(appBarTitles[_currentIndex]),
            backgroundColor: Theme.of(context).primaryColor,
          ),
          body: _children[_currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            onTap: onTabTapped,
            // new
            currentIndex: _currentIndex,
            // new
            backgroundColor: Colors.white,
            selectedItemColor: Theme.of(context).primaryColor,
            unselectedItemColor: lightGreyColor,
            items: [
              new BottomNavigationBarItem(
                icon: Icon(Icons.shop),
                title: Text('Offers'),
              ),
              new BottomNavigationBarItem(
                icon: Icon(Icons.explore),
                title: Text('Capture'),
              ),
              new BottomNavigationBarItem(
                icon: Icon(Icons.notifications),
                title: Text('Activity'),
              ),
              new BottomNavigationBarItem(
                icon: Icon(Icons.face),
                title: Text('Account'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
