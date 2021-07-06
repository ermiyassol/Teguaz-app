import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teguaz_app/providers/device.dart';
import 'package:teguaz_app/providers/payment.dart';
import 'package:teguaz_app/providers/trips.dart';
// import 'package:teguaz_app/screens/login_screen.dart';
import 'package:teguaz_app/screens/search_screen.dart';
// import 'package:teguaz_app/screens/test.screen.dart';
import 'package:teguaz_app/widgets/about.dart';
import 'package:teguaz_app/widgets/change_setting.dart';
import 'package:teguaz_app/widgets/contact.dart';
import 'package:teguaz_app/widgets/guide.dart';

enum filterValues {
  language,
  contact,
  about,
  guide
}

class MainAppBar extends StatelessWidget
    with PreferredSizeWidget {
  final String title;
  MainAppBar(this.title);
  // const MainAppBar({Key key}) : super(key: key);

  @override
  // TODO: implement preferredSize
  Size get preferredSize =>
      Size.fromHeight(kToolbarHeight);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
      ),
      actions: [
        IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              Navigator.of(context).pushNamed(
                  SearchScreen.routeName);
            }),
        PopupMenuButton(
          onSelected: (selectedVal) {
            if (selectedVal ==
                filterValues.guide) {
              Navigator.of(context)
                  .pushNamed(Guide.routeName);
            } else if (selectedVal ==
                filterValues.about) {
              Navigator.of(context)
                  .pushNamed(About.routeName);
            } else if (selectedVal ==
                filterValues.contact) {
              Navigator.of(context)
                  .pushNamed(Contact.routeName);
            } else if (selectedVal ==
                filterValues.language) {
              Navigator.of(context).pushNamed(
                  ChangeSetting.routeName);
            }
          },
          icon: Icon(Icons.more_vert),
          itemBuilder: (_) => [
            PopupMenuItem(
              child: Text('Change Setting'),
              value: filterValues.language,
            ),
            PopupMenuItem(
              child: Text('Contact'),
              value: filterValues.contact,
            ),
            PopupMenuItem(
              child: Text('About'),
              value: filterValues.about,
            ),
            PopupMenuItem(
              child: Text('Guide'),
              value: filterValues.guide,
            )
          ],
        ),
        // IconButton(
        //     icon: Icon(Icons.login),
        //     onPressed: () {})
      ],
    );
  }
}
