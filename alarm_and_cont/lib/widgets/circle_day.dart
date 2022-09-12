import 'package:flutter/material.dart';

Widget circleDay(day, context, selected){
  return Container(
    width: 65.0,
    height: 65.0,
    decoration: BoxDecoration(
      color: (selected)?Theme.of(context).backgroundColor:Color(0xFFF1CBB5),
      borderRadius: BorderRadius.circular(100.0)
    ),
    child: Padding(
      padding: EdgeInsets.all(5.0),
      child: Center(
        child: Text(
          day,
          style: TextStyle(
            color: Color(0xFF356D65),
            fontSize: 21.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    )
  );
}