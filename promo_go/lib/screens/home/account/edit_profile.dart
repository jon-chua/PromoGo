import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:promogo/models/user.dart';

import 'package:promogo/services/database.dart';
import 'package:promogo/shared/loading.dart';
import 'package:provider/provider.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return StreamBuilder<QuerySnapshot>(
      stream: DatabaseService(uid: user.uid).profile,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          print("Snapshot has data");
          print(snapshot.data.documents);
          for (var data in snapshot.data.documents) {
            print(data.documentID);
          }
          return Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Text(
                    "Edit your profile",
                    style : TextStyle(fontSize: 18.0),
                  ),
                  SizedBox(height: 20.0),
//          TextFormField(
//            // Add stuff
//
//              onChanged: () {
//
//            }
//          ),
                  SizedBox(height: 20.0),
                  RaisedButton(
                      color: Colors.pink[400],
                      child: Text(
                        'Update',
                        style : TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        print('helo');
                      }
                  )

                ],
              )
          );
        } else {
          return Loading();
        }
      }
    );
  }
}
