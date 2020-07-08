import 'package:flutter/material.dart';
import 'package:promogo/models/promo.dart';
import 'package:promogo/services/database.dart';
import 'package:promogo/services/locator.dart';
import 'package:promogo/services/user_location.dart';

import './offers.dart';
import '../../shared/constants.dart';
import '../home/capture.dart';
import '../home/activity.dart';
import 'account/account.dart';

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

  Future<void> setUpPromoDatabase() async {
    LocationService locationService = LocationService();
    UserLocation userLocation = UserLocation();
    final merchants = await locationService.getMerchantLocation();
    var promoList = new Set<Promo>();
    for (final merchant in merchants) {
      Promo p = Promo(merchant: merchant);
      promoList.add(p);
    }
    DatabaseService().initiatePromoListData(promoList);
  }

  @override
  Widget build(BuildContext context) {
//    setUpPromoDatabase(); // Initiate once for firebase
//    Future<Set<Promo>> promoList = DatabaseService().getPromoList; // This is how to retrieve promoList

    return Scaffold(
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
    );
  }
}
