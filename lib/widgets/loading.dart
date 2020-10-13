
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../styling.dart';
import 'customText.dart';

class Loading extends StatelessWidget {
  final String text;

  const Loading({Key key, this.text}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: white.withOpacity(.7),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SpinKitFadingCircle(color: black, size: 25),
          SizedBox(height: 10),
          CustomText(text: text ?? '', letterSpacing: .3, fontWeight: FontWeight.w500, size: 15)
        ],
      ),
    );
  }
}
