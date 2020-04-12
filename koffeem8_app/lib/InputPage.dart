import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  var _sState = 'Start';
  double _gCoffee;
  double _gWater;
  double _ratio = 0.0625;
  var _txtCoffee = TextEditingController();
  var _txtWater = TextEditingController();

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
                  child: ReusableCard(),
                ),
              ],
            ),
          ),
          Container(
            color: Colors.teal,
            margin: EdgeInsets.only(top: 10.0),
            width: double.infinity,
            height: 100.0,
            child: Center(
              child: Text(
                _sState,
                style: TextStyle(
                  fontSize: 40.0,
                ),
              ),
            ),
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

// Custom Form Widget definition
class MyCustomForm extends StatefulWidget {
  @override
  _MyCustomFormState createState() => _MyCustomFormState();
}

// Corresponding State class
// This class holds the data related to the form
class _MyCustomFormState extends State<MyCustomForm> {
  // Create a text controller and use it to retrieve the current value
  // of the TextFeild
  final myController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
