import 'package:beacontest06/class.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'data.dart';

class busbutton extends StatelessWidget{
  busbutton({
    @required this.busmapIndex,
    @required this.screenHeight,
    @required this.screenWidth,
    this.child,
    this.rideBus,
  });
  final int busmapIndex;
  final double screenWidth;
  final double screenHeight;
  final BusTile rideBus;
  final Widget child;

  @override
  Widget build(BuildContext context) {

    /*
    BusTile outPutBus = this.rideBus != null ?
    rideBus:
    busMap[busMap.keys.elementAt(this.busmapIndex)];

     */

    BusTile outPutBus = this.rideBus != null ?
    rideBus:
    busList[busmapIndex];

    bool busRideState = rideBus != null ?
        true : false;

    return Container(
      height: this.screenHeight,
      width: this.screenWidth,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
            Radius.circular(20)
        ),
        border: Border.all(
            color: beforeBusColor, //busRideState ? afterBusColor :
            width: 1),
        boxShadow: [BoxShadow(
            color: const Color(0x80cacaca),
            offset: Offset(0,-1),
            blurRadius: 16,
            spreadRadius: 2)],
        color: beforeBusColor,// busRideState ? afterBusColor :
      ),
      child: Row(children: [
        Container(
          margin: EdgeInsets.only(
            left: this.screenWidth * 0.05,
            right: this.screenWidth * 0.05,
          ),
          child: busIconBefore, //busRideState ? busIconAfter : busIconBefore,
        ),

        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(outPutBus.type,
              style: busTextStyleType,),

            outPutBus.side != null ?
            Text(
              "${outPutBus.number} ${outPutBus.side} 번",
              style: busTextStyleNumber,) :
            Text("${outPutBus.number} 번",
              style: busTextStyleNumber,),
          ],
        ),
      ],),
    );
  }
}

class containerRound extends StatelessWidget{
  containerRound({
    @required this.screenHeight,
    @required this.screenWidth,
    @required this.header,
    @required this.persent,
  });
  final double screenWidth;
  final double screenHeight;
  final String header;
  final double persent;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenWidth,
      height: screenHeight,
      child: Center(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Colors.grey,
            ),
          ),
          width: screenWidth * persent,
          height: screenHeight* persent,
        ),
      ),
    );
  }
}