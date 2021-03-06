import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teguaz_app/providers/companies.dart';
import 'package:teguaz_app/providers/trips.dart';
import 'package:teguaz_app/widgets/trip_list.dart';

class TripListScreen extends StatelessWidget {
  final String companyId;
  final String searchingText;
  TripListScreen(
      {this.companyId = '',
      this.searchingText = ''});
  @override
  Widget build(BuildContext context) {
    print(searchingText);
    final tripsList = Provider.of<Trips>(context)
        .trips(
            companyId: companyId,
            searchingText: searchingText);
    return Container(
        padding: EdgeInsets.symmetric(
            horizontal: 10, vertical: 10),
        child: ListView.builder(
          itemBuilder: (_, index) {
            return ChangeNotifierProvider.value(
              value: tripsList[index],
              child: TripList(),
            );
          },
          itemCount: tripsList.length,
        ));
  }
}
