import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teguaz_app/providers/companies.dart';
import 'package:teguaz_app/screens/trip_detail_screen.dart';
import 'package:teguaz_app/screens/trip_list_screen.dart';

class CompanyDetailScreen extends StatefulWidget {
  static const routeName = '/company-detail';

  @override
  _CompanyDetailScreenState createState() =>
      _CompanyDetailScreenState();
}

class _CompanyDetailScreenState
    extends State<CompanyDetailScreen> {
  var viewTrip = false;
  @override
  Widget build(BuildContext context) {
    final companyId = ModalRoute.of(context)
        .settings
        .arguments as String;
    final company =
        Provider.of<Companies>(context)
            .finadById(companyId);

    return Scaffold(
      appBar: AppBar(
        title: Text('Company Detail'),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                height: 300,
                child: ClipRRect(
                  borderRadius:
                      BorderRadius.circular(10),
                  child: GridTile(
                      child: GestureDetector(
                        child: Image.network(
                          company.logoUrl,
                          fit: BoxFit.cover,
                        ),
                      ),
                      footer: GridTileBar(
                        backgroundColor:
                            Colors.black87,
                        title: Text(
                          company.companyName
                              .toUpperCase(),
                          textAlign:
                              TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      )),
                ),
              ),
              Container(
                height: 50,
                child: Card(
                  elevation: 10,
                  child: ListTile(
                    tileColor: Theme.of(context)
                        .primaryColor,
                    title: Text(
                      'Detail Information',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          height: 0,
                          color: Colors.white,
                          fontWeight:
                              FontWeight.bold,
                          fontSize: 18),
                    ),
                  ),
                ),
              ),
              Text(
                'Head Office City - ${company.headOffice}',
                style: Theme.of(context)
                    .textTheme
                    .display4,
              ),
              Text(
                'Number Of Destinations - ${company.place.length}',
                style: Theme.of(context)
                    .textTheme
                    .display4,
              ),
              Text(
                'Phone Number - ${company.phoneNumber}',
                style: Theme.of(context)
                    .textTheme
                    .display4,
              ),
              Text(
                'website - ${company.website}',
                style: Theme.of(context)
                    .textTheme
                    .display4,
              ),
              Divider(),
              Container(
                height: 50,
                child: Card(
                  elevation: 10,
                  child: ListTile(
                    tileColor: Theme.of(context)
                        .primaryColor,
                    title: Text(
                      viewTrip
                          ? 'Hide Trips'
                          : 'View Trips',
                      style: TextStyle(
                          height: 0,
                          color: Colors.white,
                          fontWeight:
                              FontWeight.bold,
                          fontSize: 18),
                    ),
                    trailing: Column(
                      children: [
                        viewTrip
                            ? Icon(
                                Icons
                                    .arrow_drop_up,
                                color:
                                    Colors.white,
                                size: 30,
                              )
                            : Icon(
                                Icons
                                    .arrow_drop_down,
                                color:
                                    Colors.white,
                                size: 30,
                              ),
                      ],
                    ),
                    onTap: () {
                      setState(() {
                        viewTrip = !viewTrip;
                      });
                    },
                  ),
                ),
              ),
              if (viewTrip)
                Container(
                    height: 200,
                    child: TripListScreen())
            ],
          ),
        ),
      ),
    );
  }
}
