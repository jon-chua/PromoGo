import 'package:flutter/material.dart';

class WhiteCard extends StatelessWidget {
  final Widget childWidget;
  final double width;
  final double height;

  WhiteCard({
    @required this.width,
    @required this.height,
    @required this.childWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: childWidget,
    );
  }
}
