import 'package:flutter/material.dart';
import 'package:promogo/services/database.dart';

import '../../models/offer.dart';
import '../../shared/constants.dart';
import '../../widgets/small_white_card.dart';
import 'payments.dart';

enum Filter {
  all,
  targeted,
}

class Offers extends StatefulWidget {
  static const routeName = '/offers';

  @override
  _OffersState createState() => _OffersState();
}

class _OffersState extends State<Offers> {
  var filter = Filter.all;
  List<Offer> offers = [
    Offer(
      name: 'Miniso',
//      description: 'Electronics & Technology | Home & Furnishing | Junction 8',
      code: 'MINISO50',
      sale: '50% discount off stationery',
      expiryDate: DateTime(2020, 12, 31, 23, 59),
    ),
    Offer(
      name: 'Miniso',
      code: 'MINISO50',
      sale: '50% discount off stationery',
      expiryDate: DateTime(2020, 12, 31, 23, 59),
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

  void getOffers(merchantName) async {
    List<Offer> newOffers = new List<Offer>();
    var promoList = await DatabaseService().getPromoList;
    for (var promo in promoList) {
      if (promo.merchant.name == merchantName) {
        Offer newOffer = new Offer(
            name: merchantName,
            sale: promo.discount.toString(),
            expiryDate: promo.expiryDate,
            code: promo.promoCode,
            imageUrl: promo.merchant.url);
        newOffers.add(newOffer);
      }
    }
    setState(() {
      offers = newOffers;
    });
  }

  @override
  Widget build(BuildContext context) {
    var merchantName = ModalRoute.of(context).settings.arguments;
    getOffers(merchantName);

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
                          backgroundImage: AssetImage(
                              filteredOffers[i].imageUrl == null
                                  ? 'assets/images/miniso.jpg'
                                  : filteredOffers[i].imageUrl),
                          radius: 30,
                        ),
                        title: Text(
                          filteredOffers[i].name,
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('Promo Code: ${filteredOffers[i].code}'),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Icon(
                                  Icons.local_offer,
                                  color: Theme
                                      .of(context)
                                      .primaryColor,
                                ),
                                SizedBox(width: 3),
                                Text(filteredOffers[i].sale),
                              ],
                            ),
                            Text(
                              'Expired Date: ${filteredOffers[i].expiryDate}',
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
