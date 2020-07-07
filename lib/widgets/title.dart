import 'package:flutter/material.dart';
import 'package:foodDelivery/styling.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double size;
  final double letterSpacing;
  final Color color;
  final FontWeight fontWeight;

  const CustomText({Key key, @required this.text, this.size, this.color, this.fontWeight, this.letterSpacing}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: size ?? 13,
        color: color ?? black,
        fontWeight: fontWeight ?? FontWeight.normal,
        letterSpacing: letterSpacing??1
      ),
    );
  }
}
