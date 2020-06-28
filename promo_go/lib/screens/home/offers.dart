import 'package:flutter/material.dart';

import 'payments.dart';
import '../../widgets/search_bar.dart';
import '../../widgets/small_white_card.dart';
import '../../shared/constants.dart';
import '../../models/offer.dart';

enum Filter {
  all,
  targeted,
}

class Offers extends StatefulWidget {
  @override
  _OffersState createState() => _OffersState();
}

class _OffersState extends State<Offers> {
  var filter = Filter.all;
  final List<Offer> offers = [
    Offer(
      name: 'Miniso',
      description: 'Electronics & Technology | Home & Furnishing | Junction 8',
      sale: '50% discount off stationery',
      outletsNum: 2,
    ),
    Offer(
      name: 'Miniso',
      description: 'Electronics & Technology | Home & Furnishing | Junction 8',
      sale: '50% discount off stationery',
      outletsNum: 2,
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SmallWhiteCard(
          height: MediaQuery.of(context).size.height / 4.15,
          width: double.infinity,
          childWidget: Column(
            children: [
              SearchBar(),
              SizedBox(height: 10),
              Row(
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      setState(() => filter = Filter.all);
                    },
                    child: Chip(
                      backgroundColor:
                          filter == Filter.all ? orangeColor : lightGreyColor,
                      label: Text(
                        'Targeted',
                        style: TextStyle(
                          color: filter == Filter.all
                              ? Colors.white
                              : Colors.black87,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  InkWell(
                    onTap: () {
                      setState(() => filter = Filter.targeted);
                      print(filter);
                    },
                    child: Chip(
                      backgroundColor: filter == Filter.targeted
                          ? orangeColor
                          : lightGreyColor,
                      label: Text(
                        'All',
                        style: TextStyle(
                          color: filter == Filter.targeted
                              ? Colors.white
                              : Colors.black87,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 10),
        Expanded(
          child: Material(
            color: lightGreyColor,
            child: ListView.builder(
              itemCount: offers.length,
              itemBuilder: (value, i) => Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(10),
                    color: Colors.white,
                    child: ListTile(
                      onTap: () {
                        Navigator.of(context).pushNamed(Payments.routeName);
                      },
                      leading: CircleAvatar(
                        backgroundImage: AssetImage('assets/images/miniso.jpg'),
                        radius: 30,
                      ),
                      title: Text(
                        offers[i].name,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(offers[i].description),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Icon(
                                Icons.local_offer,
                                color: Theme.of(context).primaryColor,
                              ),
                              SizedBox(width: 3),
                              Text(offers[i].sale),
                            ],
                          ),
                          Text(
                            '${offers[i].outletsNum} offers around you',
                            style:
                                TextStyle(color: mediumGreyColor, fontSize: 12),
                          ),
                        ],
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
        )
      ],
    );
  }
}
