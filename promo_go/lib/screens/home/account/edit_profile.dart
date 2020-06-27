import 'package:flutter/material.dart';
import 'package:promogo/models/userprofile.dart';

import 'package:promogo/services/database.dart';
import 'package:promogo/shared/loading.dart';

class EditProfile extends StatefulWidget {
  final UserProfile userProfile;

  EditProfile({this.userProfile});

  @override
  _EditProfileState createState() =>
      _EditProfileState(userProfile: userProfile);
}

class _EditProfileState extends State<EditProfile> {
  final _formKey = GlobalKey<FormState>();
  final UserProfile userProfile;

  String _currentName;

  _EditProfileState({this.userProfile});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<UserProfile>(
        stream: DatabaseService(userID: userProfile.userID).userProfile,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print("Snapshot has data");
            print(snapshot);

            return Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Text(
                      "Edit your profile",
                      style: TextStyle(fontSize: 18.0),
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      initialValue: userProfile.name,
                      validator: (val) =>
                          val.isEmpty ? 'Update your name' : null,
                      onChanged: (val) => setState(() => _currentName = val),
                    ),
                    SizedBox(height: 20.0),
                    RaisedButton(
                        color: Colors.pink[400],
                        child: Text(
                          'Update',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            await DatabaseService(userID: userProfile.userID).updateUsernameData(
                                _currentName ?? snapshot.data.name,
                            );
                            Navigator.pop(context);
                          }
                        })
                  ],
                ));
          } else {
            return Loading();
          }
        });
  }
}
