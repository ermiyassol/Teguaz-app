import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teguaz_app/providers/companies.dart';
import 'package:teguaz_app/providers/payment.dart';
import 'package:teguaz_app/providers/seat_reservation.dart';

import 'package:teguaz_app/widgets/transaction_detail.dart';

class PaymentScreen extends StatefulWidget {
  static const routeName = '/payment-screen';

  @override
  _PaymentScreenState createState() =>
      _PaymentScreenState();
}

class _PaymentScreenState
    extends State<PaymentScreen> {
  final pinController = TextEditingController();
  bool passwordVisible = false;
  bool _isSubmitted = false;

  int bankIndex;

  final imageName = [
    'awash.png',
    'commercial.png',
    'oromiya.jpg',
    'bunna.png',
  ];

  Future<void> _showErrorDialog(
      String title, String content) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertDialog(
            title: new Text(
              title,
              style: TextStyle(color: Colors.red),
            ),
            content: new Text(content),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              new FlatButton(
                child: new Text("Close"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  Future<dynamic> _showPaymentDialog(
      bool enoughMoney, double price) {
    return showDialog(
        // useSafeArea: true,
        context: context,
        builder: (ctx) => AlertDialog(
              title: Text(
                'Transaction Detail',
                style: TextStyle(
                    color: Theme.of(context)
                        .primaryColor),
                textAlign: TextAlign.center,
              ),
              content: TransactionDetail(
                  enoughMoney, price),
            ));
  }

  // _showPaymentDialog() {
  //   Navigator.of(context)
  //       .pushNamed(TransactionDetail.routeName);
  // }

  selectBank(int index) {
    setState(() {
      bankIndex = index;
    });
  }

  validatePayment(
      String companyId, String place) {
    setState(() {
      _isSubmitted = true;
    });
    Provider.of<Payment>(context, listen: false)
        .getPassengerAccount(
            int.parse(pinController.text))
        .then((response) {
      if (response == 'SUCCESS') {
        final tripPrice = Provider.of<Companies>(
                context,
                listen: false)
            .fetchDestinationPlace(
                companyId, place);

        final enoughMoney = Provider.of<Payment>(
                context,
                listen: false)
            .accountHasEnoughMoney(tripPrice);
        _showPaymentDialog(
            enoughMoney, tripPrice);
      } else if (response == 'INCORRECT_PIN') {
        _showErrorDialog('Incorrect Pin',
            'Please Enter Correct Pin Number!!');
      } else if (response == 'ERROR') {
        _showErrorDialog('Some Error Ocurred',
            'Please Try Again!!');
      }
    });
  }

  Widget _bankImageBuilder(int index) {
    return Container(
        width: 100,
        height: 100,
        child: ConstrainedBox(
            constraints: BoxConstraints.expand(),
            child: FlatButton(
                onPressed: () {
                  selectBank(index);
                },
                child: Image.asset(
                    'assets/images/${imageName[index]}'))));
  }

  @override
  Widget build(BuildContext context) {
    final routeArgs = ModalRoute.of(context)
        .settings
        .arguments as Map<String, dynamic>;
    final companyId = routeArgs['companyId'];
    final place = routeArgs['place'];

    print(routeArgs);
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon:
                    const Icon(Icons.arrow_back),
                onPressed: () {
                  Provider.of<SeatReservation>(
                          context,
                          listen: false)
                      .deletePassenger();
                  Navigator.of(context).pop();
                },
              );
            },
          ),
          title: Text('Payment Selection'),
        ),
        body: ListView(
          children: [
            if (bankIndex != null)
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 15, vertical: 10),
                child: Row(
                  children: [
                    Flexible(
                      child: TextField(
                        controller: pinController,
                        keyboardType:
                            TextInputType.number,
                        obscureText:
                            passwordVisible
                                ? false
                                : true,
                        cursorColor:
                            Theme.of(context)
                                .cursorColor,
                        onChanged: (value) {
                          if (_isSubmitted &&
                              value.isNotEmpty) {
                            setState(() {
                              _isSubmitted =
                                  false;
                            });
                          }
                        },
                        maxLength: 8,
                        decoration:
                            InputDecoration(
                          errorText: _isSubmitted &&
                                  pinController
                                      .text
                                      .isEmpty
                              ? 'Please Enter Your Mobile Banking Pin!!'
                              : null,
                          icon: Icon(Icons.lock),
                          labelText:
                              'Enter Your Pin',
                          labelStyle: TextStyle(
                            color:
                                Color(0xFF6200EE),
                          ),
                          helperText:
                              'Enter Your Selected Bank Mobile Banking Pin',
                          suffixIcon: IconButton(
                              icon: Icon(passwordVisible
                                  ? Icons
                                      .visibility_off
                                  : Icons
                                      .visibility),
                              onPressed: () {
                                setState(() {
                                  passwordVisible =
                                      !passwordVisible;
                                });
                              }),
                          enabledBorder:
                              UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Color(
                                    0xFF6200EE)),
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        validatePayment(
                            companyId, place);
                      },
                      splashColor:
                          Theme.of(context)
                              .primaryColor,
                      icon: Icon(
                        Icons.check,
                        color: Theme.of(context)
                            .primaryColor,
                      ),
                    )
                  ],
                ),
              ),
            Divider(),
            _bankImageBuilder(0),
            _bankImageBuilder(1),
            _bankImageBuilder(2),
            _bankImageBuilder(3),
          ],
        ));
  }
}
