import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:foodDelivery/styling.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: white.withOpacity(.9),
      child: SpinKitFadingCircle(
        color: black,
        size: 25,
      ),
    );
  }
}
