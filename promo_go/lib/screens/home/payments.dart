import 'package:flutter/material.dart';

import '../../shared/constants.dart';

class Payments extends StatelessWidget {
  static const routeName = '/payments';

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
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    FlatButton.icon(
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      ),
                      label: Text(
                        'Edit Profile',
                        style: TextStyle(color: Colors.white),
                      ), //`Text` to display
                      onPressed: () {},
                    ),
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
                  'You are paying',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            Expanded(
              child: ListView(
                children: <Widget>[
                  ListTile(
                    leading: Text("Amount"),
                    trailing: Text("\$5.00"),
                  ),
                  ListTile(
                    leading: CircleAvatar(
                      backgroundColor: lightGreyColor,
                      child: Icon(Icons.local_offer,
                          color: Theme.of(context).primaryColor),
                    ),
                    trailing: Text('-\$1.00'),
                    title: RichText(
                      text: TextSpan(
                        text: "Promo:",
                        children: <TextSpan>[
                          TextSpan(
                            text: 'SAVE1',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    onTap: () {},
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Text("Total Payable"),
              trailing: Text(
                "\$4.00",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
