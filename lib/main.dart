import 'package:coindcx/market_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'pages/home.dart';
import 'pages/splash.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CoinDCX',
      theme: ThemeData(
        primaryColor: Colors.blueGrey,
      ),
      home: SplashPage(),
      routes: {
        SplashPage.routeName: (ctx) => SplashPage(),
        HomePage.routeName: (ctx) =>
            ChangeNotifierProvider<MarketList>(create: (context)=>MarketList(),
            child: HomePage()),
      },
    );
  }
}
