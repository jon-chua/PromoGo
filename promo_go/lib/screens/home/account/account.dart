import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:promogo/models/userprofile.dart';
import 'package:promogo/screens/home/account/edit_profile.dart';
import 'package:provider/provider.dart';

import '../../../shared/constants.dart';
import '../../../services/auth.dart';
import '../../authenticate/sign_in.dart';

class Account extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    final userProfile = Provider.of<UserProfile>(context);

    void _showEditProfile() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
              child: EditProfile(userProfile: userProfile),
            );
          });
    }

    void _showMyPurchaseHistory() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
              child: Text("My Purchase History"),
            );
          });
    }

    void _showMypromos() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
              child: Text("My Promos"),
            );
          });
    }

    void _showMyPreferences() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
              child: Text("My Preferences"),
            );
          });
    }

    return Column(
      children: <Widget>[
        Stack(
          children: <Widget>[
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height / 3,
              child: Image.asset(
                'assets/images/compass.png',
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
                      onPressed: () {
                        _showEditProfile();
                      },
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
                  userProfile.name,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                Text(
                  userProfile.email,
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
                  onTap: () {
                    _showMyPurchaseHistory();
                  }),
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
                onTap: () {
                  _showMypromos();
                },
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
                onTap: () {
                  _showMyPreferences();
                },
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
