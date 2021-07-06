import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Account {
  int accountNumber;
  String admin;
  String fullName;
  int money;
  int phoneNumber;
  int pin;
  String key;

  Account(
      {this.accountNumber,
      this.admin,
      this.fullName,
      this.money,
      this.phoneNumber,
      this.pin,
      this.key});
}

class Payment with ChangeNotifier {
  // Company Account Setter code

  Account _passengerAccount;
  Account _companyAccount;

  Map<String, dynamic> get accountDetail {
    return {
      'accountNumber':
          _passengerAccount.accountNumber,
      'fullName': _passengerAccount.fullName
    };
  }

  Future<void> buyTicket(double tripPrice) async {
    try {
      var companyUrl = Uri.parse(
          'https://bank-demo-3dfb4-default-rtdb.firebaseio.com/account/-MayfGq3oIHLOswkuE-O.json');
      final newCAmount = _companyAccount.money +
          tripPrice.toInt();

      await http.patch(companyUrl,
          body: json.encode({
            'accountNumber':
                _companyAccount.accountNumber,
            'admin': _companyAccount.admin,
            'fullName': _companyAccount.fullName,
            'money': newCAmount,
            'phoneNumber':
                _companyAccount.phoneNumber,
            'pin': _companyAccount.pin,
          }));
      final newPAmount = _passengerAccount.money -
          tripPrice.toInt();
      final key = _passengerAccount.key;
      var passengerUrl = Uri.parse(
          'https://bank-demo-3dfb4-default-rtdb.firebaseio.com/account/$key.json');
      await http.patch(passengerUrl,
          body: json.encode({
            'accountNumber':
                _passengerAccount.accountNumber,
            'admin': _passengerAccount.admin,
            'fullName':
                _passengerAccount.fullName,
            'money': newPAmount,
            'phoneNumber':
                _passengerAccount.phoneNumber,
            'pin': _passengerAccount.pin,
          }));
    } catch (error) {
      print(error);
    }
  }

  Future<String> getPassengerAccount(
      int pin) async {
    String isValidated = 'INCORRECT_PIN';
    try {
      var url = Uri.parse(
          'https://bank-demo-3dfb4-default-rtdb.firebaseio.com/account.json');
      var response = await http.get(url);

      var extractedData =
          json.decode(response.body)
              as Map<dynamic, dynamic>;

      extractedData.forEach((key, value) {
        if (value['pin'] == pin) {
          // print('successs passenger working');
          _passengerAccount = new Account(
              accountNumber:
                  value['accountNumber'],
              fullName: value['fullName'],
              admin: value['admin'],
              money: value['money'].toInt(),
              phoneNumber: value['phoneNumber'],
              pin: value['pin'],
              key: key);
          isValidated = 'SUCCESS';
        }

        if (key == '-MayfGq3oIHLOswkuE-O') {
          // print('successs company working');
          _companyAccount = new Account(
              accountNumber:
                  value['accountNumber'],
              fullName: value['fullName'],
              admin: value['admin'],
              money: value['money'].toInt(),
              phoneNumber: value['phoneNumber'],
              pin: value['pin'],
              key: key);
        }
      });

      return isValidated;
    } catch (error) {
      print(error);
      return 'ERROR';
    }

    // todo 1 - iterate on the lists then assign _passenger Account
    // todo 2 - when okay button clicked validate if it hase enough money or not
    // todo 3 - display success or error message

    // !exception
    // todo - in the bank demo when account created make deposit report as an initial
    // todo - when passenger buy ticket write passenger id on the report
  }

  // Future<void> CompanyAccountFetch() async {
  //   var url = Uri.parse(
  //       'https://bank-demo-3dfb4-default-rtdb.firebaseio.com/account/-MaosTtjgfwo9FwDQejx.json');
  //   var response = await http.get(url);

  //   _companyAccount.key = '-MaosTtjgfwo9FwDQejx';
  //   var extractedData = json.decode(response.body)
  //       as Map<dynamic, dynamic>;

  //   extractedData.forEach((key, value) {});
  // }

  bool accountHasEnoughMoney(double price) {
    return _passengerAccount.money - price < 0
        ? false
        : true;
  }
}
