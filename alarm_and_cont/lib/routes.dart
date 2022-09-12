import 'package:flutter/cupertino.dart';

class Routes {
  Routes._();

  static const String clock = '/clock';
  static const String addAlarm = '/addAlarm';
  static const String cctv = '/cctv';
  static const String ble = '/ble';

  static final routes = <String, WidgetBuilder>{
    clock: (BuildContext context) => ClockPage(),
    addAlarm: (BuildContext context) => AddAlarm(),
    cctv: (BuildContext context) => CctvPage(),
    ble: (BuildContext context) => BlePage(),
  }
}