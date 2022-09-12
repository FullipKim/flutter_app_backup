import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart'; //설치가안되있넹..
import 'shapes_painter.dart';
import 'widgets/alarm_item.dart';
//필요한 패키지 전부 불러옴

class Home extends StatefulWidget { //home 클래스 생성
  Home({Key key}) : super(key: key);

  _HomeState createState() => _HomeState(); //라우트 경로 설정
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin{

  String _timeString;
  TabController _tabController; // 홈스테이트 클래스 생성, 같이 갈 친구들 선언

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this, initialIndex: 0);
    _tabController.addListener(_handleTabIndex);

    _timeString = _formatDateTime(DateTime.now());
   Timer.periodic(Duration(seconds: 1), (Timer t) => _getTime());
  } // 탭컨트롤러랑 타임스트링에 관한 기본적인 지정

   @override
  void dispose() {
    _tabController.removeListener(_handleTabIndex);
    _tabController.dispose();
    super.dispose(); //오버라이드로 dispose 선언
  }

  void _handleTabIndex() {
    setState(() {}); // 인덱스 탭 조작부분 선언
  }

  void _getTime() {
    final DateTime now = DateTime.now();
    final String formattedDateTime = _formatDateTime(now);
    setState(() {
      _timeString = formattedDateTime;
    }); //시간 갖고와서 문자열포매팅해서 저장해주는 함수
  }

  String _formatDateTime(DateTime dateTime) {
    return DateFormat('hh:mm').format(dateTime); //데이트타임을 시간:분 형식의 문자열으로 리턴하는 함수
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController( //스크린을 탭컨트롤러 위젯으로 구성함
        length: 2, //탭의 수 설정 4개에서 2개로 변경
        child: Scaffold( //위젯을 세로로 나누었고
          appBar: PreferredSize( //앱바 생성
            preferredSize: Size.fromHeight(100.0), //높이는 위에서 100만큼
            child: Container( //자식 컨테이너 생성
              padding: EdgeInsets.only(top:20), // 탑에만 패딩 30줌
              color: Theme.of(context).primaryColor, //앱바컨테이너는 프라이머리컬러로 ㄱㄱ
              child: TabBar( //자식의 자식 컨테이너 생성함 - 탭바 생성
                controller: _tabController, //하위에 탭컨트롤러 1개더 생성함
                indicatorColor: Theme.of(context).colorScheme.secondary, //이것도 변경해줘야겠다..
                indicatorWeight: 2.0, // 4.0-> 2.0 수정 완
                tabs: [
                  Tab(icon: Icon(Icons.access_time), text: '현재시각',),
                  Tab(icon: Icon(Icons.alarm), text: '알리미목록'),
                  //Tab(icon: Icon(Icons.hourglass_empty), text: 'Timer'),
                  //Tab(icon: Icon(Icons.timer), text: 'Stopwatch'),
                ],
              ),
            ),
          ),
          body: Container(
            color: Theme.of(context).primaryColor,
            child: TabBarView( // 탭별 화면 보여주기!
              controller: _tabController,
              children: [ //여기서부터 탭1 화면 (디폴트) 코딩 시작
                Container(
                  child: Column(
                    children: <Widget>[  
                      Padding(
                        padding: EdgeInsets.fromLTRB(200, 70, 200, 15),
                        child: CustomPaint(
                          painter: ShapesPainter(), //아날로그시계 (쉐입페인터 다트파일에 있음)
                          child: Container(height: 600,),
                        ),
                      ),
                      Text(_timeString.toString(), style: TextStyle( //디지털 시계
                        color: Color(0xFF356D65),
                        fontSize: 100.0,
                        fontWeight: FontWeight.bold
                      ),)
                    ],
                  ),
                ),
                Container(
                  child: ListView( // 탭 2 화면 알람 위젯 리스트뷰
                    children: <Widget>[  
                      alarmItem(_timeString, true),
                      alarmItem(_timeString, false),
                    ],
                  ),
                ),
                //Icon(Icons.hourglass_empty), //지워도될듯 여기부터 지운탭임
                //Icon(Icons.timer), // ''
              ],
            ),
          ),
          floatingActionButton: _bottomButtons(), //바텀버튼위젯을 넣겠당!
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        ),
      );
  }

  Widget _bottomButtons() { //바텀버튼 위젯 선언.
    return _tabController.index == 1 //트루라면!
      ?FloatingActionButton(
        onPressed: () => Navigator.pushNamed(
            context,
            '/add-alarm' //누르면 알람추가화면으로 이동
        ), 
        backgroundColor: Color(0xFF356D65), //알람추가아이콘
        child: Icon(
          Icons.alarm_add,
          size: 30.0,
        ),
      )
      :null;
  }
}