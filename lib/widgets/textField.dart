import 'package:flutter/material.dart';

import '../styling.dart';

class CustomTextField extends StatelessWidget {
  final String hint;
  final iconOne;
  final iconTwo;
  final Color containerColor;
  final Color hintColor;
  final TextEditingController controller;
  final bool obscure;
  final TextInputType textInputType;
  final TextAlign align;
  final double radius;
//validator components
  final validator;
  const CustomTextField(
      {Key key,
      this.hint,
      this.iconOne,
      this.iconTwo,
      this.containerColor,
      this.hintColor,
      this.controller,
      this.validator,
      this.obscure,
      this.textInputType,
      this.align,
      @required this.radius})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(radius)), boxShadow: [
        BoxShadow(blurRadius: 0, color: containerColor ?? white, spreadRadius: 0),
      ]),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 11),
        width: MediaQuery.of(context).size.width,
        child: TextFormField(
          textAlign: align ?? TextAlign.center,
          keyboardType: textInputType,
          obscureText: obscure ?? false,
          validator: validator,
          controller: controller,
          style: TextStyle(color: black),
          cursorColor: black,
          decoration: InputDecoration(
            // icon: Icon(iconOne),
            // prefixIcon: Icon(iconOne),
            // suffixIcon: Icon(iconTwo),
            border: InputBorder.none,
            hintText: hint,
            hintStyle: TextStyle(color: hintColor ?? grey),
          ),
        ),
      ),
    );
  }
}
