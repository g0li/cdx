import 'dart:convert';
import 'package:coindcx/model/cdx.dart';
import 'package:http/http.dart' as http;

class CoinDCXService {
  var client = new http.Client();

  Future<List<CDX>> getMarketDetails() {
    List marketDetails = [];
    List tickers = [];
    List<CDX> cDXList = [];

    return http
        .get('https://api.coindcx.com/exchange/v1/markets_details')
        .then((value) {
      marketDetails = jsonDecode(value.body.toString());
      return http.get('https://api.coindcx.com/exchange/ticker').then((value) {
        tickers = jsonDecode(value.body.toString());
        CDX _cDX;
        for (var item in marketDetails) {
          _cDX = new CDX();
          _cDX.target_currency_name = item['target_currency_name'];
          _cDX.logo = 'https://coindcx.com/assets/coins/' +
              item['target_currency_short_name'] +
              '.svg';
          _cDX.coindcx_name = item['coindcx_name'];
          _cDX.base_currency_short_name = item['base_currency_short_name'];

          for (var item1 in tickers) {
            if (item1['market'].toString() == item['coindcx_name'].toString()) {
              _cDX.change_24_hour = item1['change_24_hour'];
              _cDX.high = item1['high'];
              _cDX.low = item1['low'];
              _cDX.last_price = item1['last_price'];
            }
          }
          cDXList.add(_cDX);
        }
        return cDXList;
      });
    });
  }
}
