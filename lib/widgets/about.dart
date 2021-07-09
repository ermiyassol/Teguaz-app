import 'package:flutter/material.dart';

class About extends StatelessWidget {
  static const routeName = '/about';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Us'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(
            horizontal: 10, vertical: 20),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.center,
          children: [
            Text(
                'A Software Project Submitted to the Department Of Computer Science Of Assosa University In Partial Fulfillment Of Requirements For The Degree Of Bachelor Of Science In Computer Science'),
            Divider(),
            Text('PrePared By:'),
            Text('Ermiyas Solomon'),
            Text('Hashim Bedewie'),
            Text('Amarech Birhan'),
            Text(
              'Version 1.0',
              textAlign: TextAlign.start,
            )
          ],
        ),
      ),
    );
  }
}
