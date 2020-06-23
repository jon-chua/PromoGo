import 'package:flutter/material.dart';
import 'package:promogo/services/auth.dart';
import 'package:promogo/shared/constants.dart';

import '../../widgets/white_card.dart';
import '../../widgets/custom_text_field.dart';

class Register extends StatefulWidget {
  static const routeName = '/register';
  final Function toggleView;

  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

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
            top: 80,
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
              Form(
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
                    ),
                    CustomTextField(
                      hintText: 'password',
                      textInputType: TextInputType.text,
                      obscureText: true,
                      validator: (val) => val.length < 6
                          ? 'Enter a password 6+ chars long'
                          : null,
                    ),
                    ConstrainedBox(
                      constraints:
                          const BoxConstraints(minWidth: double.infinity),
                      child: RaisedButton(
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
//                            Scaffold.of(context).showSnackBar(
//                                SnackBar(content: Text('Processing Data')));
                            widget.toggleView();
                          }
//                              () async {
//                            if (_formKey.currentState.validate()) {
//                              dynamic result = await _auth.registerWithEmailAndPassword(
//                                  email, password);
//                              if (result == null) {
//                                setState(() => error = 'Please supply a valid email');
//                              } else {
//                                // User registers and page reloads automatically
//                              }
//                            }
//                          },
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
                          onPressed: () {},
                          child: Text(
                            'Sign up',
                            style: TextStyle(
                              color: Color(0xFFFF9635),
                            ),
                          ),
                        )
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
  }
}
