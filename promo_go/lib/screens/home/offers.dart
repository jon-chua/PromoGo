import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:promogo/visa/visa-merchant-offers.dart';

import 'payments.dart';
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
  List<Offer> offers = [
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

  TextEditingController _searchQueryController = TextEditingController();
  bool _isSearching = false;
  String searchQuery = "";

  List<Offer> get filteredOffers {
    List<Offer> filtered =
        offers.where((offer) => offer.name.contains(searchQuery)).toList();
    return filtered == null ? [] : filtered;
  }

  void _startSearch() {
    ModalRoute.of(context)
        .addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearching));

    setState(() {
      _isSearching = true;
    });
  }

  void updateSearchQuery(String newQuery) {
    if (_isSearching) {
      setState(() {
        searchQuery = newQuery;
      });
    }
  }

  void _stopSearching() {
    _clearSearchQuery();

    setState(() {
      _isSearching = false;
    });
  }

  void _clearSearchQuery() {
    setState(() {
      _searchQueryController.clear();
      updateSearchQuery("");
    });
  }

  List<Widget> _buildActions() {
    if (_isSearching) {
      return <Widget>[
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            if (_searchQueryController == null ||
                _searchQueryController.text.isEmpty) {
              Navigator.pop(context);
              return;
            }
            _clearSearchQuery();
          },
        ),
      ];
    }

    return <Widget>[
      IconButton(
        icon: const Icon(Icons.search),
        onPressed: _startSearch,
      ),
    ];
  }

  @override
  initState() {
    super.initState();

//    getOffers();
  }

  void getOffers() async {
    Response merchantOffers = await VisaMerchantOffers.getMerchantOffers();

    var json = jsonDecode(merchantOffers.body);

    List<Offer> newOffers = new List<Offer>();
    for (var offer in json['Offers']) {
      String offerName = offer['merchantList'][0]["merchant"].toString();
      String description = offer['shareTitle'].toString();
      String sale = offer["offerTitle"].toString();
      String imageUrl = offer['merchantList'][0]['merchantImages'][0]
              ['fileLocation']
          .toString();

      Offer newOffer = new Offer(
          name: offerName,
          description: description,
          sale: sale,
          imageUrl: imageUrl,
          outletsNum: 1);
      newOffers.add(newOffer);
    }

    setState(() {
      offers = newOffers;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (offers == null) {
      return new Container();
    } else {
      return Column(
        children: <Widget>[
          SmallWhiteCard(
            height: MediaQuery.of(context).size.height / 4.15,
            width: double.infinity,
            childWidget: Column(
              children: [
                Row(
                  children: <Widget>[
                    Flexible(
                      child: TextField(
                        controller: _searchQueryController,
                        autofocus: true,
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          hintText: 'Search',
                          hintStyle: TextStyle(
                            color: Color(0xFFB2B2B2),
                          ),
                          fillColor: Color(0xFFEEEEEE),
                          filled: true,
                          border: new OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(10.0),
                            ),
                            borderSide: BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                            ),
                          ),
                        ),
                        onChanged: (query) => updateSearchQuery(query),
                      ),
                    ),
                    ..._buildActions(),
                  ],
                ),
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
                itemCount: filteredOffers.length,
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
                          backgroundImage:
                              AssetImage(filteredOffers[i].imageUrl == null ? 'assets/images/miniso.jpg' : filteredOffers[i].imageUrl),
                          radius: 30,
                        ),
                        title: Text(
                          filteredOffers[i].name,
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(filteredOffers[i].description),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Icon(
                                  Icons.local_offer,
                                  color: Theme.of(context).primaryColor,
                                ),
                                SizedBox(width: 3),
                                Text(filteredOffers[i].sale),
                              ],
                            ),
                            Text(
                              '${filteredOffers[i].outletsNum} offers around you',
                              style: TextStyle(
                                  color: mediumGreyColor, fontSize: 12),
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
}
