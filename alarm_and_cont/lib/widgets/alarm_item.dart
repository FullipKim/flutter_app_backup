import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget alarmItem(hour, enabled){
  return Padding(
    padding: EdgeInsets.all(20.0),
    child: Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(hour, style: TextStyle(
                  color: Color(0xFF356D65),
                  fontSize: 50.0,
                  fontWeight: FontWeight.bold,
                ),),
                Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Text('Sun', style: TextStyle(
                        color: Color(0xFF356D65),
                        fontSize: 20.0,
                        fontWeight: FontWeight.w400
                      ),),
                    ),
                    Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Text('Mon', style: TextStyle(
                        color: Color(0xFF356D65),
                        fontSize: 20.0,
                        fontWeight: FontWeight.w400
                      ),),
                    ),
                    Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Text('Tue', style: TextStyle(
                        color: Color(0xFF356D65),
                        fontSize: 20.0,
                        fontWeight: FontWeight.w400
                      ),),
                    )
                  ],
                ),                                
              ],
            ),
            CupertinoSwitch(
              value: enabled,
              onChanged: (bool val) {
                print(val);
              },                    
              activeColor: Color(0xFF356D65),
            ),
          ],
        ),
        SizedBox(height: 10.0,),
        SizedBox(
          height: 2.0,
          width: double.maxFinite,
          child: Container(
            color: Colors.white38,
          ),
        )
      ],
    ),
  );
}