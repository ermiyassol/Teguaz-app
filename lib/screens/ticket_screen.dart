import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teguaz_app/providers/companies.dart';
import 'package:teguaz_app/providers/seat_reservation.dart';
import 'package:teguaz_app/providers/setting.dart';
import 'package:teguaz_app/providers/trips.dart';
import 'package:teguaz_app/screens/payment_screen.dart';
import 'package:teguaz_app/widgets/main_appbar.dart';
import 'package:teguaz_app/widgets/main_drawer.dart';

class TicketScreen extends StatefulWidget {
  static const routeName = '/ticket-screen';

  @override
  _TicketScreenState createState() =>
      _TicketScreenState();
}

class _TicketScreenState
    extends State<TicketScreen> {
  final style = TextStyle(
      fontSize: 17, fontWeight: FontWeight.w500);
  int collapseIndex;

  @override
  Widget build(BuildContext context) {
    final upComingTrips =
        Provider.of<Trips>(context)
            .upComingTripsList;
    final languageIndex =
        Provider.of<Setting>(context)
            .languageIndex;

    return Scaffold(
        appBar: MainAppBar('Tickets List'),
        drawer: MainDrawer(),
        body: Container(
          child: ListView.builder(
              itemCount: upComingTrips.length,
              itemBuilder: (_, index) {
                final company =
                    Provider.of<Companies>(
                            context,
                            listen: false)
                        .getCompany(
                            upComingTrips[index]
                                ['companyId'],
                            'both');
                return Container(
                  // height: 200,

                  // width: double.infinity,
                  child: Column(
                    // crossAxisAlignment:
                    //     CrossAxisAlignment.start,
                    children: [
                      Card(
                        elevation: 5,
                        child: ListTile(
                          selected:
                              collapseIndex ==
                                  index,
                          selectedTileColor:
                              Colors.grey,
                          onTap: () {
                            setState(() {
                              if (collapseIndex ==
                                  index) {
                                collapseIndex =
                                    null;
                              } else {
                                collapseIndex =
                                    index;
                              }
                            });
                          },
                          leading: CircleAvatar(
                            // maxRadius: 50,
                            backgroundImage:
                                NetworkImage(
                              company['logo'],
                            ),
                          ),
                          title: Text(
                              '${company['name']} Ticket'),
                          subtitle: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment
                                    .start,
                            children: [
                              Text(
                                '${upComingTrips[index]['startingCity'][languageIndex]} - ${upComingTrips[index]['destinationCity'][languageIndex]}',
                              ),
                              Text(
                                '${upComingTrips[index]['date'][languageIndex]} @${upComingTrips[index]['time']}',
                              )
                            ],
                          ),
                          trailing: IconButton(
                              icon: Icon(
                                collapseIndex ==
                                        index
                                    ? Icons
                                        .arrow_drop_up
                                    : Icons
                                        .arrow_drop_down,
                                size: 30,
                                color: Theme.of(
                                        context)
                                    .primaryColor,
                              ),
                              onPressed: () {}),
                        ),
                      ),
                      if (collapseIndex == index)
                        Text(
                          'More Detail',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight:
                                  FontWeight.bold,
                              decoration:
                                  TextDecoration
                                      .underline),
                        ),
                      if (collapseIndex == index)
                        Container(
                          padding: EdgeInsets
                              .symmetric(
                                  // vertical: 5,
                                  horizontal: 10),
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment
                                    .start,
                            children: [
                              Text(
                                'Passenger Name - ${upComingTrips[index]['fullName']}',
                                style: style,
                              ),
                              Text(
                                'Phone Number - ${upComingTrips[index]['phoneNo']}',
                                style: style,
                              ),
                              Text(
                                'Bus Number - ${upComingTrips[index]['busNo']}',
                                style: style,
                              ),
                              Text(
                                'Seat Number - ${upComingTrips[index]['seatNo']}',
                                style: style,
                              ),
                              Text(
                                'Starting Place - ${upComingTrips[index]['startingPlace'][languageIndex]}',
                                style: style,
                              ),
                              if (upComingTrips[
                                          index][
                                      'status'] ==
                                  'reserved')
                                SizedBox(
                                  width: double
                                      .infinity,
                                  child:
                                      RaisedButton(
                                    onPressed:
                                        () {
                                      Provider.of<SeatReservation>(context, listen: false).setPassenger(
                                          upComingTrips[index]
                                              [
                                              'passengerId'],
                                          upComingTrips[index]
                                              [
                                              'deviceId'],
                                          upComingTrips[index]
                                              [
                                              'tripId'],
                                          upComingTrips[index]
                                              [
                                              'fullName'],
                                          upComingTrips[index]
                                              [
                                              'phoneNo'],
                                          upComingTrips[index]
                                              [
                                              'seatNo'],
                                          upComingTrips[index]['startingPlace']
                                              .join(' / '));
                                      Navigator.of(context).pushNamed(
                                          PaymentScreen
                                              .routeName,
                                          arguments: {
                                            'companyId':
                                                upComingTrips[index]['companyId'],
                                            'place': upComingTrips[index]['startingCity'].join(' / ') == "addis ababa / አዲስ አበባ"
                                                ? upComingTrips[index]['destinationCity'].join(' / ')
                                                : upComingTrips[index]['startingCity'].join(' / ')
                                          });
                                    },
                                    color: Theme.of(
                                            context)
                                        .primaryColor,
                                    child: Text(
                                      'Pay',
                                      style: TextStyle(
                                          color: Colors
                                              .white),
                                    ),
                                  ),
                                )
                            ],
                          ),
                        ),

                      // Text(
                      //     'Reason - Buying Bus Ticket From ${company['name'].toString().toUpperCase()}(${upComingTrips[index]['startingCity'][languageIndex]} - ${upComingTrips[index]['destinationCity'][languageIndex]}, seatNo - ${upComingTrips[index]['seatNo']} @${upComingTrips[index]['date'][languageIndex]} : ${upComingTrips[index]['time']})'),
                      // Divider(),
                      // Text(
                      //   'From - ${accountDetail['fullName']}',
                      //   style: style,
                      // ),
                      // Text(
                      //   'Account NO. - ${accountDetail['accountNumber']}',
                      //   style: style,
                      // ),
                      // Text(
                      //   'To - Teguaz Co.LTD',
                      //   style: style,
                      // ),
                      // Text(
                      //   'Amount - ${widget.price}',
                      //   style: style,
                      // ),
                      // Divider(),
                      // if (!widget.enoughMoney)
                      //   Text(
                      //     'Not Enough Money On Your Account!! Please Deposit And Pay With In A Hour, Otherwise Your Reservation Will Be Dismissed!!',
                      //     style: TextStyle(
                      //         color: Colors.red),
                      //   ),
                      // SizedBox(
                      //   width: double.infinity,
                      //   child: RaisedButton(
                      //     onPressed: () {
                      //       if (widget
                      //           .enoughMoney) {
                      //         setState(() {
                      //           performingTransaction =
                      //               true;
                      //         });
                      //         Provider.of<Payment>(
                      //                 context,
                      //                 listen:
                      //                     false)
                      //             .buyTicket(
                      //                 widget
                      //                     .price)
                      //             .then((value) {
                      //           Provider.of<SeatReservation>(
                      //                   context,
                      //                   listen:
                      //                       false)
                      //               .buyTicket();
                      //           Finish(context);
                      //         });
                      //       } else {
                      //         Finish(context);
                      //       }
                      //     },
                      //     color: Theme.of(context)
                      //         .primaryColor,
                      //     child: Text(
                      //       widget.enoughMoney
                      //           ? 'Confirm Transaction'
                      //           : 'Finish',
                      //       style: TextStyle(
                      //           color:
                      //               Colors.white),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                );
              }),
        ));
  }
}
