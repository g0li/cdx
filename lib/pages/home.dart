import 'dart:convert';

import 'package:coindcx/market_list.dart';
import 'package:coindcx/model/cdx.dart';
import 'package:coindcx/services/cdx_service.dart';
import 'package:coindcx/widget/cdx_appbar.dart';
import 'package:coindcx/widget/cdx_chippy.dart';
import 'package:coindcx/widget/cdx_market_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  static const routeName = 'homePage';
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  CoinDCXService _cds = CoinDCXService();
  List tickerList = [];
  List sortedMList = [];
  List<String> _mlStr = [];
  List<String> _bcsnStr = [];

  @override
  Widget build(BuildContext context) {
    final marketList = Provider.of<MarketList>(context);
    for (var item in marketList.list) {
      _mlStr.add(item.coindcx_name);
      _bcsnStr.add(item.base_currency_short_name);
    }
    return Scaffold(
      appBar: CDXAppBar(),
      body: SingleChildScrollView(
        primary: true,
        child: Container(
          color: Colors.blueGrey.shade600,
          child: Column(
            children: <Widget>[
              marketList.list.length > 0
                  ? Column(
                      children: <Widget>[
                        CDXChippy(
                          _mlStr,
                          onSelectionChanged: (selectedList) {
                            Provider.of<MarketList>(context, listen: false)
                                .sortByMarket(selectedList);
                          },
                        ),
                        Container(
                          color: Colors.transparent,
                          child: Column(
                            children: <Widget>[
                              Divider(),
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 8),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    RaisedButton(
                                      color: Colors.blueGrey,
                                      onPressed: () {
                                        Provider.of<MarketList>(context,
                                                listen: false)
                                            .sortName();
                                      },
                                      child: Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 16, vertical: 8),
                                        child: Text(
                                          'COIN NAME',
                                          style:
                                              TextStyle(color: Colors.white60),
                                        ),
                                      ),
                                    ),
                                    RaisedButton(
                                      color: Colors.blueGrey,
                                      onPressed: () {
                                        Provider.of<MarketList>(context,
                                                listen: false)
                                            .sort24();
                                      },
                                      child: Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 16, vertical: 8),
                                        child: Text('24h Change',
                                            style: TextStyle(
                                                color: Colors.white60)),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Divider(),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 8),
                          child: ListView.builder(
                            itemBuilder: (ctx, i) {
                              return CDXMarketItem(
                                  mItem: marketList.list[i],
                                  showCard: showCard);
                            },
                            itemCount: marketList.list.length,
                            shrinkWrap: true,
                            primary: false,
                          ),
                        )
                      ],
                    )
                  : Container()
            ],
          ),
        ),
      ),
    );
  }

  void showCard(ctx, CDX mItem) {
    showModalBottomSheet(
        context: ctx,
        builder: (ctx) {
          return Container(
            // height: MediaQuery.of(context).size.height*.5,
            color: Colors.black54,

            child: Column(children: <Widget>[
              AppBar(
                  automaticallyImplyLeading: false,
                  title: Row(
                    children: <Widget>[
                      Flexible(
                        flex: 2,
                        child: SvgPicture.network(
                          mItem.logo,
                          placeholderBuilder: (BuildContext context) =>
                              Container(
                                  padding: const EdgeInsets.all(30.0),
                                  child: const CircularProgressIndicator()),
                        ),
                      ),
                      Flexible(
                        flex: 8,
                        child: Container(
                          margin: EdgeInsets.only(left: 16),
                          child: Text(
                            mItem.target_currency_name,
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ),
                      )
                    ],
                  )),
              Container(
                width: MediaQuery.of(context).size.width,
                // height: MediaQuery.of(context).size.height,
                margin: EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Flexible(
                          flex: 8,
                          fit: FlexFit.tight,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Last Traded Price',
                                style: TextStyle(
                                    fontSize: 10, color: Colors.white),
                              ),
                              Text(mItem.last_price + ' BTC',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white)),
                            ],
                          ),
                        ),
                        Flexible(
                          flex: 4,
                          fit: FlexFit.tight,
                          child: mItem.change_24_hour
                                  .toString()
                                  .startsWith('-', 0)
                              ? FlatButton(
                                  color: coloRed(
                                      double.parse(mItem.change_24_hour)),
                                  child: Text(mItem.change_24_hour + '%',
                                      style: TextStyle(color: Colors.white)),
                                  onPressed: () {
                                    print(mItem.change_24_hour
                                        .toString()
                                        .substring(0));
                                  },
                                )
                              : FlatButton(
                                  color: colorGreen(
                                      double.parse(mItem.change_24_hour)),
                                  child: Text('+' + mItem.change_24_hour + '%',
                                      style: TextStyle(color: Colors.white)),
                                  onPressed: () {
                                    showCard(context, mItem);
                                    print(mItem.change_24_hour
                                        .toString()
                                        .substring(0));
                                  },
                                ),
                        )
                      ],
                    ),
                    Divider(
                      color: Colors.white60,
                    ),
                    Row(
                      children: <Widget>[
                        Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  '24H HIGH',
                                  style: TextStyle(
                                      fontSize: 10, color: Colors.white60),
                                ),
                                Text(mItem.high,
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.white)),
                              ],
                            ),
                            fit: FlexFit.tight,
                            flex: 1),
                        Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  '24H LOW',
                                  style: TextStyle(
                                      fontSize: 10, color: Colors.white60),
                                ),
                                Text(mItem.low,
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.white)),
                              ],
                            ),
                            fit: FlexFit.tight,
                            flex: 1),
                      ],
                    )
                  ],
                ),
              )
            ]),
          );
        });
  }

  Color coloRed(item) {
    if (item <= 1.0 && item >= 0.8) {
      return Colors.red.shade800;
    } else if (item < .8 && item >= 0.6) {
      return Colors.red.shade700;
    } else if (item < .6 && item >= 0.4) {
      return Colors.red.shade600;
    } else if (item < .4 && item >= 0.2) {
      return Colors.red.shade500;
    } else {
      return Colors.red.shade400;
    }
  }

  Color colorGreen(item) {
    if (item <= 1.0 && item >= 0.8) {
      return Colors.green.shade800;
    } else if (item < .8 && item >= 0.6) {
      return Colors.green.shade700;
    } else if (item < .6 && item >= 0.4) {
      return Colors.green.shade600;
    } else if (item < .4 && item >= 0.2) {
      return Colors.green.shade500;
    } else {
      return Colors.green.shade400;
    }
  }
}
