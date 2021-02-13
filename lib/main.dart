import 'package:flutter/material.dart';
import 'package:pomocus/timer.dart';

import './drawer.dart';
import './task.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pomodoro focus',
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  var _onMode = 'Pomodoro';

  void _chooseMode(String mode) {
    setState(() {
      _onMode = mode;
      print(_onMode);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: SettingDrawer(), 

      // Application bar
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "Pomodoro Timer",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Builder(
            builder: (context) => IconButton(
              icon: Icon(Icons.settings),
              onPressed: () => Scaffold.of(context).openEndDrawer(),
            ),
          ),
        ],
        backgroundColor: Color(_onMode == 'Pomodoro'
            ? 0xFFDB524D
            : _onMode == 'Short Break'
                ? 0xFF488E91
                : 0xFF437EA8),
      ),
      backgroundColor: Color(_onMode == 'Pomodoro'
          ? 0xFFDB524D
          : _onMode == 'Short Break'
              ? 0xFF488E91
              : 0xFF437EA8),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Display timer
            Content(
              onMode: _onMode,
              chooseMode: _chooseMode,
            ),

            // Display what is working
            Container(
              margin: EdgeInsets.only(
                top: 20,
                bottom: 20,
              ),
              child: Text(
                'Time to work!',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ),

            // Display task
            Task(),
          ],
        ),
      ),
    );
  }
}
