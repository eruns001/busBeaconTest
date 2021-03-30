
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'class.dart';

BluetoothCharacteristic resultcharacteristic;

///전역 instance
FlutterBlue flutterBlue = FlutterBlue.instance;

bool connect = false;

List<int> turnOn = [1];
List<int> turnOff = [2];
bool readOn = false;

int mainCounter = 0;

List<BusTile> busList;
Map<ScanResult, BusTile> busMap;

///탑승버스
BusTile recentBus;

bool stopScan = false;
TextStyle busTextStyleNumber = TextStyle(
  color: Color(0xffffffff),
  letterSpacing: -0.5,
  fontWeight: FontWeight.w300,
  fontFamily: "NotoSansKR",
  fontStyle: FontStyle.normal,
  fontSize: 24,
);

TextStyle busTextStyleType = TextStyle(
  color: Color(0xffffffff),
  letterSpacing: -0.5,
  fontWeight: FontWeight.w300,
  fontFamily: "NotoSansKR",
  fontStyle: FontStyle.normal,
  fontSize: 15,
);

Color busColor = Color(0xffeb6100);
Color beforeBusColor = Color(0xffeb6100);
Color afterBusColor = Color(0xff5d9023);

///busbutton
String stateString = "탑승";

///busicon
Widget busIconAfter = Icon(
  //Icons.bus_alert,
  CupertinoIcons.bus,
  color: const Color(0xffffffff),
  size: 40,
);
Widget busIconBefore = Icon(
  Icons.bus_alert,
  color: const Color(0xffffffff),
  size: 40,
);


///선택버스
BusTile busRide;
BusTile busNow;


///main init loop
bool initBool = true;