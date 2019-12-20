import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';

class FlareErrorWidget extends StatefulWidget {
  final String message;

  FlareErrorWidget(this.message);

  @override
  _FlareErrorWidgetState createState() => _FlareErrorWidgetState();
}

class _FlareErrorWidgetState extends State<FlareErrorWidget> {
  String _flareFile = 'assets/flare/heart.flr';
  String _flareAnimation = 'Heart Break';

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width * 0.8,
          height: 300,
          child: FlareActor(
            _flareFile,
            alignment: Alignment.center,
            fit: BoxFit.contain,
            animation: _flareAnimation,
            callback: (_) {
              setState(() {
                _flareFile = "assets/flare/empty.flr";
                _flareAnimation = 'empty';
              });
            },
          ),
        ),
        SizedBox(height: 20),
        Text(
          widget.message ?? 'Can\'t get data now',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.black, fontSize: 24),
        )
      ],
    );
  }
}
