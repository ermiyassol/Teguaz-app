import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teguaz_app/providers/companies.dart';
import 'package:teguaz_app/providers/setting.dart';
import 'package:teguaz_app/providers/trips.dart';

class TripDetailScreen extends StatelessWidget {
  static const routeName = '/trip-detail';

  Widget seatWidgetBuilder(int index) {
    return InkWell(
        onTap: () {},
        child: Container(
          width: 35,
          height: 25,
          margin: EdgeInsets.all(8),
          color: Colors.grey,
          child: Center(
            child: Text(
              (index + 1).toString(),
              style: TextStyle(
                  fontSize: 15,
                  color: Colors.white),
            ),
          ),
        ));
  }

  Widget cardBuilder(
      BuildContext context, String title) {
    return Container(
      height: 50,
      child: Card(
        elevation: 10,
        child: ListTile(
          tileColor:
              Theme.of(context).primaryColor,
          title: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
                height: 0,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final tripId = ModalRoute.of(context)
        .settings
        .arguments as String;
    final trip =
        Provider.of<Trips>(context, listen: false)
            .finadById(tripId);
    final languageIndex = Provider.of<Setting>(
            context,
            listen: false)
        .languageIndex;
    final companyName =
        Provider.of<Companies>(context)
            .getCompany(trip.companyId, 'name');
    final rowIndex =
        (((49 - 5) ~/ 4) + 1).toInt();
    // final startingPlaces =
    //     trip.startingPlace.map((place) {
    //   return place
    //       .toString()
    //       .split(' / ')
    //       .toList();
    // });
    List<List<String>> startingPlace = [];
    trip.startingPlace.forEach((place) {
      startingPlace.add(
          place.toString().split(' / ').toList());
    });
    print(startingPlace);

    return Scaffold(
      appBar: AppBar(
        title: Text(companyName),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              // Container(
              //   width: double.infinity,
              //   height: 300,
              //   child: ClipRRect(
              //     borderRadius:
              //         BorderRadius.circular(10),
              //     child: GridTile(
              //         child: GestureDetector(
              //           child: Image.network(
              //             company.logoUrl,
              //             fit: BoxFit.cover,
              //           ),
              //         ),
              //         footer: GridTileBar(
              //           backgroundColor:
              //               Colors.black87,
              //           title: Text(
              //             company.companyName
              //                 .toUpperCase(),
              //             textAlign:
              //                 TextAlign.center,
              //             style: TextStyle(
              //               fontSize: 20,
              //             ),
              //           ),
              //         )),
              //   ),
              // ),
              cardBuilder(
                  context, 'Detail Information'),
              Text(
                'Trip Date - ${trip.date[languageIndex]}',
                style: Theme.of(context)
                    .textTheme
                    .display4,
              ),
              Text(
                'Starting City - ${trip.startingCity[languageIndex]}',
                style: Theme.of(context)
                    .textTheme
                    .display4,
              ),
              Text(
                'Destination City - ${trip.destinationCity[languageIndex]}',
                style: Theme.of(context)
                    .textTheme
                    .display4,
              ),

              Text(
                'Bus No. - ${trip.busNo}',
                style: Theme.of(context)
                    .textTheme
                    .display4,
              ),
              Text(
                'Starting Time. - ${trip.time}',
                style: Theme.of(context)
                    .textTheme
                    .display4,
              ),
              Divider(),
              cardBuilder(
                  context, 'Starting Places'),
              Container(
                width: double.infinity,
                height: 50,
                child: ListView.builder(
                  itemCount:
                      trip.startingPlace.length,
                  scrollDirection:
                      Axis.horizontal,
                  itemBuilder:
                      (BuildContext context,
                          int index) {
                    return Padding(
                      padding:
                          const EdgeInsets.only(
                              right: 10),
                      child: InputChip(
                        elevation: 5,
                        avatar: Icon(
                          Icons.place,
                          color: Theme.of(context)
                              .primaryColor,
                        ),
                        label: Text(
                          startingPlace[index]
                              [languageIndex],
                          style: TextStyle(
                              color: Theme.of(
                                      context)
                                  .primaryColor,
                              fontWeight:
                                  FontWeight
                                      .bold),
                        ),
                        onSelected:
                            (bool value) {},
                      ),
                    );
                  },
                ),
              ),
              Divider(),
              cardBuilder(context, 'Seats'),
              Container(
                width: double.infinity,
                height: 300,
                padding: EdgeInsets.symmetric(
                    vertical: 10, horizontal: 55),
                child: ListView.builder(
                  itemCount: rowIndex,
                  itemBuilder: (_, index) {
                    if (index + 1 == rowIndex)
                      return Row(
                        children: [
                          seatWidgetBuilder(
                              (index * 4)),
                          seatWidgetBuilder(
                              (index * 4) + 1),
                          seatWidgetBuilder(
                              (index * 4) + 2),
                          seatWidgetBuilder(
                              (index * 4) + 3),
                          seatWidgetBuilder(
                              (index * 4) + 4),
                        ],
                      );
                    else
                      return Row(
                        children: [
                          seatWidgetBuilder(
                              (index * 4)),
                          seatWidgetBuilder(
                              (index * 4) + 1),
                          SizedBox(
                            width: 50,
                          ),
                          seatWidgetBuilder(
                              (index * 4) + 2),
                          seatWidgetBuilder(
                              (index * 4) + 3),
                        ],
                      );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
