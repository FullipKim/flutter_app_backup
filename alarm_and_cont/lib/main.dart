import 'package:flutter/material.dart'; // 가장 기본적인 메테리얼 임포트
import 'package:flutter/cupertino.dart'; // cupertino : ShapeBorders 에서 생성된 NotchedShape 으로, 뒤로가기버튼을 지원한다. 왜인지 오류가난다. 추후 앱바 route설정으로 없애줄 예정이다.
import 'package:flutter/services.dart';
import 'package:intl/intl.dart'; //설치가안되있넹..
import 'shapes_painter.dart';
import 'widgets/alarm_item.dart';
import 'package:rxdart/rxdart.dart';
import 'package:univ_cont/routes.dart';
// import 'package:flutter_test/flutter_test.dart';
import 'AppColors.dart'; //다트 앱컬러 설정한 파일 임포트

void main() {
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  //여기가 앱의 루트페이지가 된다!
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '낫베드 컨트롤러',
      routes: Routes.routes,
      home: Scaffold(
        body: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  BehaviorSubject<int> willAcceptStream;

  Color background = AppColors.lightBackground;
  Color text = AppColors.lightText;
  Color select = AppColors.lightSelect;
  Color icon = AppColors.lightIcon;
  Color buttonBackground = AppColors.lightButtonBackground;
  Color iconButton = AppColors.lightIconButton; //재정의

  @override
  void initState() {
    willAcceptStream = new BehaviorSubject<int>();
    willAcceptStream.add(0);
    super.initState();
  }

  void _fuctionDrag(String msg) {
    final snackBar = SnackBar(
        content: Text('$msg'),
        behavior: SnackBarBehavior.floating,
        duration: Duration(milliseconds: 500));
    ScaffoldMessenger.of(context).showSnackBar(snackBar); //스낵바를 더이상 지원하지 않아서, scaffold 대신 scaffoldmessenger를 사용하여 처리했당
  } // 드래그함수

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size; //미디어쿼리

    return SafeArea(  //메인문이나 마찬가지
      child: Container(
        width: size.width,
        height: size.height,
        color: background,
        child: FittedBox(
          fit: BoxFit.contain,
          alignment: Alignment.center,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Container(
                  width: size.width,
                  height: size.height * 0.1,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(20,0,15,5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        RichText(
                          text: TextSpan(
                            text: '🏥낫베드',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: text,
                              fontSize: 30,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: '컨트롤러',
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  color: text,
                                  fontSize: 30,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Spacer(),
                        IconButton(   //페이지 추가 후 iconbotton으로 변경
                          icon: Icon(Icons.alarm),
                          color: select,hoverColor: iconButton,
                          onPressed: () {
                            Navigator.of(context).pushNamed(Routes.clock);
                        },
//                          Icons.alarm,
//                           color: select,
//                           size: 40,
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: size.width,
                  height: size.height * 0.11,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        width: size.height * 0.11,
                        height: size.height * 0.08,
                        child: Icon(
                          Icons.accessibility,
                          color: icon,
                          size: 36,
                        ),
                      ),
                      Container(
                          padding: EdgeInsets.all(2),
                          width: size.height * 0.11,
                          height: size.height * 0.08,
                          decoration: new BoxDecoration(
                            color: buttonBackground,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.airline_seat_recline_extra_outlined,
                            color: icon,
                            size: 36,
                          ),
                        ),
                      Container(
                        width: size.height * 0.11,
                        height: size.height * 0.08,
                        child: Icon(
                          Icons.airline_seat_legroom_extra,
                          color: icon,
                          size: 36,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: size.width,
                  height: size.height * 0.25,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Container(
                        width: size.width * 0.20,
                        height: size.height * 0.25,
                        decoration: new BoxDecoration(
                          color: buttonBackground,
                          borderRadius: new BorderRadius.all(
                            Radius.circular(40.0),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Icon(
                              Icons.rotate_90_degrees_ccw,
                              color: iconButton,
                              size: 38,
                            ),
                            Text(
                              "좌우자세전환",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: text,
                                fontSize: 16,
                              ),
                            ),
                            Icon(
                              Icons.rotate_90_degrees_cw,
                              color: iconButton,
                              size: 38,
                            ),
                          ],
                        ),
                      ),
                      Container(//컨트롤패널 추가
                        width: size.width * 0.20,
                        height: size.height * 0.25,
                        decoration: new BoxDecoration(
                          color: buttonBackground,
                          borderRadius: new BorderRadius.all(
                            Radius.circular(40.0),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Icon(
                              Icons.airline_seat_flat_angled_outlined,
                              color: iconButton,
                              size: 38,
                            ),
                            Text(
                              "환자일으켜기",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: text,
                                fontSize: 16,
                              ),
                            ),
                            Icon(
                              Icons.airline_seat_flat_outlined,
                              color: iconButton,
                              size: 38,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: size.width * 0.20,
                        height: size.height * 0.25,
                        decoration: new BoxDecoration(
                          color: buttonBackground,
                          borderRadius: new BorderRadius.all(
                            Radius.circular(40.0),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Icon(
                              Icons.airline_seat_recline_extra_outlined,
                              color: iconButton,
                              size: 38,
                            ),
                            Text(
                              "다리각도조절",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: text,
                                fontSize: 16,
                              ),
                            ),
                            Icon(
                              Icons.airline_seat_recline_normal_outlined,
                              color: iconButton,
                              size: 38,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: size.width,
                  height: size.height * 0.20,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                     Text("범퍼가드 컨트롤",
                       style: TextStyle(
                         fontWeight: FontWeight.bold,
                         color: text,
                         fontSize: 21,
                       ),)
                     ],
                  ),
                ),
                Container(
                  width: size.width,
                  height: size.height * 0.23,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      DragTarget(
                        builder: (context, list, list2) {
                          return Container(
                            padding: EdgeInsets.all(3),
                            width: size.width * 0.2,
                            height: size.width * 0.5,
                            child: Icon(
                              Icons.upload,
                              color: Color(0xFFE8594F),
                              size: 36,
                            ),
                          );
                        },
                        onWillAccept: (item) {
                          debugPrint('범퍼가드를 올렸습니다.');
                          this.willAcceptStream.add(-50);
                          _fuctionDrag("범퍼가드를 올렸습니다.");
                          return false;
                        },
                        onLeave: (item) {
                          debugPrint('리셋');
                          this.willAcceptStream.add(0);
                        },
                      ),
                      Container(
                        padding: EdgeInsets.all(2.5),
                        width: size.width * 0.5,
                        height: size.width * 0.5,
                        decoration: new BoxDecoration(
                          gradient: new LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Colors.transparent,
                              Colors.transparent,
                              Color(0xFF356D65),
                              Color(0xFFFFB491),
                              Color(0xFFE8594F)
                            ],
                          ),
                          shape: BoxShape.circle,
                        ),
                        child: Container(
                          padding: EdgeInsets.all(18),
                          width: size.width * 0.4,
                          height: size.width * 0.4,
                          decoration: new BoxDecoration(
                            color: background,
                            shape: BoxShape.circle,
                          ),
                          child: Draggable(
                            axis: Axis.horizontal,
                            feedback: StreamBuilder(
                              initialData: 0,
                              stream: willAcceptStream,
                              builder: (context, snapshot) {
                                return Container(
                                  width: size.width * 0.4,
                                  height: size.width * 0.4,
                                  decoration: new BoxDecoration(
                                    color: (snapshot.data) > 0
                                        ? Color(0xFF356D65)
                                        : (snapshot.data) == 0
                                            ? buttonBackground
                                            : Color(0xFFE8594F),
                                    shape: BoxShape.circle,
                                  ),
                                );
                              },
                            ),
                            childWhenDragging: Container(),
                            child: Container(
                              width: size.width * 0.4,
                              height: size.width * 0.4,
                              decoration: new BoxDecoration(
                                color: buttonBackground,
                                shape: BoxShape.circle,
                              ),
                            ),
                            onDraggableCanceled: (v, f) => setState(
                              () {
                                this.willAcceptStream.add(0);
                              },
                            ),
                          ),
                        ),
                      ),
                      DragTarget(
                        builder: (context, list, list2) {
                          return Container(
                            padding: EdgeInsets.all(3),
                            width: size.width * 0.2,
                            height: size.width * 0.5,
                            child: Icon(
                              Icons.download,
                              color: Color(0xFF356D65),
                              size: 36,
                            ),
                          );
                        },
                        onWillAccept: (item) {
                          debugPrint('범퍼가드를 내렸습니다.');
                          this.willAcceptStream.add(50);
                          _fuctionDrag("범퍼가드를 내렸습니다.");
                          return false;
                        },
                        onLeave: (item) {
                          debugPrint('리셋');
                          this.willAcceptStream.add(0);
                        },
                      ),
                    ],
                  ),
                ),
                Container(
                  width: size.width,
                  height: size.height * 0.20,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          InkWell(
                            onTap: () {
                              print("블루투스 아이콘 클릭");
                            },
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            child: Icon(
                              Icons.bluetooth_searching,
                              color: Color(0xFF584BD2),
                              size: 40,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              print("세팅 아이콘 클릭");
                            },
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            child: Icon(
                              Icons.dashboard_outlined,
                              color: icon,
                              size: 40,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ClockPage extends State<Home> with SingleTickerProviderStateMixin{

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