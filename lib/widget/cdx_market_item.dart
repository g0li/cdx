import 'package:coindcx/model/cdx.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CDXMarketItem extends StatelessWidget {
  CDX mItem;
  Function showCard;
  CDXMarketItem({this.mItem, this.showCard});
  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      child: Column(
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: SizedBox(
                  width: 40,
                  height: 40,
                  child: Container(
                    margin: EdgeInsets.all(4),
                    child: SvgPicture.network(
                      mItem.logo,
                      placeholderBuilder: (BuildContext context) => Container(
                          padding: const EdgeInsets.all(30.0),
                          child: const CircularProgressIndicator()),
                    ),
                  ),
                ),
              ),
              Flexible(
                flex: 5,
                fit: FlexFit.tight,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        mItem.target_currency_name,
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      Text(mItem.last_price + ' BTC',
                          style: TextStyle(color: Colors.white, fontSize: 10)),
                    ]),
              ),
              Flexible(
                flex: 3,
                fit: FlexFit.tight,
                child: mItem.change_24_hour.toString().startsWith('-', 0)
                    ? FlatButton(
                        color: coloRed(double.parse(mItem.change_24_hour)),
                        child: Text(mItem.change_24_hour + '%',
                            style: TextStyle(color: Colors.white)),
                        onPressed: () {
                          print(mItem.change_24_hour.toString().substring(0));
                        },
                      )
                    : FlatButton(
                        color: colorGreen(double.parse(mItem.change_24_hour)),
                        child: Text('+' + mItem.change_24_hour + '%',
                            style: TextStyle(color: Colors.white)),
                        onPressed: () {
                          showCard(context, mItem);
                          print(mItem.change_24_hour.toString().substring(0));
                        },
                      ),
              )
            ],
          ),
          Divider()
        ],
      ),
    );
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
