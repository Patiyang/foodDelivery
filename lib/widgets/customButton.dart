import 'package:flutter/material.dart';
import 'package:foodDelivery/styling.dart';
import 'customText.dart';

class CustomButton extends StatefulWidget {
  final VoidCallback callback;
  final icon;
  final String text;
  final Color color;
  final double size;

  const CustomButton({Key key, @required this.callback, @required this.icon, @required this.text, this.color, this.size})
      : super(key: key);

  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return FlatButton(
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
            size: widget.size??13,
          ),
        ],
      ),
    );
  }
}
