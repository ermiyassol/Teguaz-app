import 'package:flutter/material.dart';
import 'package:imei_plugin/imei_plugin.dart';

class Device with ChangeNotifier {
  String deviceId;

  String get deviceUniqueId {
    return deviceId;
  }

  Future<String> getImei() async {
    deviceId = await ImeiPlugin.getImei(
        shouldShowRequestPermissionRationale:
            false);
    return deviceId;
  }
}
