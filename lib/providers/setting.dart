import 'package:flutter/material.dart';

class Setting with ChangeNotifier {
  bool _AmharicLanguage = false;

  int get languageIndex {
    if (_AmharicLanguage) {
      return 1;
    }
    return 0;
  }

  bool get isAmharic {
    return _AmharicLanguage;
  }

  void changeLanguage(bool val) {
    _AmharicLanguage = val;
    notifyListeners();
  }
}
