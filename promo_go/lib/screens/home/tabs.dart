import 'package:flutter/material.dart';
import 'package:promogo/models/userid.dart';
import 'package:promogo/models/userprofile.dart';
import 'package:provider/provider.dart';

import './offers.dart';
import '../../shared/constants.dart';
import '../home/capture.dart';
import '../home/activity.dart';
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
    UserID user = Provider.of<UserID>(context);
    print(user.uid);

    return StreamProvider<UserProfile>.value(
      value: DatabaseService(userID: user).userProfile,
      child: Scaffold(
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
    );
  }
}
