import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teguaz_app/providers/companies.dart';
import 'package:teguaz_app/providers/payment.dart';
import 'package:teguaz_app/providers/seat_reservation.dart';
import 'package:teguaz_app/providers/setting.dart';
import 'package:teguaz_app/providers/device.dart';
import 'package:teguaz_app/providers/trips.dart';
import 'package:teguaz_app/screens/company_detail_screen.dart';
import 'package:teguaz_app/screens/company_screen.dart';
import 'package:teguaz_app/screens/main_screen.dart';
import 'package:teguaz_app/screens/payment_screen.dart';
import 'package:teguaz_app/screens/register_passenger_screen.dart';
import 'package:teguaz_app/screens/search_screen.dart';
import 'package:teguaz_app/screens/ticket_screen.dart';
// import 'package:teguaz_app/screens/test.screen.dart';
import 'package:teguaz_app/screens/trip_detail_screen.dart';
import 'package:teguaz_app/widgets/about.dart';
import 'package:teguaz_app/widgets/change_setting.dart';
import 'package:teguaz_app/widgets/contact.dart';
import 'package:teguaz_app/widgets/guide.dart';
import 'package:teguaz_app/widgets/transaction_detail.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => Trips()),
        ChangeNotifierProvider(
            create: (_) => Setting()),
        ChangeNotifierProvider(
            create: (_) => Companies()),
        ChangeNotifierProvider(
            create: (_) => Device()),
        ChangeNotifierProvider(
            create: (_) => SeatReservation()),
        ChangeNotifierProvider(
            create: (_) => Payment()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Teguaz App',
        theme: ThemeData(
            primaryColor: Colors.deepPurple,
            textTheme: TextTheme(
                display4: TextStyle(
                    fontSize: 17,
                    fontWeight:
                        FontWeight.w500))),
        initialRoute: MainScreen.routeName,
        routes: {
          MainScreen.routeName: (_) =>
              MainScreen(),
          SearchScreen.routeName: (_) =>
              SearchScreen(),
          Guide.routeName: (_) => Guide(),
          About.routeName: (_) => About(),
          Contact.routeName: (_) => Contact(),
          TripDetailScreen.routeName: (_) =>
              TripDetailScreen(),
          ChangeSetting.routeName: (_) =>
              ChangeSetting(),
          CompanyScreen.routeName: (_) =>
              CompanyScreen(),
          CompanyDetailScreen.routeName: (_) =>
              CompanyDetailScreen(),
          RegisterPassenger.routeName: (_) =>
              RegisterPassenger(),
          PaymentScreen.routeName: (_) =>
              PaymentScreen(),
          TicketScreen.routeName: (_) =>
              TicketScreen()

          // TestScreen.routeName: (_) =>
          //     TestScreen()
          // TransactionDetail.routeName: (_) =>
          //     TransactionDetail()
        },
      ),
    );
  }
}
