import 'package:beacontest06/class.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'data.dart';

void bleLedOn(ScanResult resultScan) async {
  print("resultScan : ${resultScan.toString()}");
  //await resultScan.device.connect();
  await resultScan.device.connect();
  List<BluetoothService> services = await resultScan.device.discoverServices();
  services.forEach((service) {
    print("service : $service");
    var characteristics = service.characteristics;
    for(BluetoothCharacteristic c in characteristics) {
      //List<int> value = await c.read();
      print("BluetoothCharacteristic - $mainCounter: $c /n");
      //c.write([1]);
      resultcharacteristic = c;
      mainCounter++;
    }
  });
  await resultcharacteristic.write(turnOn);
  await resultScan.device.disconnect();
}

Map<ScanResult, BusTile> resultToBusTile(List<ScanResult> scanResultList){
  //String name = scanResult.device.name;

  Map<ScanResult, BusTile> busResultMap;
  for(ScanResult scanResult in scanResultList){
    scanResult.advertisementData.serviceData.forEach((key, value) {
      if(value[0] == 12){
        String type = (value[3] < 16) ? "시내버스" : "마을버스";
        String number = (value[1] * 256 + value[2]).toString();
        String side= (value[3] < 16) ? "- ${value[3]}" : "- ${value[3] - 16}";

        if(value[3] == 0){
          side = "";
        }

        BusTile bustiletemp = BusTile(type, number, side, scanResult.device, scanResult, scanResult.rssi);
        print("totest : ${bustiletemp.type}");
        if(busList == null){
          busList = [bustiletemp];
        }
        else{
          busList.add(bustiletemp);
        }
        if(busResultMap == null){
          busResultMap = {scanResult : BusTile(type, number, side, scanResult.device, scanResult, scanResult.rssi)};
        }
        else{
          busResultMap[scanResult] = BusTile(type, number, side, scanResult.device, scanResult, scanResult.rssi);
        }
      }
    });
  }

  return busResultMap;
}

void scanloop(){

  flutterBlue.startScan(timeout: Duration(seconds: 4));
  flutterBlue.scanResults.listen((List<ScanResult> event) {
    if(event.isNotEmpty){
      Map<ScanResult, BusTile> busResultMap = Map();
      for(ScanResult scanResult in event){
        scanResult.advertisementData.serviceData.forEach((key, value) {
          print("scanR : ${scanResult}");
          ///12 : ledoff, 15 : ledon
          if(value[0] == 12 || value[0] == 15){
            String type = (value[3] < 16) ? "시내버스" : "마을버스";
            String number = (value[1] * 256 + value[2]).toString();
            String side= (value[3] < 16) ? "- ${value[3]}" : "- ${value[3] - 16}";
            bool ledState = value[0] == 12? false : true;

            if(value[3] == 0){
              side = "";
            }
            if(busResultMap == null){
              busResultMap = {scanResult : BusTile(type, number, side, scanResult.device, scanResult, scanResult.rssi)};
            }
            else{
              busResultMap[scanResult] = BusTile(type, number, side, scanResult.device, scanResult, scanResult.rssi);
            }
          }
        });
      }

      busMap = busResultMap;
      busList = busMap.entries.map((e) => e.value).toList();
      busList.sort();
    }
  });
  //if(!stopScan){
  //       scanloop();
  //     }

  flutterBlue.stopScan();

  Future.delayed(const Duration(milliseconds: 5000), () {
    scanloop();
  });
}