import 'package:flutter/material.dart';
import 'InputPage.dart';

void main() => runApp(KoffeeCalc());

class KoffeeCalc extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.green[800],
        scaffoldBackgroundColor: Colors.green[800],
      ),
      home: InputPage(),
    );
  }
}
