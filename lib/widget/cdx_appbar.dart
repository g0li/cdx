import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../market_list.dart';

class CDXAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.blueGrey,
      automaticallyImplyLeading: false,
      title: Text('MARKETS'),
      centerTitle: true,
      actions: <Widget>[
        GestureDetector(
          onTap: () {
            Provider.of<MarketList>(context, listen: false).clear();
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Icon(Icons.menu, size: 32),
          ),
        )
      ],
    );
  }

  @override
  Size get preferredSize => new Size.fromHeight(60);
}
