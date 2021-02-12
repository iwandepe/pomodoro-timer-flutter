import 'package:flutter/material.dart';
import 'dart:async';

import './utils.dart';

class Content extends StatefulWidget {
  @override
  _ContentState createState() => _ContentState();
}

class _ContentState extends State<Content> {

  var _mode = 'pomodoro';

  void _chooseMode(String mode){
    setState(() {
      _mode = mode;
      print(_mode);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: 40,
      ),
      width: MediaQuery.of(context).size.width * 0.8,
      height: MediaQuery.of(context).size.width * 0.5,
      color: Color(0xFFDF645F),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,

        children: [

          // Choosing mode for work or break
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(
                  left: 3,
                  right: 3,
                ),
                child: FlatButton(
                  onPressed: () => _chooseMode('pomodoro'),
                  child: Text(
                    'Pomodoro',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  color: (_mode == 'pomodoro') ? Color(0xFFBE5551) : Colors.transparent,
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  left: 3,
                  right: 3,
                ),
                child: FlatButton(
                  onPressed: () => _chooseMode('short-break'),
                  child: Text(
                    'Short Break',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  color: (_mode == 'short-break') ? Color(0xFFBE5551) : Colors.transparent,
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  left: 3,
                  right: 3,
                ),
                child: FlatButton(
                  onPressed: () => _chooseMode('long-break'),
                  child: Text(
                    'Long Break',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  color: (_mode == 'long-break') ? Color(0xFFBE5551) : Colors.transparent,
                ),
              ),
            ],
          ),

          // Display count down timer
          CountDownFormatted(
            duration: Duration(seconds: 120),
            builder: (BuildContext ctx, String remaining) {
              return Text(
                remaining,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 120,
                  fontWeight: FontWeight.bold,
                ),
              );
            },
          ),

          // Button for start timer and stop timer
          ElevatedButton(
            onPressed: () {},
            child: Text(
              'Start',
              style: TextStyle(
                color: Color(0xFFDB524D),
                fontSize: 24,
              ),
            ),
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

class CountDown extends StatefulWidget {
  const CountDown({
    Key key,
    @required this.duration,
    @required this.builder,
    this.onFinish,
    this.interval = const Duration(seconds: 1),
  }) : super(key: key);

  final Duration duration;
  final Duration interval;
  final void Function() onFinish;
  final Widget Function(BuildContext context, Duration remaining) builder;
  @override
  _CountDownState createState() => _CountDownState();
}

class _CountDownState extends State<CountDown> {
  Timer _timer;
  Duration _duration;
  @override
  void initState() {
    _duration = widget.duration;
    startTimer();

    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void startTimer() {
    _timer = Timer.periodic(widget.interval, timerCallback);
  }

  void timerCallback(Timer timer) {
    setState(() {
      if (_duration.inSeconds == 0) {
        timer.cancel();
        if (widget.onFinish != null) widget.onFinish();
      } else {
        _duration = Duration(seconds: _duration.inSeconds - 1);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, _duration);
  }
}

class CountDownFormatted extends StatelessWidget {
  const CountDownFormatted({
    Key key,
    @required this.duration,
    @required this.builder,
    this.onFinish,
    this.interval = const Duration(seconds: 1),
    this.formatter,
  }) : super(key: key);

  final Duration duration;
  final Duration interval;
  final void Function() onFinish;

  final String Function(Duration) formatter;

  final Widget Function(BuildContext context, String remaining) builder;

  Function(Duration) _formatter() {
    if (formatter != null) return formatter;
    // if (duration.inHours >= 1) return formatByHours;
    if (duration.inMinutes >= 1) return formatByMinutes;

    return formatBySeconds;
  }

  @override
  Widget build(BuildContext context) {
    return CountDown(
        interval: interval,
        onFinish: onFinish,
        duration: duration,
        builder: (BuildContext ctx, Duration remaining) {
          return builder(ctx, _formatter()(remaining));
        });
  }
}
