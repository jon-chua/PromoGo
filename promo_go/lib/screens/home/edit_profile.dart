import 'package:flutter/material.dart';

import '../../widgets/white_card.dart';
import '../../widgets/custom_text_field.dart';
import '../../shared/constants.dart';

class EditProfile extends StatefulWidget {
  static const routeName = '/edit-profile';
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _formKey = GlobalKey<FormState>();

  //Text fields
  String email = '';
  String name = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      backgroundColor: Colors.white,
      body: Stack(
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 20,
                width: double.infinity,
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
              WhiteCard(
                height: 400,
                width: 300,
                childWidget: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      CustomTextField(
                        hintText: 'name',
                        textInputType: TextInputType.text,
                        obscureText: false,
                        validator: (val) => val.isEmpty ? 'Name' : null,
                        onChanged: (val) {
                          setState(() => name = val);
                        },
                      ),
                      CustomTextField(
                        hintText: 'email',
                        textInputType: TextInputType.emailAddress,
                        obscureText: false,
                        validator: (val) => val.isEmpty ? 'Email' : null,
                        onChanged: (val) {
                          setState(() => email = val);
                        },
                      ),
                      ConstrainedBox(
                        constraints:
                            const BoxConstraints(minWidth: double.infinity),
                        child: RaisedButton(
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              // TODO: Update fields
                              Navigator.of(context).pop();
                            } else {}
                          },
                          child: Text(
                            'SAVE',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
