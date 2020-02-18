import 'package:flutter/material.dart';

// Starting point for all of our flutter apps
void main() {
  runApp(MaterialApp(
    home: Scaffold(
      backgroundColor: Colors.greenAccent,
      appBar: AppBar(
        title: Text('Köffem8'),
        backgroundColor: Colors.greenAccent,
      ),
      body: Center(
        child: Image(
          image: NetworkImage('https://i.imgur.com/lp9zM5K.png'),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: Text('Lets Brew!'),
        backgroundColor: Colors.red,
      ),
    ),
  ));
}
