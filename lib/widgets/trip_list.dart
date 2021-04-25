import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teguaz_app/providers/companies.dart';
import 'package:teguaz_app/providers/setting.dart';
import 'package:teguaz_app/providers/trip.dart';
import 'package:teguaz_app/screens/trip_detail_screen.dart';

class TripList extends StatelessWidget {
  // const TripList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final trip = Provider.of<Trip>(context);
    final companyLogo =
        Provider.of<Companies>(context)
            .getCompany(trip.companyId, 'logo');
    final languageIndex =
        Provider.of<Setting>(context)
            .languageIndex;
    return Card(
      elevation: 3,
      child: ListTile(
        onTap: () {
          Navigator.of(context).pushNamed(
              TripDetailScreen.routeName,
              arguments: trip.tripId);
        },
        leading: CircleAvatar(
          // maxRadius: 50,
          backgroundImage: NetworkImage(
            companyLogo,
          ),
        ),
        title: Text(
            '${trip.startingCity[languageIndex]} - ${trip.destinationCity[languageIndex]}'),
        subtitle: Text(trip.date[languageIndex]),
        trailing: Icon(
          Icons.chevron_right,
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}
