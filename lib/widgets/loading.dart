import 'package:flutter/material.dart';
import 'package:foodDelivery/styling.dart';
import 'package:foodDelivery/widgets/customText.dart';

class Loading extends StatelessWidget {
  final String text;

  const Loading({Key key, this.text}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(alignment: Alignment.center,
      width: MediaQuery.of(context).size.width,
      color: white.withOpacity(.3),
      child: Column(mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CircularProgressIndicator(),
          SizedBox(
            height: 10,
          ),
          CustomText(text: text ?? 'Loading...')
        ],
      ),
    );
  }
}
