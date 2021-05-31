import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teguaz_app/providers/companies.dart';
import 'package:teguaz_app/providers/payment.dart';
import 'package:teguaz_app/providers/seat_reservation.dart';
import 'package:teguaz_app/providers/setting.dart';
import 'package:teguaz_app/providers/trips.dart';

class TransactionDetail extends StatefulWidget {
  static const routeName = '/transaction-detail';
  final bool enoughMoney;
  final double price;

  TransactionDetail(this.enoughMoney, this.price);

  @override
  _TransactionDetailState createState() =>
      _TransactionDetailState();
}

class _TransactionDetailState
    extends State<TransactionDetail> {
  bool performingTransaction = false;

  final style = TextStyle(
      fontSize: 17, fontWeight: FontWeight.bold);

  Finish(BuildContext context) {
    Navigator.of(context)
        .popUntil((route) => route.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    final passengerDetail =
        Provider.of<SeatReservation>(context,
                listen: false)
            .passengerDetail;
    final tripDetail = Provider.of<Trips>(context,
            listen: false)
        .tripDetail(passengerDetail['tripId']);
    final languageIndex = Provider.of<Setting>(
            context,
            listen: false)
        .languageIndex;
    final companyName = Provider.of<Companies>(
            context,
            listen: false)
        .getCompany(
            tripDetail['companyId'], 'name');
    final accountDetail = Provider.of<Payment>(
            context,
            listen: false)
        .accountDetail;

    return Container(
      height: 400,
      child: performingTransaction
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                    'Passenger Name - ${passengerDetail['fullName']}'),
                Text(
                    'Reason - Buying Bus Ticket From ${companyName.toString().toUpperCase()}(${tripDetail['startingPlace'][languageIndex]} - ${tripDetail['destinationPlace'][languageIndex]}, seatNo - ${passengerDetail['seatNo']} @${tripDetail['date'][languageIndex]} : ${tripDetail['time']})'),
                Divider(),
                Text(
                  'From - ${accountDetail['fullName']}',
                  style: style,
                ),
                Text(
                  'Account NO. - ${accountDetail['accountNumber']}',
                  style: style,
                ),
                Text(
                  'To - Teguaz Co.LTD',
                  style: style,
                ),
                Text(
                  'Amount - ${widget.price}',
                  style: style,
                ),
                Divider(),
                if (!widget.enoughMoney)
                  Text(
                    'Not Enough Money On Your Account!! Please Deposit And Pay With In A Hour, Otherwise Your Reservation Will Be Dismissed!!',
                    style: TextStyle(
                        color: Colors.red),
                  ),
                SizedBox(
                  width: double.infinity,
                  child: RaisedButton(
                    onPressed: () {
                      if (widget.enoughMoney) {
                        setState(() {
                          performingTransaction =
                              true;
                        });
                        Provider.of<Payment>(
                                context,
                                listen: false)
                            .buyTicket(
                                widget.price)
                            .then((value) {
                          Provider.of<SeatReservation>(
                                  context,
                                  listen: false)
                              .buyTicket()
                              .then((value) {
                            setState(() {
                              performingTransaction =
                                  false;
                            });
                          });
                          Finish(context);
                        });
                      } else {
                        Finish(context);
                      }
                    },
                    color: Theme.of(context)
                        .primaryColor,
                    child: Text(
                      widget.enoughMoney
                          ? 'Confirm Transaction'
                          : 'Finish',
                      style: TextStyle(
                          color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}

// todo 1 - make UI if the passenger have no money on his account
// todo 2 - fetch company name
// todo 3 - perform payment
// todo 4 - make ticket drawer
