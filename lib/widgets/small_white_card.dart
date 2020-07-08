import 'package:flutter/material.dart';

class SmallWhiteCard extends StatelessWidget {
  final Widget childWidget;
  final double width;
  final double height;

  SmallWhiteCard({
    @required this.childWidget,
    @required this.height,
    @required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        padding: EdgeInsets.all(20),
        height: height,
        width: width,
        child: childWidget);
  }
}
