import 'package:flutter/material.dart';

class FormRow extends StatelessWidget {
  final String _pattern;

  FormRow(this._pattern);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: _pattern
          .split('')
          .map(
            (String sub) => Tooltip(
              message: sub == 'W'
                  ? 'Win'
                  : sub == 'L' ? 'Lose' : 'Draw',
              decoration: BoxDecoration(color: Colors.deepOrangeAccent,borderRadius: BorderRadius.circular(8)),
              child: Container(
                width: 35,
                height: 35,
                child: Center(
                  child: Text(
                    sub,
                    style: TextStyle(color: Colors.white),
                  ),
                ),

                margin: EdgeInsets.all(4),
                decoration: BoxDecoration(
                    color: sub == 'W'
                        ? Colors.green
                        : sub == 'L' ? Colors.redAccent : Colors.blue,
                    borderRadius: BorderRadius.circular(8)),
              ),
            ),
          )
          .toList(),
    );
  }
}
