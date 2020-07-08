import 'package:flutter/material.dart';
import 'package:foodDelivery/styling.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double size;
  final double letterSpacing;
  final Color color;
  final FontWeight fontWeight;
  final TextOverflow overflow;
  final double maxLines;

  const CustomText({Key key, @required this.text, this.size, this.color, this.fontWeight, this.letterSpacing, this.overflow, this.maxLines})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines??1,
      overflow: overflow ?? TextOverflow.fade,
      style: TextStyle(
          fontSize: size ?? 13,
          color: color ?? black,
          fontWeight: fontWeight ?? FontWeight.normal,
          letterSpacing: letterSpacing ?? 1),
    );
  }
}
