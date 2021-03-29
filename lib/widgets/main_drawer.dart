import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            color: Theme.of(context).primaryColor,
            padding: EdgeInsets.only(
                top: (MediaQuery.of(context)
                        .padding
                        .top +
                    10),
                left: 20,
                bottom: 10),
            child: Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: AssetImage(
                          'assets/images/logo.jpg'),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'ተጓዥ',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18),
                    ),
                    Text(
                      '0939866118',
                      style: TextStyle(
                          color: Colors.white),
                    )
                  ],
                ),
                Column(
                  children: [
                    SizedBox(
                      height: 35,
                    ),
                    IconButton(
                        color: Colors.white,
                        icon:
                            Icon(Icons.settings),
                        onPressed: () {}),
                    IconButton(
                        color: Colors.white,
                        icon: Icon(
                          Icons
                              .keyboard_arrow_down,
                          size: 35,
                        ),
                        onPressed: () {}),
                  ],
                )
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          ListTile(
            title: Text('Primary text'),
            leading: Icon(Icons.label),
            trailing: Text('Metadata'),
          ),
          ListTile(
            title: Text('Primary text'),
            leading: Icon(Icons.label),
            trailing: Text('Metadata'),
          ),
        ],
      ),
    );
  }
}
