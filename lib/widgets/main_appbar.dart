import 'package:flutter/material.dart';

class MainAppBar extends StatelessWidget {
  // const MainAppBar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text('Teguaz App'),
      actions: [
        IconButton(
            icon: Icon(Icons.search),
            onPressed: () {}),
        PopupMenuButton(
          icon: Icon(Icons.more_vert),
          itemBuilder: (_) => [
            PopupMenuItem(
              child: FlatButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.settings),
                  label: Text('setting')),
            ),
            PopupMenuItem(
              child: Text('Show All'),
            )
          ],
        ),
        IconButton(
            icon: Icon(Icons.login),
            onPressed: () {})
      ],
    );
  }
}
