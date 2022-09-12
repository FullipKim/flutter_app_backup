import 'package:flutter/material.dart';
import 'widgets/circle_day.dart';

class AddAlarm extends StatefulWidget {
  AddAlarm({Key key}) : super(key: key);

  _AddAlarmState createState() => _AddAlarmState();
}

class _AddAlarmState extends State<AddAlarm> {

  TimeOfDay _selectedTime;
  ValueChanged<TimeOfDay> selectTime;

  @override
  void initState() {
     _selectedTime = new TimeOfDay(hour: 11, minute: 50);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF7ECDF),
      appBar: AppBar(
        toolbarHeight: 90.0,
        backgroundColor: Color(0xFFFFB491),
        title: Row(mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.alarm_add, color: Color(0xFF356D65),size: 36),
            Text(' 알림 추가하기', style: TextStyle(
              color: Color(0xFF356D65),
              fontSize: 28, fontWeight: FontWeight.bold
            ))
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Container(
          child: Column(
            children: <Widget>[
              SizedBox(height: 60.0,),
              new GestureDetector(
                child: Text(_selectedTime.format(context), style: TextStyle(
                  fontSize: 60.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF356D65),
                ),),
                onTap: () {
                  _selectTime(context);
                },
              ),
              SizedBox(height: 30.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  circleDay('Mon', context, false),
                  circleDay('Tue', context, true),
                  circleDay('Wed', context, true),
                  circleDay('Thu', context, true),
                  circleDay('Fri', context, false),
                  circleDay('Sat', context, true),
                  circleDay('Sun', context, false),
                ],
              ),
              SizedBox(height: 60.0,),
              SizedBox(height: 2.0, child: Container(color: Color(0xFFFFB491),),),
              ListTile(
                leading: Icon(Icons.notifications_none, color: Colors.black54,),
                title: Text('상단푸쉬알림', style: TextStyle(color: Colors.black54,fontWeight: FontWeight.w600)),
              ),
              SizedBox(height: 2.0, child: Container(color: Color(0xFFFFB491),),),
              ListTile(
                leading: Icon(Icons.check_box, color: Colors.black54,),
                title: Text('진동', style: TextStyle(color: Colors.black54,fontWeight: FontWeight.w600)),
              ),
              SizedBox(height: 2.0, child: Container(color: Color(0xFFFFB491),),),
              SizedBox(height: 60.0,),
              TextButton(onPressed: () => selectTime, child: null,),
            ],
          ),
        )
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () =>  Navigator.of(context).pop(),
        backgroundColor: Color(0xFF356D65),
        child: Icon(
          Icons.delete,
          size: 20.0,
          color:Theme.of(context).primaryColor,
        ),
      )
    );
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay picked =  await showTimePicker(
      context: context, 
      initialTime: _selectedTime
    );
    setState(() {
      _selectedTime = picked;
    });
  }
}