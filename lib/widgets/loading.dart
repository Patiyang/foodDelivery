import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:foodDelivery/styling.dart';

class Loading extends StatelessWidget {
  final Color color;

  const Loading({Key key, this.color}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      color:color?? white.withOpacity(.9),
      child: SpinKitFadingCircle(
        color: black,
        size: 25,
      ),
    );
  }
}
