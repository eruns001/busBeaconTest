import 'package:beacontest06/busListPage.dart';
import 'package:beacontest06/widgetclass.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'class.dart';
import 'data.dart';
import 'function.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;



  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  BluetoothDevice resultdevice;

  String name = 'temp';
  String busNum = '0';
  List<int> bledata = [];

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scanloop();

    //flutterBlue.startScan(timeout: Duration(seconds: 4));
    //name Max length is 12
    //var subscription =
  }

  @override
  Widget build(BuildContext context) {

    double _mainWidth = MediaQuery.of(context).size.width;
    double _mainHeight = MediaQuery.of(context).size.height;

    setState(() {
    });
    return Scaffold(
      body: Container(
        height: _mainHeight,
        width: _mainWidth,
        decoration: BoxDecoration(
          color: const Color(0xFFE0E0E0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ///기사님 저 내려요
            Container(
              height: _mainHeight * 0.08,
              width: _mainWidth * 0.8,
              margin: new EdgeInsets.only(top: _mainHeight * 0.08),
              child : Center(
                child: Text(
                  "기사님 저 내려요",
                  style: TextStyle(
                    fontFamily: "NotoSansKR",
                    fontSize: 24,
                  ),
                ),
              ),
              decoration: BoxDecoration(
                color: const Color(0xFFFFFFFF),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: const Color(0xFFE0E0E0),
                ),
              ),
            ),
            ///탑승한 버스, 하차버튼

            StreamBuilder(
              stream: flutterBlue.scanResults,//flutterBlue.startScan(),
              builder: (BuildContext context, AsyncSnapshot<List<ScanResult>> snapshot ) {
                if(snapshot.hasData){
                  /*
                  Map<ScanResult, BusTile> busResultMap = Map();
                  for(ScanResult scanResult in snapshot.data){
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

                        BusTile temp = BusTile(type, number, side, scanResult.device, scanResult, scanResult.rssi);

                        if(busResultMap == null){
                          BusTile temp = BusTile(type, number, side, scanResult.device, scanResult, scanResult.rssi);
                          busNow = busNow != temp && temp.number != null ? temp : busNow;
                          busResultMap = {scanResult : temp};
                        }
                        else{
                          busResultMap[scanResult] = BusTile(type, number, side, scanResult.device, scanResult, scanResult.rssi);
                        }
                        print("scanResult rssi: ${temp.rssi}");
                      }
                    });
                  }
                  busMap = busResultMap;
                  busList = busMap.entries.map((e) => e.value).toList();
                  busList.sort();//(a,b) => a.rssi.compareTo(b.rssi)
                  */

                  if(busMap != null){
                    return Container(
                      child: Column(
                        children: [
                          Container(
                            height: _mainHeight * 0.14,
                            width: _mainWidth * 0.8,
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFFFFF),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: const Color(0xFFE0E0E0),
                              ),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  margin: new EdgeInsets.only(left: _mainHeight * 0.02),
                                  child: Text(
                                    "탑승한 버스"
                                  ),
                                ),
                                busRide != null ?
                                Container(
                                  margin: new EdgeInsets.only(top: _mainHeight * 0.02, bottom: _mainHeight * 0.02),
                                  child: FlatButton(
                                    child: busbutton(
                                      busmapIndex: 0,
                                      screenHeight: _mainHeight * 0.08,
                                      screenWidth: _mainWidth * 0.5,
                                      rideBus: busRide != null? busRide : busNow,
                                    ),
                                    onPressed: (){
                                      initBool = false;
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => BusListPage()),
                                      );
                                    },
                                  ),
                                ):
                                busMap.length != 0 ?

                                  ///인식된 버스가 있는 경우
                                  Container(
                                  margin: new EdgeInsets.only(top: _mainHeight * 0.02, bottom: _mainHeight * 0.02),
                                  child: FlatButton(
                                    child: busbutton(
                                      busmapIndex: 0,
                                      screenHeight: _mainHeight * 0.08,
                                      screenWidth: _mainWidth * 0.5,
                                      rideBus: busRide,
                                    ),
                                    onPressed: (){
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => BusListPage()),
                                      );
                                    },
                                  ),
                                ):
                                  ///인식된 버스가 없는 경우
                                  Container(
                                  margin: new EdgeInsets.only(top: _mainHeight * 0.02, bottom: _mainHeight * 0.02),
                                  child: FlatButton(
                                    child: Container(
                                      height: _mainHeight * 0.08,
                                      width: _mainWidth * 0.5,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20)
                                        ),
                                        border: Border.all(
                                            color: beforeBusColor,
                                            width: 1),
                                        boxShadow: [BoxShadow(
                                            color: const
                                            Color(0x80cacaca),
                                            offset:
                                            Offset(0,-1),
                                            blurRadius: 16,
                                            spreadRadius: 2)],
                                        color: beforeBusColor,
                                      ),
                                    ),
                                    onPressed: (){

                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => BusListPage()),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),

                          ///하차버튼
                          Container(
                            margin: new EdgeInsets.only(top: _mainHeight * 0.08),
                            child: FlatButton(
                              child: Container(
                                height: _mainHeight * 0.2,
                                width: _mainWidth * 0.6,
                                child: Center(
                                  child: Text(
                                    "하차",
                                    style: TextStyle(
                                        fontFamily: "NotoSansKR",
                                        fontSize: 36,
                                        color: const Color(0xFFFFFFFF)
                                    ),
                                  ),
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(20)
                                  ),
                                  border: Border.all(
                                      color: busColor,
                                      width: 1),
                                  boxShadow: [BoxShadow(
                                      color: const
                                      Color(0x80cacaca),
                                      offset:
                                      Offset(0,-1),
                                      blurRadius: 16,
                                      spreadRadius: 2)],
                                  color: busColor,
                                ),
                              ),

                              onPressed: (){
                                busRide != null? bleLedOn(busRide.scanResult) : bleLedOn(busList[0].scanResult);
                                //bleLedOn();
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  else{
                    return Center(
                      child: Text(
                          "접속중"
                      ),
                    );
                  }
                }
                return Center(
                    child: CupertinoActivityIndicator()
                );
              },
            ),


            ///정차를 원하신다면 설명 txt
            Container(
              margin: new EdgeInsets.only(top: _mainHeight * 0.02),
              child: Text(
                  "정차를 원하신다면 위 버튼을 눌러주세요"
              ),
            ),
            ///현대 마크
            Container(
              width: _mainWidth * 0.8,
              height: _mainHeight * 0.14,
              decoration: BoxDecoration(
                color: const Color(0xFFFFFFFF),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: const Color(0xFFE0E0E0),
                ),
              ),
              child: Image.asset(
                'images/hyundai.jpg',
                fit: BoxFit.contain,
              ),
            ),
          ],
        ),
      ),// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
