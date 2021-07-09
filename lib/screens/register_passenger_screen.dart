import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teguaz_app/providers/device.dart';
import 'package:teguaz_app/providers/seat_reservation.dart';
import 'package:teguaz_app/providers/setting.dart';
import 'package:teguaz_app/providers/trips.dart';
import 'package:teguaz_app/screens/payment_screen.dart';

class RegisterPassenger extends StatefulWidget {
  static const routeName = '/register-passenger';
  RegisterPassenger({Key key}) : super(key: key);

  @override
  _RegisterPassengerState createState() =>
      _RegisterPassengerState();
}

class _RegisterPassengerState
    extends State<RegisterPassenger> {
  var validatorCondition = true;
  final GlobalKey<ScaffoldState> _scaffold =
      new GlobalKey<ScaffoldState>();
  final _form = GlobalKey<FormState>();
  int _selectedSPIndex = null;
  var isSubmitted = false;
  String _fullName;
  String _phoneNumber;

  final snackBar = SnackBar(
    behavior: SnackBarBehavior.floating,
    content: Text(
      'Selected Seat Is Reserved By Another Person!! Try Other Seats.',
      textAlign: TextAlign.left,
      style: TextStyle(color: Colors.red),
    ),
  );

  @override
  Widget build(BuildContext context) {
    final deviceId =
        Provider.of<Device>(context).deviceId;

    final routeArgs = ModalRoute.of(context)
        .settings
        .arguments as Map<String, Object>;
    final tripId = routeArgs['tripId'];
    final seatNo = routeArgs['seatNo'];

    final trip = Provider.of<Trips>(context)
        .finadById(tripId);
    // this one becomes true when seat number reserved while i am reserving
    final isValidated =
        Provider.of<Trips>(context, listen: false)
            .seatValidation(tripId, seatNo);
    if (isValidated && validatorCondition) {
      _scaffold.currentState
          .showSnackBar(snackBar);

      WidgetsBinding.instance
          .addPostFrameCallback((_) {
        // Add Your Code here.
        Future.delayed(
            const Duration(milliseconds: 5000),
            () {
// Here you can write your code
          Navigator.of(context).pop();
        });
      });
    }

    final languageIndex =
        Provider.of<Setting>(context)
            .languageIndex;
    int _value = 0;

    _saveForm() {
      isSubmitted = true;
      final isValid =
          _form.currentState.validate();
      if (isValid && _selectedSPIndex != null) {
        _form.currentState.save();
        Provider.of<SeatReservation>(context,
                listen: false)
            .reserveSeat(
                deviceId,
                tripId,
                _fullName,
                _phoneNumber,
                seatNo,
                trip.startingPlace[
                    _selectedSPIndex]);
        // _scaffold.currentState.showSnackBar(
        //   SnackBar(
        //     content: Text(
        //       'Seat No. ' +
        //           seatNo.toString() +
        //           ' Reserved For ' +
        //           _fullName,
        //     ),
        //     duration: Duration(seconds: 2),
        //   ),
        // );
        validatorCondition = false;
        Navigator.of(context).pushNamed(
            PaymentScreen.routeName,
            arguments: {
              'delete': false,
              'companyId': trip.companyId,
              'place': trip.startingCity
                          .join(' / ') ==
                      "addis ababa / አዲስ አበባ"
                  ? trip.destinationCity
                      .join(' / ')
                  : trip.startingCity.join(' / ')
            }).then(
            (value) => validatorCondition = true);
      }
    }

    return Scaffold(
      key: _scaffold,
      appBar: AppBar(
        title: Text('Passenger registration'),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: ListView(
          children: [
            Text(
              'Trip Description',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20),
            ),
            Text(
              'Trip Date - ${trip.date[languageIndex]}',
              style: Theme.of(context)
                  .textTheme
                  .display4,
            ),
            Text(
              'Starting City - ${trip.startingCity[languageIndex]}',
              style: Theme.of(context)
                  .textTheme
                  .display4,
            ),
            Text(
              'Destination City - ${trip.destinationCity[languageIndex]}',
              style: Theme.of(context)
                  .textTheme
                  .display4,
            ),
            Text(
              'Bus No. - ${trip.busNo}',
              style: Theme.of(context)
                  .textTheme
                  .display4,
            ),
            Text(
              'Seat No.. - ${seatNo}',
              style: Theme.of(context)
                  .textTheme
                  .display4,
            ),
            Text(
              'Starting Time. - ${trip.time}',
              style: Theme.of(context)
                  .textTheme
                  .display4,
            ),
            Divider(),
            Container(
              height: 50,
              child: Card(
                elevation: 10,
                child: ListTile(
                  tileColor: Theme.of(context)
                      .primaryColor,
                  title: Text(
                    'Please Fill The Form',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        height: 0,
                        color: Colors.white,
                        fontWeight:
                            FontWeight.bold,
                        fontSize: 18),
                  ),
                ),
              ),
            ),
            Form(
                key: _form,
                child: Column(
                  children: [
                    TextFormField(
                        onChanged: (_) {
                          if (isSubmitted) {
                            _form.currentState
                                .validate();
                          }
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please Enter Your Full Name!!';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _fullName = value;
                        },
                        cursorColor:
                            Theme.of(context)
                                .cursorColor,
                        maxLength: 30,
                        decoration:
                            InputDecoration(
                                icon: Icon(
                                    Icons.person),
                                labelText:
                                    'Full Name',
                                labelStyle:
                                    TextStyle(
                                  color: Color(
                                      0xFF6200EE),
                                ),
                                helperText: [
                                  'Eg. Ermiyas Solomon',
                                  'ለምሳሌ፡ ኤርሚያስ ሰሎሞን'
                                ][languageIndex],
                                suffixIcon: Icon(
                                  Icons
                                      .check_circle,
                                ),
                                enabledBorder:
                                    UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(
                                          0xFF6200EE)),
                                ))),
                    TextFormField(
                      onChanged: (_) {
                        if (isSubmitted) {
                          _form.currentState
                              .validate();
                        }
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please Enter Your Phone Number!!';
                        }

                        if (double.tryParse(
                                value) ==
                            null) {
                          return 'Please Enter Phone Number Not Letters!!';
                        }

                        if (value.length < 10) {
                          return 'Please Enter Valid Phone Number!!';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _phoneNumber = value;
                      },
                      cursorColor:
                          Theme.of(context)
                              .cursorColor,
                      maxLength: 10,
                      decoration: InputDecoration(
                          icon: Icon(Icons.phone),
                          labelText:
                              'Phone Number',
                          labelStyle: TextStyle(
                            color:
                                Color(0xFF6200EE),
                          ),
                          helperText: [
                            'Eg. 0939866118',
                            'ለምሳሌ፡ 0939866118'
                          ][languageIndex],
                          suffixIcon: Icon(
                            Icons.check_circle,
                          ),
                          enabledBorder:
                              UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Color(
                                    0xFF6200EE)),
                          )),
                      keyboardType:
                          TextInputType.number,
                    ),
                    // radio buttons
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                        [
                          'Choose Starting Place',
                          'መነሻ ቦታ ይምረጡ'
                        ][languageIndex],
                        style: TextStyle(
                          fontSize: 18,
                        )),
                    Divider(),
                    SizedBox(
                      width: double.infinity,
                      height: 40,
                      child: ListView(
                        scrollDirection:
                            Axis.horizontal,
                        children: [
                          for (int i = 0;
                              i <
                                  trip.startingPlace
                                      .length;
                              i++)
                            Container(
                              decoration: BoxDecoration(
                                  border: _selectedSPIndex ==
                                              null &&
                                          isSubmitted ==
                                              true
                                      ? Border.all(
                                          width:
                                              2,
                                          color: Colors
                                              .red)
                                      : null),
                              margin:
                                  EdgeInsets.only(
                                      right: 10),
                              child: InputChip(
                                avatar: Icon(
                                  Icons.place,
                                  color: _selectedSPIndex == i
                                      ? Colors
                                          .white
                                      : Colors
                                          .black,
                                ),
                                selected:
                                    _selectedSPIndex ==
                                            i
                                        ? true
                                        : false,
                                selectedColor: Theme
                                        .of(context)
                                    .primaryColor,
                                label: Text(
                                  '${trip.startingPlace[i].split(" / ").toList()[languageIndex]}',
                                  style:
                                      TextStyle(
                                    color: _selectedSPIndex ==
                                            i
                                        ? Colors
                                            .white
                                        : Colors
                                            .black,
                                  ),
                                ),
                                onSelected:
                                    (bool value) {
                                  setState(() {
                                    _selectedSPIndex =
                                        i;
                                  });
                                },
                              ),
                            ),
                        ],
                      ),
                    ),
                    if (isSubmitted == true &&
                        _selectedSPIndex == null)
                      Text(
                        'Please Select Trip Starting Place!!',
                        style: TextStyle(
                            color: Colors.red),
                      ),
                    SizedBox(height: 20),
                    Container(
                      width: double.infinity,
                      child: RaisedButton.icon(
                          onPressed: isValidated &&
                                  validatorCondition
                              ? null
                              : () {
                                  setState(() {
                                    _saveForm();
                                  });
                                },
                          color: Theme.of(context)
                              .primaryColor,
                          icon: Icon(
                            Icons.event_seat,
                            color: Colors.white,
                          ),
                          label: Text(
                              'Reserve Seat',
                              style: TextStyle(
                                  color: Colors
                                      .white))),
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
