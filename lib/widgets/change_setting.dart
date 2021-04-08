import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/setting.dart';

class ChangeSetting extends StatelessWidget {
  static const routeName = '/language-setting';

  @override
  Widget build(BuildContext context) {
    final language =
        Provider.of<Setting>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Setting'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(
            vertical: 20, horizontal: 10),
        width: double.infinity,
        child: Card(
          elevation: 2,
          child: SwitchListTile(
              value: language.isAmharic,
              title: Text(
                language.isAmharic
                    ? 'ቋንቋ ቀይር'
                    : 'Change Language',
                style: TextStyle(
                    fontWeight: FontWeight.bold),
              ),
              subtitle: Text(language.isAmharic
                  ? 'ወደ እንግሊዘኛ'
                  : 'to Amharic'),
              onChanged: (currentVal) {
                language
                    .changeLanguage(currentVal);
              }),
        ),
      ),
    );
  }
}
