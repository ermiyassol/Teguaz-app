import 'package:flutter/material.dart';

class TripList extends StatelessWidget {
  const TripList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: ListTile(
        onTap: () {},
        leading: CircleAvatar(
          backgroundColor:
              Theme.of(context).primaryColor,
          child: Text('L'),
        ),
        title: Text('Addis Ababa - Dire Dawa'),
        subtitle: Text('mon jan - 12 - 2012'),
        trailing: Icon(
          Icons.chevron_right,
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}
