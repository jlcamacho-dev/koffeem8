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
  int tCounter = 0;
  var _ratio = 16.0;
  var _txtCoffee = TextEditingController();
  var _txtWater = TextEditingController();
  var _txtTimer = TextEditingController();

  // variable to walk through the brewing process
  var tempStr = 'Lets Brew!';

  // control for image
  int _bNum = 1;

  // variable for dropdown menu
  String dropdownValue = '1:16';

  // logic for timer begins here
  Timer _timer; // timer object
  int _start = 300; // default time in seconds
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
            _start = 300;
          } else {
            _start = _start - 1;
            tCounter += 1;
            tempStr = brewGuide(tCounter, _bNum, _gCoffee, _gWater);
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
                  child: ReusableCard(
                    cardChild: Column(
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _bNum += 1;
                              if (_bNum == 4) {
                                _bNum = 1;
                              }
                              dropdownValue =
                                  _bNum == 1 ? '1:15' : dropdownValue;
                              dropdownValue =
                                  _bNum == 2 ? '1:17' : dropdownValue;
                              dropdownValue =
                                  _bNum == 3 ? '1:16' : dropdownValue;
                            });
                          },
                          child: Center(
                            child: Image(
                              image: AssetImage('images/BrewMethod$_bNum.png'),
                              height: 125.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: ReusableCard(
                    cardChild: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 30.0,
                        ),
                        Container(
                          child: Text(
                            'Ratio',
                            style: TextStyle(
                              fontSize: 20.0,
                            ),
                          ),
                        ),
                        Container(
                          height: 70.0,
                          width: 100.0,
                          //dropdown menu goes here
                          child: Center(
                            child: DropdownButton<String>(
                              value: dropdownValue,
                              icon: Icon(Icons.arrow_downward),
                              iconSize: 24,
                              elevation: 16,
                              style: TextStyle(
                                color: Colors.deepPurple,
                                fontSize: 35,
                              ),
                              underline: Container(
                                height: 3,
                                color: Colors.deepPurpleAccent,
                              ),
                              onChanged: (String newValue) {
                                setState(() {
                                  dropdownValue = newValue;
                                  print(dropdownValue);
                                });
                              },
                              items: <String>[
                                '1:12',
                                '1:13',
                                '1:14',
                                '1:15',
                                '1:16',
                                '1:17',
                                '1:18',
                                '1:19',
                                '1:20'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    style: TextStyle(
                                      fontSize: 30.0,
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
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
                        Container(
                          height: 120.0,
                          width: 135.0,
                          child: Center(
                            child: TextField(
                              style: TextStyle(
                                fontSize: 30.0,
                              ),
                              textAlign: TextAlign.center,
                              controller: _txtCoffee,
                              onChanged: (text) {
                                _gCoffee = double.parse(text);
                                _ratio = strToNum(dropdownValue);
                                _gWater = _gCoffee * _ratio;
                                _gWater = _gWater.abs();
                                _txtWater.text = _gWater.toStringAsFixed(2);
                              },
                              decoration:
                                  InputDecoration(labelText: 'Coffee (g)'),
                              keyboardType: TextInputType.numberWithOptions(
                                  decimal: true),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: ReusableCard(
                    cardChild: Column(
                      children: <Widget>[
                        Container(
                          height: 120.0,
                          width: 130.0,
                          child: Center(
                            child: TextField(
                              style: TextStyle(
                                fontSize: 30.0,
                              ),
                              textAlign: TextAlign.center,
                              controller: _txtWater,
                              onChanged: (text) {
                                _gWater = double.parse(text);
                                _ratio = strToNum(dropdownValue);
                                _gCoffee = _gWater / _ratio;
                                _gCoffee = _gCoffee.abs();
                                _txtCoffee.text = _gCoffee.toStringAsFixed(2);
                              },
                              decoration:
                                  InputDecoration(labelText: 'Water (g)'),
                              keyboardType: TextInputType.numberWithOptions(
                                  decimal: true),
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
          Expanded(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: ReusableCard(
                    cardChild: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 20.0,
                        ),
                        Container(
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Text(
                              formatHHMMSS(_start),
                              style: TextStyle(
                                fontSize: 60.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 40.0,
                          child: Text(
                            '$tempStr',
                            style: TextStyle(fontSize: 20),
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
                color: Colors.green,
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
                color: Colors.red,
                width: 205.0,
                height: 100.0,
                child: FlatButton(
                    onPressed: () {
                      setState(() {
                        _timer.cancel();
                        _start = 300;
                        _bState = 'Start';
                        tCounter = 0;
                        tempStr = 'Lets Brew!';
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
        color: Colors.lightGreen,
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

// method to convert selected ratio to a double
double strToNum(String sVal) {
  String accum = '';
  for (int i = 0; i < sVal.length; i++) {
    if (sVal[i] == ':') {
      accum += sVal[i + 1];
      accum += sVal[i + 2];
    }
  }
  var nRatio = double.parse(accum);
  return nRatio;
}

String brewGuide(int tElapsed, int method, [double _gco = 0, double _gwa = 0]) {
  double _ib = 2 * _gco;
  double _rm = _gwa - _ib;
  String _rms = _rm.toStringAsFixed(2);
  if (method == 1) {
    if (tElapsed <= 30) {
      return 'Bloom - Pour $_ib g of water';
    } else if (tElapsed <= 60) {
      return 'Pour reaminin water - $_rms g';
    } else if (tElapsed <= 270) {
      return 'Let it steep!';
    } else if (tElapsed <= 300) {
      return 'Plunge and Enjoy!';
    }
  }
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
