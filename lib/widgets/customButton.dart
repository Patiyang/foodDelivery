import 'package:flutter/material.dart';
import 'package:foodDelivery/styling.dart';
import 'customText.dart';

///like all the widgets in ths folder, these widgets are meant to make deisgn easier
///rather than repeading the same widget over and over again, I utilize these instead
class CustomButton extends StatefulWidget {
  final VoidCallback callback;
  final icon;
  final String text;
  final Color color;
  final double size;
  final ShapeBorder shape;

  const CustomButton(
      {Key key, @required this.callback, @required this.icon, @required this.text, this.color, this.size, this.shape})
      : super(key: key);

  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      shape: widget.shape,
      splashColor: orange,
      onPressed: widget.callback,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Icon(
            widget.icon,
            color: widget.color,
          ),
          CustomText(
            text: widget.text,
            color: widget.color,
            fontWeight: FontWeight.normal,
            size: widget.size ?? 13,
          ),
        ],
      ),
    );
  }
}

class CustomFlatButton extends StatelessWidget {
  final String text;
  final Color color;
  final Color textColor;
  final VoidCallback callback;
  // final ShapeBorder shape;
  final double height;
  final double width;
  final double radius;
  final Widget child;
  final double fontSize;

  const CustomFlatButton(
      {Key key, this.text, this.color, this.callback, this.textColor, this.height, this.width, this.radius, this.child, this.fontSize})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      height: height ?? 45,
      minWidth: width ?? 300,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(radius))),
      onPressed: callback,
      color: color ?? orange,
      child:child?? CustomText(text: text ?? '', color: textColor, size:fontSize ,),
    );
  }
}
