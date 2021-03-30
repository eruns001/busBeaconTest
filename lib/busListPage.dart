import 'package:beacontest06/widgetclass.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

import 'data.dart';
import 'function.dart';

class BusListPage extends StatefulWidget {
  @override
  _BusListPage createState() => _BusListPage();
}



class _BusListPage extends State<BusListPage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    flutterBlue.stopScan();
    Future.delayed(const Duration(milliseconds: 200), () {
      flutterBlue.startScan(timeout: Duration(seconds: 4));
    });
  }

  @override
  Widget build(BuildContext context) {
    //디바이스 너비
    double _mainWidth = MediaQuery.of(context).size.width;
    //디바이스 높이
    double _mainHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        height: _mainHeight,
        width: _mainWidth,
        decoration: BoxDecoration(
          color: const Color(0xFFE0E0E0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ///버스 수정
            Container(
              height: _mainHeight * 0.08,
              width: _mainWidth * 0.9,
              margin: new EdgeInsets.only(top: _mainHeight * 0.08),
              decoration: BoxDecoration(
                color: const Color(0xFFFFFFFF),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: const Color(0xFFE0E0E0),
                ),
              ),
              child : Center(
                child: Text(
                  "버스 수정",
                  style: TextStyle(
                    fontFamily: "NotoSansKR",
                    fontSize: 24,
                  ),
                ),
              ),
            ),
            ///busList 버스 리스트
            Container(
              height: _mainHeight * 0.4,
              width: _mainWidth * 0.9,
              decoration: BoxDecoration(
                color: const Color(0xFFFFFFFF),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: const Color(0xFFE0E0E0),
                ),
              ),
              child: StreamBuilder(
                stream: flutterBlue.scanResults,
                builder:  (BuildContext context, AsyncSnapshot<List<ScanResult>> snapshot ){
                  return SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ///버튼
                        for(var a = 0 ; a < busMap.keys.length; a ++)
                          Container(
                            width: _mainWidth * 0.8,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(20)
                              ),
                            ),
                            margin: new EdgeInsets.only(top: _mainHeight * 0.02, bottom: _mainHeight * 0.02),
                            child: FlatButton(
                              child: busbutton(
                                busmapIndex: a,
                                screenHeight: _mainHeight * 0.08,
                                screenWidth: _mainWidth * 0.8,
                              ),
                              onPressed: (){
                                setState(() {
                                  busRide = busList[a];//busMap[busMap.keys.elementAt(a)];
                                  flutterBlue.stopScan();
                                  Future.delayed(const Duration(milliseconds: 200), () {
                                    flutterBlue.startScan(timeout: Duration(seconds: 4));
                                  });
                                  Navigator.pop(context);
                                });
                              },
                            ),
                          ),
                      ],
                    ),
                  );
                },
              ),
            ),
            ///선택 버스 탑승 버스
            Container(
              height: _mainHeight * 0.2,
              width: _mainWidth * 0.9,
              decoration: BoxDecoration(
                color: const Color(0xFFFFFFFF),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: const Color(0xFFE0E0E0),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ///탑승버스
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ///탑승버스 txt
                        Container(
                          child: Text(
                            "탑승 버스",
                            style: TextStyle(
                                fontFamily: "NotoSansKR",
                                fontSize: 20,
                                color: const Color(0xFF000000)
                            ),
                          ),
                        ),
                        ///탑승버스 표기
                        busMap.length != 0 || busRide != null ?
                          Container(
                          child: busbutton(
                            busmapIndex: 0,
                            screenHeight: _mainHeight * 0.08,
                            screenWidth: _mainWidth * 0.4,
                            rideBus: busRide,
                          ),
                        ):
                          Container(
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
                      ],
                    ),
                  ),
                  ///버튼
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ///사용법 설명
                        Container(
                          child: Text(
                            "위 리스트에서 버스를 선택하시면\n탑승으로 인식된 버스가 수정됩니다.",
                            style: TextStyle(
                                fontFamily: "NotoSansKR",
                                fontSize: 12,
                                color: const Color(0xFF000000)
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            ///현대 마크
            Container(
              width: _mainWidth * 0.9,
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
      ),
    );
  }
}