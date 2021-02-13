import 'package:flutter/material.dart';
import 'package:custom_timer/custom_timer.dart';

import './mode.dart';

class Content extends StatefulWidget {
  final String onMode;
  final Function chooseMode;

  Content({
    @required this.chooseMode,
    @required this.onMode,
  });

  @override
  _ContentState createState() => _ContentState();
}

class _ContentState extends State<Content> {
  var _controller = {
    'Pomodoro': new CustomTimerController(),
    'Short Break': new CustomTimerController(),
    'Long Break': new CustomTimerController(),
  };

  Map<String, CustomTimer> timer;

  @override
  void initState() {
    super.initState();
    timer = {
      'Pomodoro': CustomTimer(
        controller: _controller['Pomodoro'],
        from: Duration(minutes: 25),
        to: Duration(minutes: 0),
        builder: (CustomTimerRemainingTime remaining) {
          return Text(
            "${remaining.minutes}:${remaining.seconds}",
            style: TextStyle(
              fontSize: 120.0,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          );
        },
      ),
      'Short Break': CustomTimer(
        controller: _controller['Short Break'],
        from: Duration(minutes: 5),
        to: Duration(minutes: 0),
        builder: (CustomTimerRemainingTime remaining) {
          return Text(
            "${remaining.minutes}:${remaining.seconds}",
            style: TextStyle(
              fontSize: 120.0,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          );
        },
      ),
      'Long Break': CustomTimer(
        controller: _controller['Long Break'],
        from: Duration(minutes: 15),
        to: Duration(minutes: 0),
        builder: (CustomTimerRemainingTime remaining) {
          return Text(
            "${remaining.minutes}:${remaining.seconds}",
            style: TextStyle(
              fontSize: 120.0,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          );
        },
      ),
    };
  }

  var buttonText = 'Start';

  void changeButtonText() {
    setState(() {
      buttonText = buttonText == 'Start' ? 'Stop' : 'Start';
    });
  }

  void _resetTimer() {
    setState(() {
      buttonText = 'Start';
    });
    _controller[widget.onMode].reset();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: 40,
      ),
      width: MediaQuery.of(context).size.width * 0.8,
      height: MediaQuery.of(context).size.width * 0.5,
      color: Color(widget.onMode == 'Pomodoro'
          ? 0xFFDF645F
          : widget.onMode == 'Short Break'
              ? 0xFF599A9C
              : 0xFF568BB1),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          // Choosing mode for work or break
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Mode(
                onMode: widget.onMode,
                mode: 'Pomodoro',
                chooseMode: widget.chooseMode,
                resetTimer: _resetTimer,
              ),
              Mode(
                onMode: widget.onMode,
                mode: 'Short Break',
                chooseMode: widget.chooseMode,
                resetTimer: _resetTimer,
              ),
              Mode(
                onMode: widget.onMode,
                mode: 'Long Break',
                chooseMode: widget.chooseMode,
                resetTimer: _resetTimer,
              ),
            ],
          ),
          Stack(
            children: [
              Visibility(
                child: timer['Pomodoro'],
                visible: widget.onMode == 'Pomodoro' ? true : false,
              ),
              Visibility(
                child: timer['Short Break'],
                visible: widget.onMode == 'Short Break' ? true : false,
              ),
              Visibility(
                child: timer['Long Break'],
                visible: widget.onMode == 'Long Break' ? true : false,
              ),
            ],
          ),
          
          // Button for start timer and stop timer
          ElevatedButton(
            child: Text(
              buttonText,
              style: TextStyle(
                color: Color(0xFFDB524D),
                fontSize: 24,
              ),
            ),
            onPressed: () {
              _controller[widget.onMode].state == CustomTimerState.counting
                  ? _controller[widget.onMode].pause()
                  : _controller[widget.onMode].start();
              changeButtonText();
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.white,
              minimumSize: Size(200, 60),
            ),
          ),
        ],
      ),
    );
  }
}
