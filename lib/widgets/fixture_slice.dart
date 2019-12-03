import 'package:flutter/material.dart';

class FixtureSlice extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: ChipCustomClipper(),
      child: Container(
        height: 400,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [Colors.deepOrangeAccent, Colors.deepOrange])
        ),
      ),
    );
  }
}

class ChipCustomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height * 0.8);
    path.lineTo(size.width, size.height * 0.2);
    path.lineTo(size.width, 0);



    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}