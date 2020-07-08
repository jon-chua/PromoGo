import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:promogo/visa/visa-direct.dart';
import 'package:http/http.dart';

import '../../shared/constants.dart';

class Payments extends StatelessWidget {
  static const routeName = '/payments';

  @override
  Widget build(BuildContext context) {
    final merchantName = ModalRoute.of(context).settings.arguments;

    return Material(
      color: lightGreyColor,
      child: Column(
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
                      IconButton(
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                  CircleAvatar(
                    radius: 55,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      backgroundImage: AssetImage('assets/images/visa2.jpg'),
                      radius: 53,
                      backgroundColor: lightGreyColor,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'You are paying $merchantName',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Expanded(
            child: Container(
              color: lightGreyColor,
              child: Column(
                children: <Widget>[
                  Container(
                    color: Colors.white,
                    child: ListTile(
                      leading: Text("Amount"),
                      trailing: Text("\$5.00"),
                    ),
                  ),
                  Divider(height: 3),
                  Container(
                    color: Colors.white,
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: lightGreyColor,
                        child: Icon(Icons.local_offer,
                            color: Theme.of(context).primaryColor),
                      ),
                      trailing: Text('-\$1.00'),
                      title: RichText(
                        text: TextSpan(
                          text: "Promo: ",
                          style: Theme.of(context).textTheme.bodyText1,
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
                  ),
                ],
              ),
            ),
          ),
          Container(
            color: Colors.white,
            child: ListTile(
              leading: Text("Total Payable"),
              trailing: Text(
                "\$4.00",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: ConstrainedBox(
              constraints: const BoxConstraints(minWidth: double.infinity),
              child: RaisedButton(
                color: Theme.of(context).accentColor,
                child: Text(
                  'PAY NOW',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onPressed: () async {
                  Response response = await VisaDirect.visaDirect();
                  log(response.body);

                  if (response.statusCode == 200) {
                    // OK
                    showDialog(
                        context: context,
                        builder: (_) => new AlertDialog(
                              title: new Text("Success"),
                              content: new Text("Transaction was successful!"),
                            ));
                  } else {
                    showDialog(
                        context: context,
                        builder: (_) => new AlertDialog(
                              title: new Text("Error"),
                              content: new Text("Unsuccessful transaction: " +
                                  response.reasonPhrase),
                            ));
                  }
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
