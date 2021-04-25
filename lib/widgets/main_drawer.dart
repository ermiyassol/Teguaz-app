import 'package:flutter/material.dart';
import 'package:teguaz_app/screens/company_screen.dart';
import 'package:teguaz_app/screens/main_screen.dart';
import 'package:teguaz_app/widgets/change_setting.dart';

enum drawerList {
  destination,
  company,
  trip,
  account,
  sellTicket
}

class MainDrawer extends StatelessWidget {
  // const MainDrawer({Key key}) : super(key: key);
  var selectedListVal = drawerList.trip;
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
                        onPressed: () {
                          Navigator.of(context)
                              .pushNamed(
                                  ChangeSetting
                                      .routeName);
                        }),
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
            height: 10,
          ),
          Column(
            children: [
              Container(
                height: MediaQuery.of(context)
                        .size
                        .height *
                    0.65,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ListTile(
                        title: Text(
                          'Trips',
                          style: TextStyle(
                              fontSize: 16),
                        ),
                        leading:
                            Icon(Icons.add_road),
                        // selected:
                        //     selectedListVal ==
                        //         drawerList.trip,
                        onTap: () {
                          selectedListVal =
                              drawerList.trip;
                          Navigator.of(context)
                              .pushReplacementNamed(
                                  MainScreen
                                      .routeName);
                        },
                      ),
                      // Divider(),
                      ListTile(
                        title: Text(
                          'Destination',
                          style: TextStyle(
                              fontSize: 16),
                        ),
                        leading: Icon(
                            Icons.location_on),
                        // selected:
                        //     selectedListVal ==
                        //         drawerList
                        // .destination,
                        onTap: () {
                          selectedListVal =
                              drawerList
                                  .destination;
                        },
                      ),
                      ListTile(
                        title: Text(
                          'Company',
                          style: TextStyle(
                              fontSize: 16),
                        ),
                        leading:
                            Icon(Icons.add_road),
                        // selected:
                        //     selectedListVal ==
                        //         drawerList
                        // .company,
                        onTap: () {
                          selectedListVal =
                              drawerList.company;
                          Navigator.of(context)
                              .pushReplacementNamed(
                                  CompanyScreen
                                      .routeName);
                        },
                      ),
                      // Divider(),
                      ListTile(
                        title: Text(
                          'Sell Ticket',
                          style: TextStyle(
                              fontSize: 16),
                        ),
                        leading:
                            Icon(Icons.label),
                        // selected:
                        //     selectedListVal ==
                        //         drawerList
                        // .sellTicket,
                        onTap: () {
                          selectedListVal =
                              drawerList
                                  .sellTicket;
                        },
                      ),
                      // Divider(),
                      ListTile(
                        title: Text(
                          'Account',
                          style: TextStyle(
                              fontSize: 16),
                        ),
                        leading: Icon(Icons
                            .account_circle_outlined),
                        // selected:
                        //     selectedListVal ==
                        //         drawerList
                        // .account,
                        onTap: () {
                          selectedListVal =
                              drawerList.account;
                        },
                      ),
                      // Divider(),
                    ],
                  ),
                ),
              ),
              Text(
                'Traveler App for Android\nV1.0.0 universal',
                textAlign: TextAlign.center,
              )
            ],
          )
        ],
      ),
    );
  }
}
