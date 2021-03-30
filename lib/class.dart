import 'package:flutter_blue/flutter_blue.dart';

class BusTile extends Comparable{
  String type;
  String number;
  String side;
  BluetoothDevice conDevice;
  ScanResult scanResult;
  int rssi;
  bool busState = false;

  BusTile(String type, String number, String side, BluetoothDevice conDevice, ScanResult scanResult, int rssi) {
    this.type = type;
    this.number = number;
    this.side = side;
    this.conDevice = conDevice;
    this.scanResult = scanResult;
    this.rssi = rssi;
  }

  void changeBusState(){
    busState = !busState;
  }

  bool operator < (BusTile bt) => rssi < bt.rssi;
  bool operator > (BusTile bt) => rssi > bt.rssi;
  bool operator <= (BusTile bt) => rssi <= bt.rssi;
  bool operator >= (BusTile bt) => rssi >= bt.rssi;



  @override
  int compareTo(other) {
    return this.rssi - other.rssi;
  }



}

