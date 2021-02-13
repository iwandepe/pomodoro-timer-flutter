import 'package:flutter/material.dart';

class Mode extends StatelessWidget {
  final String onMode;
  final String mode;
  final Function chooseMode;
  final Function resetTimer;

  Mode({this.onMode, this.mode, this.chooseMode, this.resetTimer});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: 3,
        right: 3,
      ),
      child: FlatButton(
        onPressed: () {
          resetTimer();
          chooseMode(mode);
        },
        child: Text(
          mode,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        color: onMode == mode
            ? Color(mode == 'Pomodoro'
                ? 0xFFBE5551
                : mode == 'Short Break'
                    ? 0xFF4C8385
                    : 0xFF497697)
            : Colors.transparent,
      ),
    );
  }
}
