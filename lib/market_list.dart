import 'package:coindcx/model/cdx.dart';
import 'package:coindcx/services/cdx_service.dart';
import 'package:flutter/foundation.dart';

class MarketList with ChangeNotifier {
  List<CDX> list = [];
  List<CDX> list2 = [];
  CoinDCXService _cds = CoinDCXService();
  bool isAsc = true;
  bool isAsc24 = false;
  MarketList() {
    _cds.getMarketDetails().then((value) {
      print(value.length.toString());
      list = [];
      list = value;
      list2 = value;
    });
  }
  void ascendingName() {
    isAsc = true;
    list.sort((a, b) =>
        a.coindcx_name.toString().compareTo(b.coindcx_name.toString()));
    notifyListeners();
  }

  void sortByMarket(item) {
    list = list2;
    list = list.where((element) {
      print(element.coindcx_name.toString() == item.toString());
      return element.coindcx_name.toString() == item.toString();
    }).toList();
    notifyListeners();
  }

  void clear() {
    list = list2;
    notifyListeners();
  }

  void descendingName() {
    isAsc = false;
    list.sort((a, b) =>
        b.coindcx_name.toString().compareTo(a.coindcx_name.toString()));
    notifyListeners();
  }

  void sortName() {
    if (isAsc)
      descendingName();
    else
      ascendingName();
  }

  void ascendingChange() {
    isAsc24 = true;
    list.sort((a, b) => double.parse(a.change_24_hour.toString())
        .compareTo(double.parse(b.change_24_hour.toString())));
    notifyListeners();
  }

  void descendingChange() {
    isAsc24 = false;
    list.sort((a, b) => double.parse(b.change_24_hour.toString())
        .compareTo(double.parse(a.change_24_hour.toString())));
    notifyListeners();
  }

  void sort24() {
    if (isAsc24)
      descendingChange();
    else
      ascendingChange();
  }
}
