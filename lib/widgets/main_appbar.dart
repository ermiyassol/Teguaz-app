import 'package:flutter/material.dart';

class MainAppBar extends StatelessWidget
    with PreferredSizeWidget {
  // const MainAppBar({Key key}) : super(key: key);

  @override
  // TODO: implement preferredSize
  Size get preferredSize =>
      Size.fromHeight(kToolbarHeight);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text('Teguaz App'),
      actions: [
        IconButton(
            icon: Icon(Icons.search),
            onPressed: () {}),
        PopupMenuButton(
          icon: Icon(Icons.settings),
          itemBuilder: (_) => [
            PopupMenuItem(
              child: FlatButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons
                      .supervised_user_circle_sharp),
                  label: Text(
                    'setting',
                    style:
                        TextStyle(fontSize: 18),
                  )),
            ),
            PopupMenuItem(
              child: FlatButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.settings),
                  label: Text(
                    'setting',
                    style:
                        TextStyle(fontSize: 18),
                  )),
            ),
          ],
        ),
        IconButton(
            icon: Icon(Icons.login),
            onPressed: () {})
      ],
    );
  }
}
