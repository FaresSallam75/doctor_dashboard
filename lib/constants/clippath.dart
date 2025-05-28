import 'package:flutter/material.dart';

class BackgroundCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();

    // Start from top-left
    path.lineTo(0, size.height * 0.75); // Go down the left side part way

    // Define the curve (adjust control points for desired shape)
    var controlPoint1 = Offset(
      size.width * 0.2,
      size.height,
    ); // Lower control point
    var endPoint1 = Offset(
      size.width * 0.5,
      size.height * 0.85,
    ); // Mid point of the curve
    path.quadraticBezierTo(
      controlPoint1.dx,
      controlPoint1.dy,
      endPoint1.dx,
      endPoint1.dy,
    );

    var controlPoint2 = Offset(
      size.width * 0.85,
      size.height * 0.65,
    ); // Upper control point
    var endPoint2 = Offset(
      size.width,
      size.height * 0.7,
    ); // End on the right side
    path.quadraticBezierTo(
      controlPoint2.dx,
      controlPoint2.dy,
      endPoint2.dx,
      endPoint2.dy,
    );

    // Go up the right side and close
    path.lineTo(size.width, 0);
    path.close(); // Connects back to (0,0) implicitly

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false; // No need to reclip if the clipper itself doesn't change
  }
}
