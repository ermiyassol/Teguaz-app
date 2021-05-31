import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teguaz_app/providers/companies.dart';
import 'package:teguaz_app/providers/device.dart';
import 'package:teguaz_app/providers/payment.dart';
import 'package:teguaz_app/providers/trips.dart';
import 'package:teguaz_app/screens/trip_list_screen.dart';
import 'package:teguaz_app/widgets/main_appbar.dart';
import 'package:teguaz_app/widgets/main_drawer.dart';

class MainScreen extends StatefulWidget {
  static const routeName = '/home-screen';

  @override
  _MainScreenState createState() =>
      _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  var isLoading = true;
  @override
  void initState() {
    super.initState();
    Provider.of<Device>(context, listen: false)
        .getImei()
        .then((imei) {
      Provider.of<Companies>(context,
              listen: false)
          .fetchAndSetCompany()
          .then((_) {
        Provider.of<Trips>(context, listen: false)
            .fetchAndSetTrips(imei)
            .then((_) => setState(() {
                  isLoading = false;
                }));
      });
      // final tripProvider = Provider.of<Trips>(
      //     context,
      //     listen: false);
      // if (!tripProvider.isTripLoaded()) {
      //   setState(() {
      //     isLoading = true;
      //   });
      //   tripProvider
      //       .fetchAndSetTrips()
      //       .then((_) => setState(() {
      //             isLoading = false;
      //           }));
      // }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar('Teguaz App'),
      drawer: MainDrawer(),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(
                valueColor:
                    new AlwaysStoppedAnimation(
                        Theme.of(context)
                            .primaryColor),
              ),
            )
          : TripListScreen(),
    );
  }
}
