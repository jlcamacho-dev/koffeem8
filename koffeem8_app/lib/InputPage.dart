import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';

class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  String _sStateStart = 'Start';
  String _sStateStop = 'Stop';
  String _sState = 'Start';
  double _gCoffee;
  double _gWater;
  double _ratio = 0.0625;
  var _txtCoffee = TextEditingController();
  var _txtWater = TextEditingController();
  var _txtTimer = TextEditingController();

  // logic for timer begins here
  Timer _timer; // timer object
  int _start = 120; // default time in seconds
  var _bState = 'Start'; // status for start /time button

  void startTimer({String status = 'nil'}) {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          if (_start < 1 || status == 'Stop') {
            timer.cancel();
            _bState = 'Start';
            _start = 120;
          } else {
            _start = _start - 1;
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('Koffee M8'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: ReusableCard(),
                ),
                Expanded(
                  child: ReusableCard(),
                )
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: ReusableCard(
                    cardChild: Column(
                      children: <Widget>[
                        TextFormField(
                          controller: _txtCoffee,
                          onChanged: (text) {
                            _gCoffee = double.parse(text);
                            _gWater = _gCoffee * _ratio;
                            _txtWater.text = _gWater.toString();
                          },
                          decoration:
                              InputDecoration(labelText: 'grams of coffee'),
                          keyboardType:
                              TextInputType.numberWithOptions(decimal: true),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: ReusableCard(
                    cardChild: Column(
                      children: <Widget>[
                        TextField(
                          controller: _txtWater,
                          onChanged: (String str) {
                            print(str);
                          },
                          decoration:
                              InputDecoration(labelText: 'grams of water'),
                          keyboardType:
                              TextInputType.numberWithOptions(decimal: true),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: ReusableCard(
                    cardChild: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 40.0,
                        ),
                        Container(
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Text(
                              formatHHMMSS(_start),
                              style: TextStyle(
                                fontSize: 40.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: <Widget>[
              Container(
                color: Colors.teal,
                width: 205.0,
                height: 100.0,
                child: FlatButton(
                    onPressed: () {
                      setState(() {
//                        _sState = _sState == 'Start' ? 'Stop' : 'Start';
                        if (_bState == 'Start') {
                          startTimer();
                          _bState = 'Stop';
                        } else if (_bState == 'Stop') {
                          _timer.cancel();
                          _bState = 'Start';
                        }
                      });
                    },
                    child: Text(_bState.toString(),
                        style: TextStyle(fontSize: 40.0, color: Colors.white))),
              ),
              Container(
                color: Colors.teal,
                width: 205.0,
                height: 100.0,
                child: FlatButton(
                    onPressed: () {
                      setState(() {
                        _timer.cancel();
                        _start = 120;
                        _bState = 'Start';
                      });
                    },
                    child: Text('Reset',
                        style: TextStyle(fontSize: 40.0, color: Colors.white))),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ReusableCard extends StatelessWidget {
  ReusableCard({this.color, this.cardChild});

  final Color color;
  final Widget cardChild;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: cardChild,
      margin: EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        color: Colors.green[500],
        borderRadius: BorderRadius.circular(10.0),
      ),
    );
  }
}

// formats seconds into a Hours/Minutes/Seconds string
String formatHHMMSS(int seconds) {
  int hours = (seconds / 3600).truncate();
  seconds = (seconds % 3600).truncate();
  int minutes = (seconds / 60).truncate();

  String hoursStr = (hours).toString().padLeft(2, '0');
  String minutesStr = (minutes).toString().padLeft(2, '0');
  String secondsStr = (seconds % 60).toString().padLeft(2, '0');

  if (hours == 0) {
    return "$minutesStr:$secondsStr";
  }

  return "$hoursStr:$minutesStr:$secondsStr";
}

//Container(
//color: Colors.teal,
//margin: EdgeInsets.only(top: 10.0),
//width: double.infinity,
//height: 100.0,
//child: FlatButton(
//onPressed: () {
//setState(() {
//_sState = _sState == 'Start' ? 'Stop' : 'Start';
//});
//},
//child: Center(
//child: Text(
//_sState.toString(),
//style: TextStyle(
//fontSize: 40.0,
//),
//),
//),
//),
//),
