import 'package:flutter/material.dart';

import '../../services/auth.dart';
import '../../widgets/white_card.dart';
import '../../widgets/custom_text_field.dart';
import './register.dart';
import '../home/home.dart';

class SignIn extends StatefulWidget {
  static const routeName = '/signin';

  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  // Text field state
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: <Widget>[
          Container(
            height: double.infinity,
            width: double.infinity,
            color: Color(0xFFE5E5E5),
          ),
          Container(
            height: MediaQuery.of(context).size.height / 3,
            width: double.infinity,
            color: Colors.white,
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
          Positioned(
            top: 30,
            left: 0,
            width: 150,
            child: Container(
              color: Colors.transparent,
              child: Image.asset(
                'assets/images/banner.png',
                fit: BoxFit.contain,
                alignment: Alignment.topLeft,
              ),
            ),
          ),
          Center(
            child: WhiteCard(
              height: 450,
              width: 300,
              childWidget: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Image.asset(
                      'assets/images/logo.png',
                      width: 100,
                      height: 100,
                    ),
                    CustomTextField(
                      hintText: 'email',
                      textInputType: TextInputType.emailAddress,
                      obscureText: false,
                      validator: (val) => val.isEmpty ? 'Enter an email' : null,
                      onChanged: (val) {
                        setState(() => email = val);
                      },
                    ),
                    CustomTextField(
                      hintText: 'password',
                      textInputType: TextInputType.text,
                      obscureText: true,
                      validator: (val) => val.length < 6
                          ? 'Enter a password 6+ chars long'
                          : null,
                      onChanged: (val) {
                        setState(() => password = val);
                      },
                    ),
                    ConstrainedBox(
                      constraints:
                          const BoxConstraints(minWidth: double.infinity),
                      child: RaisedButton(
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            dynamic result = await _auth
                                .signInWithEmailAndPassword(email, password);
                            if (result == null) {
                              setState(() => error = 'Invalid credentials');
                            } else {
                              // User sign in and page reloads automatically
                              Navigator.of(context).pushNamed(Home.routeName);
                            }
                          }
                        },
                        child: Text(
                          'LOG IN',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('No account?'),
                        SizedBox(width: 10),
                        FlatButton(
                          onPressed: () {
                            Navigator.of(context)
                                .pushReplacementNamed(Register.routeName);
                          },
                          child: Text(
                            'Sign up',
                            style: TextStyle(
                              color: Color(0xFFFF9635),
                            ),
                          ),
                        ),
                        if (error.isNotEmpty) Text(error),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
//        child: RaisedButton(
//          child: Text('Sign in anonymously'),
//          onPressed: () async {
//            dynamic result = await _auth.signInAnon();
//            if (result == null) {
//              print('Error signing in');
//            } else {
//              print('Signed in');
//              print(result.uid);
//            }
  }
}
