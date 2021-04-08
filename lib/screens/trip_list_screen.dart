import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teguaz_app/providers/trips.dart';
import 'package:teguaz_app/widgets/trip_list.dart';

class TripListScreen extends StatefulWidget {
  const TripListScreen({Key key})
      : super(key: key);

  @override
  _TripListScreenState createState() =>
      _TripListScreenState();
}

class _TripListScreenState
    extends State<TripListScreen> {
  var isLoading = false;
  @override
  void initState() {
    super.initState();
    setState(() {
      isLoading = true;
    });
    Provider.of<Trips>(context, listen: false)
        .fetchAndSetTrips()
        .then((_) => setState(() {
              isLoading = false;
            }));
  }

  @override
  Widget build(BuildContext context) {
    final tripsList =
        Provider.of<Trips>(context, listen: false)
            .trips;
    return isLoading
        ? Center(
            child: CircularProgressIndicator(
              valueColor:
                  new AlwaysStoppedAnimation(
                      Theme.of(context)
                          .primaryColor),
            ),
          )
        : Container(
            padding: EdgeInsets.symmetric(
                horizontal: 10, vertical: 10),
            child: ListView.builder(
              itemBuilder: (_, index) {
                return ChangeNotifierProvider
                    .value(
                  value: tripsList[index],
                  child: TripList(),
                );
              },
              itemCount: tripsList.length,
            ));
  }
}