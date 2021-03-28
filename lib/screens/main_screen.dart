import 'package:flutter/material.dart';
import 'package:teguaz_app/widgets/main_appbar.dart';

class MainScreen extends StatelessWidget {
  // const MainScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
      ),
      drawer: Drawer(),
      body: Container(),
    );
  }
}
