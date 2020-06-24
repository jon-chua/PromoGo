import 'package:flutter/material.dart';
import 'package:promogo/screens/authenticate/sign_in.dart';
import '../../services/auth.dart';
import '../../screens/AR/AR.dart';

class Home extends StatelessWidget {
  static const routeName = '/home';
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[50],
      appBar: AppBar(
        title: Text('Promo Go'),
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        actions: <Widget>[
          FlatButton.icon(
              icon: Icon(Icons.person),
              label: Text('logout'),
              onPressed: () async {
                  dynamic result = await _auth.signOut();
                  if (result == null) {
                    Navigator.of(context).pushNamed(SignIn.routeName);
                  } else {
                  }
              })
        ],
      ),
      body: RaisedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AR()),
          );
        },
        child: Text(
          "AR Feature",
        ),
      ),
    );
  }
}
