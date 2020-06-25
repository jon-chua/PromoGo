import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart';

import '../../models/custom_notification.dart';
import '../../models/promo.dart';
import '../../shared/constants.dart';

class Activity extends StatefulWidget {
  @override
  _ActivityState createState() => _ActivityState();
}

class _ActivityState extends State<Activity> {
  List<CustomNotification> notifications = [
    CustomNotification(
      promo: Promo(
        name: 'Popular Bookstore',
        sale: '\$50 voucher',
      ),
      imageUrl: 'assets/images/popular.png',
      notificationType: CustomNotificationType.redemption,
      dateTime: DateTime(2020, DateTime.january, 9, 10, 5),
    ),
    CustomNotification(
      promo: Promo(
        name: 'Popular Bookstore',
        sale: '\$50 voucher',
      ),
      imageUrl: 'assets/images/popular.png',
      notificationType: CustomNotificationType.capture,
      dateTime: DateTime.utc(2020, DateTime.january, 9, 9, 5),
    ),
  ];

  RichText _getNotificationTitle(CustomNotification customNotification) {
    if (customNotification.notificationType == CustomNotificationType.capture) {
      return RichText(
        text: TextSpan(
          text: 'You have captured a ',
          style: DefaultTextStyle.of(context).style,
          children: <TextSpan>[
            TextSpan(
              text: '${customNotification.promo}',
              style: TextStyle(fontWeight: FontWeight.bold),
            )
          ],
        ),
      );
    } else if (customNotification.notificationType ==
        CustomNotificationType.redemption) {
      return RichText(
        text: TextSpan(
          text: 'You have successfully redeemed ',
          style: DefaultTextStyle.of(context).style,
          children: <TextSpan>[
            TextSpan(
              text: '${customNotification.promo}',
              style: TextStyle(fontWeight: FontWeight.bold),
            )
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: lightGreyColor,
      width: double.infinity,
      child: Column(
        children: [
          Container(
            color: Colors.white,
            child: ListTile(
              contentPadding:
                  EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              leading: Image.asset(
                'assets/images/logo.png',
                fit: BoxFit.contain,
              ),
              title: Text(
                  "Ready for a mid-year and Phase 2 reset? Enjoy savings of up to \$6 off your first promo capture from now up till 22 June!"),
            ),
          ),
          Divider(height: 3),
          Expanded(
            child: ListView.builder(
              itemCount: notifications.length,
              itemBuilder: (ctx, i) => Column(
                children: <Widget>[
                  Container(
                    color: Colors.white,
                    child: ListTile(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      leading: CircleAvatar(
                        backgroundImage: AssetImage(notifications[i].imageUrl),
                        radius: 30,
                        backgroundColor: lightGreyColor,
                      ),
                      title: _getNotificationTitle(notifications[i]),
                      subtitle: Text(
                        '${format(notifications[i].dateTime)}',
                        style: TextStyle(color: mediumGreyColor, fontSize: 12),
                      ),
                    ),
                  ),
                  Divider(
                    height: 3,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
