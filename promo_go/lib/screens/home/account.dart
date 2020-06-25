import 'package:flutter/material.dart';

import '../../shared/constants.dart';
import '../../services/auth.dart';
import '../authenticate/sign_in.dart';

class Account extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Stack(
          children: <Widget>[
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height / 3,
              child: Image.asset(
                'assets/images/clouds.png',
                fit: BoxFit.cover,
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height / 3,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  colors: [
                    Color(0xFF4696F4).withAlpha(95),
                    Color(0xFF1A1F71).withAlpha(95),
                  ],
                ),
              ),
            ),
            Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    FlatButton.icon(
                      icon: Icon(
                        Icons.create,
                        color: Colors.white,
                      ),
                      label: Text(
                        'Edit Profile',
                        style: TextStyle(color: Colors.white),
                      ), //`Text` to display
                      onPressed: () {},
                    ),
                    SizedBox(width: 10),
                    FlatButton.icon(
                        icon: Icon(
                          Icons.link_off,
                          color: Colors.white,
                        ),
                        label: Text(
                          'Logout',
                          style: TextStyle(color: Colors.white),
                        ), //`Text` to display
                        onPressed: () async {
                          dynamic result = await _auth.signOut();
                          if (result == null) {
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                SignIn.routeName,
                                (Route<dynamic> route) => false);
                          } else {}
                        })
                  ],
                ),
                CircleAvatar(
                  radius: 55,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                    backgroundImage: AssetImage('assets/images/miniso.jpg'),
                    radius: 53,
                    backgroundColor: lightGreyColor,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Adam Lee',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                Text(
                  'adamlee@mail.com',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
        Expanded(
          child: ListView(
            children: <Widget>[
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: lightGreyColor,
                  child: Icon(Icons.receipt,
                      color: Theme.of(context).primaryColor),
                ),
                title: Text("My Purchase History"),
              ),
              Divider(
                height: 3,
                color: mediumGreyColor,
              ),
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: lightGreyColor,
                  child: Icon(Icons.local_offer,
                      color: Theme.of(context).primaryColor),
                ),
                title: Text("My Promos"),
              ),
              Divider(
                height: 3,
                color: mediumGreyColor,
              ),
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: lightGreyColor,
                  child: Icon(Icons.favorite,
                      color: Theme.of(context).primaryColor),
                ),
                title: Text("My Preferences"),
              ),
              Divider(
                height: 3,
                color: mediumGreyColor,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
