import 'package:flutter/widgets.dart';

var device = DeviceInstance();

class DeviceInstance {
  static final DeviceInstance _singleton = DeviceInstance._internal();

  factory DeviceInstance() {
    return _singleton;
  }

  DeviceInstance._internal();

  // double width = WidgetsBinding.instance!.window!.physicalSize.width ;
  // double height = WidgetsBinding.instance!.window!.physicalSize.height ;

}
